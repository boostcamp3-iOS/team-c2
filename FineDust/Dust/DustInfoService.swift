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
  
  /// `yyyy-MM-dd HH:mm` 형식으로 포매팅하는 데이트 포매터.
  private lazy var fullDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter
  }()
  
  /// `yyyy-MM-dd` 형식으로 포매팅하는 데이트 포매터.
  private lazy var halfDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  /// `HH` 형식으로 포매팅하는 데이트 포매터.
  private lazy var hourDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "HH"
    return formatter
  }()
  
  /// 미세먼지 매니저 프로토콜을 준수하는 프로퍼티.
  let dustInfoManager: DustInfoManagerType
  
  // MARK: Dependency Injection
  
  init(dustManager: DustInfoManagerType = DustInfoManager()) {
    self.dustInfoManager = dustManager
  }
  
  func fetchRecentTimeInfo(_ completion: @escaping (RecentDustInfo?, Error?) -> Void) {
    dustInfoManager
      .fetchDustInfo(
        term: .daily,
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
              ultrafineDustGrade: DustGrade(rawValue: recentResponse.ultrafineDustGrade) ?? .default,
              updatingTime: self.fullDateFormatter.date(from: recentResponse.dataTime) ?? Date()
            )
            completion(dustInfo, nil)
          }
    }
  }
  
  func fetchInfo(_ completion: @escaping (HourIntakePair?, HourIntakePair?, Error?) -> Void) {
    dustInfoManager
      .fetchDustInfo(
        term: .month,
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
            if let dataTimeToDate = self.fullDateFormatter.date(from: item.dataTime) {
              // 24:00 형식이 아니어서 데이트 파싱이 잘 되는 경우
              // 하던 대로 한다
              let hourToString = self.hourDateFormatter.string(from: dataTimeToDate)
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
          Hour.allCases.forEach { hour in
            if fineDust[hour] == nil {
              fineDust[hour] = 0
            }
            if ultrafineDust[hour] == nil {
              ultrafineDust[hour] = 0
            }
          }
          completion(fineDust, ultrafineDust, nil)
    }
  }
  
  func fetchInfo(
    from startDate: Date,
    to endDate: Date,
    completion: @escaping (DateHourIntakePair?, DateHourIntakePair?, Error?) -> Void
  ) {
    // 시작 날짜와 끝 날짜의 간격 구하기
    let calendar = Calendar.current
    let dateComponentBetweenDates
      = calendar.dateComponents([.day], from: startDate.start, to: endDate.start)
    let daysBetweenDates = dateComponentBetweenDates.day ?? 0
    //
    dustInfoManager
      .fetchDustInfo(
        term: .month,
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
            let currentStartDate: Date
            if let dataTimeToDate = self.fullDateFormatter.date(from: item.dataTime) {
              // 24:00 형식이 아니어서 데이트 파싱이 잘 되는 경우
              // 하던 대로 한다
              let hourToString = self.hourDateFormatter.string(from: dataTimeToDate)
              let hourToInt = Int(hourToString) ?? 0
              hour = Hour(rawValue: hourToInt) ?? .default
              currentStartDate = dataTimeToDate.start
            } else {
              // 24:00 이라서 데이트 파싱이 안되고 nil이 나오는 경우
              // 다음 날짜의 0시로 바꿔준다
              let halfDataTime = item.dataTime.components(separatedBy: " ").first ?? ""
              let halfDataTimeToDate = self.halfDateFormatter.date(from: halfDataTime)
              let nextHalfDataTime = halfDataTimeToDate?.after(days: 1)
              let nextMidnight = nextHalfDataTime?.start ?? Date()
              hour = Hour(rawValue: 0) ?? .default
              currentStartDate = nextMidnight
            }
            if !(startDate.start...endDate.start).contains(currentStartDate) { continue }
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
          completion(fineDustPerDate, ultrafineDustPerDate, nil)
    }
  }
}
