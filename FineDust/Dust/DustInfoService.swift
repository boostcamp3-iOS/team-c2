//
//  DustService.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 정보 서비스.
final class DustInfoService: DustInfoServiceType {
  
  // MARK: Property

  /// 미세먼지 매니저 프로토콜을 준수하는 프로퍼티.
  let dustInfoManager: DustInfoManagerType
  
  // MARK: Dependency Injection
  
  init(dustManager: DustInfoManagerType = DustInfoManager()) {
    self.dustInfoManager = dustManager
  }
  
  func requestRecentTimeInfo(_ completion: @escaping (RecentDustInfo?, Error?) -> Void) {
    dustInfoManager
      .request(
        dataTerm: .daily,
        numberOfRows: 1,
        pageNumber: 1) { response, error in
          if let error = error {
            completion(nil, error)
            return
          }
          if let recentResponse = response?.items.first {
            let dustInfo = RecentDustInfo(
              fineDustValue: recentResponse.fineDustValue,
              ultrafineDustValue: recentResponse.ultrafineDustValue,
              fineDustGrade: DustGrade(rawValue: recentResponse.fineDustGrade) ?? .default,
              ultrafineDustGrade: DustGrade(
                rawValue: recentResponse.ultrafineDustGrade) ?? .default,
              updatingTime: DateFormatter.dateAndTimeForDust
                .date(from: recentResponse.dataTime) ?? Date()
            )
            print("최신 대기 오염 데이터 가져오기 성공.")
            print(dustInfo)
            completion(dustInfo, nil)
          }
    }
  }
  
  func requestDayInfo(_ completion: @escaping (HourIntakePair?, HourIntakePair?, Error?) -> Void) {
    dustInfoManager
      .request(
        dataTerm: .month,
        numberOfRows: 24,
        pageNumber: 1) { response, error in
          var fineDust: HourIntakePair = [:]
          var ultrafineDust: HourIntakePair = [:]
          if let error = error {
            completion(nil, nil, error)
            return
          }
          guard let items = response?.items else { return }
          for item in items {
            let hour: Hour
            if let dataTimeToDate = DateFormatter.dateAndTimeForDust.date(from: item.dataTime) {
              let hourToString = DateFormatter.hour.string(from: dataTimeToDate)
              let hourToInt = Int(hourToString) ?? 0
              hour = Hour(rawValue: hourToInt) ?? .default
            } else {
              // 24:00 이라서 데이트 파싱이 안되고 nil이 나오는 경우
              // 이 메소드에서는 그냥 0시인 것처럼 처리하면 됨
              hour = Hour(rawValue: 0) ?? .default
            }
            fineDust[hour] = item.fineDustValue
            ultrafineDust[hour] = item.ultrafineDustValue
            // 0시에 대한 처리가 끝난 경우 반복문 탈출
            if hour == .zero { break }
          }
          // 딕셔너리의 길이를 맞추기 위한 코드
          Hour.allCases.filter { $0 != .default }.forEach { hour in
            if fineDust[hour] == nil {
              fineDust[hour] = 0
            }
            if ultrafineDust[hour] == nil {
              ultrafineDust[hour] = 0
            }
          }
          print("오늘 자정부터 현시각까지의 대기 오염 데이터 가져오기 성공.")
          print(fineDust)
          print(ultrafineDust)
          completion(fineDust, ultrafineDust, nil)
    }
  }
  
  func requestDayInfo(
    from startDate: Date,
    to endDate: Date,
    completion: @escaping (DateHourIntakePair?, DateHourIntakePair?, Error?) -> Void
  ) {
    // 시작 날짜와 끝 날짜의 간격 구하기
    let calendar = Calendar.current
    let daysBetweenDates
      = calendar.dateComponents([.day], from: startDate.start, to: endDate.start).day ?? 0
    dustInfoManager
      .request(
        dataTerm: .month,
        numberOfRows: (daysBetweenDates + 2) * 24,
        pageNumber: 1) { response, error in
          var fineDustPerDate: DateHourIntakePair = [:]
          var ultrafineDustPerDate: DateHourIntakePair = [:]
          if let error = error {
            completion(nil, nil, error)
            return
          }
          guard let items = response?.items else { return }
          for item in items {
            let hour: Hour
            // 현재 요소의 `dataTime`의 0시 날짜
            let currentStartDate: Date
            if let dataTimeToDate = DateFormatter.dateAndTimeForDust.date(from: item.dataTime) {
              // 24:00 형식이 아니어서 데이트 파싱이 잘 되는 경우
              // 하던 대로 한다
              //
              // dataTime에서 시간을 추출하고, 그것으로 `Hour` 열거형 인스턴스를 생성한다
              // 최종 결과 딕셔너리의 키값으로 쓰일 `Date`는 dataTime의 시작 날짜로 한다
              let hourToString = DateFormatter.hour.string(from: dataTimeToDate)
              let hourToInt = Int(hourToString) ?? 0
              hour = Hour(rawValue: hourToInt) ?? .default
              currentStartDate = dataTimeToDate.start
            } else {
              // 24:00 이라서 데이트 파싱이 안되고 nil이 나오는 경우
              // 다음 날짜의 0시로 바꿔준다
              //
              // 예를 들어 2019-01-01 24:00을 2019-01-02 00:00으로 바꿔주는 작업을 하는 것이다
              // 이를 위해 dataTime을 공백을 기준으로 잘라 yyyy-MM-dd 형식만을 취하고
              // 이 형식의 다음 날짜의 시작 날짜를 구하여 최종 결과 딕셔너리의 키값으로 활용한다
              // 이 경우 어차피 0시가 될 것이므로 `Hour` 열거형의 인스턴스는 원시값 0으로 생성한다
              let halfDataTime = item.dataTime.components(separatedBy: " ").first ?? ""
              let halfDataTimeToDate = DateFormatter.dateForDust.date(from: halfDataTime)
              let nextHalfDataTime = halfDataTimeToDate?.after(days: 1)
              let nextMidnight = nextHalfDataTime?.start ?? Date()
              hour = Hour(rawValue: 0) ?? .default
              currentStartDate = nextMidnight
            }
            // 인자로 들어온 Date의 구간 내에 포함되어 있지 않으면 필요 없으므로 continue
            if !(startDate.start...endDate.start).contains(currentStartDate) { continue }
            // 시작 날짜의 전날 시작 날짜와 현재 요소의 시작 날짜가 같으면 필요한 처리를 다 한 것이므로 break
            if startDate.before(days: 1).start == currentStartDate { break }
            if fineDustPerDate[currentStartDate] == nil {
              fineDustPerDate[currentStartDate] = [:]
            }
            fineDustPerDate[currentStartDate]?[hour] = item.fineDustValue
            if ultrafineDustPerDate[currentStartDate] == nil {
              ultrafineDustPerDate[currentStartDate] = [:]
            }
            ultrafineDustPerDate[currentStartDate]?[hour] = item.ultrafineDustValue
          }
          print("특정 기간 내의 대기 오염 데이터 가져오기 성공.")
          print(fineDustPerDate)
          print(ultrafineDustPerDate)
          completion(fineDustPerDate, ultrafineDustPerDate, nil)
    }
  }
}
