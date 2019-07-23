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
          // 미세먼지 응답 중 첫 번째가 최신 정보이므로
          // 첫 번째를 취하여 `RecentDustInfo`를 만들어 넘겨줌
          // 정보가 없으면 넘어온 에러를 넘겨줌
          guard let recentResponse = response?.items.first else {
            completion(nil, error)
            return
          }
          let dustInfo = RecentDustInfo(
            fineDustValue: recentResponse.fineDustValue,
            ultraFineDustValue: recentResponse.ultrafineDustValue,
            fineDustGrade: DustGrade(rawValue: recentResponse.fineDustGrade) ?? .default,
            ultraFineDustGrade: DustGrade(rawValue: recentResponse.ultrafineDustGrade) ?? .default,
            updatedTime: DateFormatter
              .dateTime.date(from: recentResponse.dataTime) ?? Date()
          )
          debugLog("최신 대기 오염 데이터 가져오기 성공.")
          debugLog(dustInfo)
          completion(dustInfo, nil)
    }
  }
  
  func requestDayInfo(_ completion: @escaping (HourIntakePair?, HourIntakePair?, Error?) -> Void) {
    dustInfoManager
      .request(
        dataTerm: .month,
        numberOfRows: 24,
        pageNumber: 1) { response, error in
          guard let items = response?.items else {
            completion(nil, nil, error)
            return
          }
          var hourlyFineDustIntake: HourIntakePair = [:]
          var hourlyUltrafineDustIntake: HourIntakePair = [:]
          for item in items {
            let (hour, isMidnight) = self.hourInDustDate(item.dataTime)
            hourlyFineDustIntake[hour] = item.fineDustValue
            hourlyUltrafineDustIntake[hour] = item.ultrafineDustValue
            if isMidnight { break }
          }
          // 딕셔너리에 들어오지 않은 Hour를 0으로 채워넣음
          hourlyFineDustIntake.padIfHourIsNotFilled()
          hourlyUltrafineDustIntake.padIfHourIsNotFilled()
          debugLog("오늘 자정부터 현시각까지의 대기 오염 데이터 가져오기 성공.")
          debugLog(hourlyFineDustIntake)
          debugLog(hourlyUltrafineDustIntake)
          completion(hourlyFineDustIntake, hourlyUltrafineDustIntake, nil)
    }
  }
  
  func requestDayInfo(
    from startDate: Date,
    to endDate: Date,
    completion: @escaping (DateHourIntakePair?, DateHourIntakePair?, Error?) -> Void) {
    // 시작 날짜와 끝 날짜의 간격 구하기
    let calendar = Calendar.current
    let daysBetweenDates
      = calendar.dateComponents([.day], from: startDate.start, to: endDate.start).day ?? 0
    dustInfoManager
      .request(
        dataTerm: .month,
        numberOfRows: (daysBetweenDates + 2) * 24,
        pageNumber: 1) { response, error in
          guard let items = response?.items else {
            completion(nil, nil, error)
            return
          }
          var hourlyFineDustIntakePerDate: DateHourIntakePair = [:]
          var hourlyUltrafineDustIntakePerDate: DateHourIntakePair = [:]
          for item in items {
            let (hour, _) = self.hourInDustDate(item.dataTime)
            let currentReferenceDate = self.referenceDate(item.dataTime)
            // 구간 내에 포함되지 않는다면 해당 데이터는 필요 없으므로 컨티뉴
            if !(startDate.start...endDate.start).contains(currentReferenceDate) { continue }
            // 시작 날짜의 전날 시작 날짜와 현재 요소의 시작 날짜가 같으면 필요한 처리를 다 한 것이므로 브레이크
            if startDate.before(days: 1).start == currentReferenceDate { break }
            hourlyFineDustIntakePerDate
              .padIntakeOrEmpty(date: currentReferenceDate,
                                   hour: hour,
                                   intake: item.fineDustValue)
            hourlyUltrafineDustIntakePerDate
              .padIntakeOrEmpty(date: currentReferenceDate,
                                   hour: hour,
                                   intake: item.ultrafineDustValue)
          }
          debugLog("특정 기간 내의 대기 오염 데이터 가져오기 성공.")
          debugLog(hourlyFineDustIntakePerDate)
          debugLog(hourlyUltrafineDustIntakePerDate)
          completion(hourlyFineDustIntakePerDate, hourlyUltrafineDustIntakePerDate, nil)
    }
  }
}

private extension DustInfoService {
  
  /// 미세먼지 API가 주는 `dataTime`으로부터 `Hour`를 뽑아냄.
  ///
  /// 24시를 사용하는 것에 대응하기 위함.
  ///
  /// 24시가 오면 0시로 바꿈.
  func hourInDustDate(_ dateString: String) -> (hour: Hour, isMidnight: Bool) {
    if let dataTimeToDate = DateFormatter.dateTime.date(from: dateString) {
      let hourToString = DateFormatter.hour.string(from: dataTimeToDate)
      let hourToInt = Int(hourToString) ?? 0
      return (Hour(rawValue: hourToInt) ?? .default, false)
    } else {
      return (Hour(rawValue: 0) ?? .default, true)
    }
  }
  
  /// 미세먼지 `dataTime`으로부터 키값에 사용할 기준 `Date`를 뽑아냄.
  func referenceDate(_ dateString: String) -> Date {
    if let dateTimeToDate = DateFormatter.dateTime.date(from: dateString) {
      return dateTimeToDate.start
    } else {
      let halfDataTime = dateString.components(separatedBy: " ").first ?? ""
      let halfDataTimeToDate = DateFormatter.date.date(from: halfDataTime)
      let nextHalfDataTime = halfDataTimeToDate?.after(days: 1)
      return nextHalfDataTime?.start ?? Date()
    }
  }
}
