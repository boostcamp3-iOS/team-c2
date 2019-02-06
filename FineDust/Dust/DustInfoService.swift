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
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter
  }()
  
  /// `HH` 형식으로 포매팅하는 데이트 포매터.
  private lazy var monthDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
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
  
  func fetchTodayInfo(_ completion: @escaping (HourIntakePair?, HourIntakePair?, Error?) -> Void) {
    dustInfoManager
      .fetchDustInfo(
        term: .daily,
        numberOfRows: 24,
        pageNumber: 1) { response, error in
          var fineDust: [Hour: Int] = [:]
          var ultrafineDust: [Hour: Int] = [:]
          if let error = error {
            completion(nil, nil, error)
            return
          }
          guard let items = response?.items else { return }
          for item in items {
            let hour: Hour
            if let dataTimeToDate = self.fullDateFormatter.date(from: item.dataTime) {
              let hourToString = self.monthDateFormatter.string(from: dataTimeToDate)
              let hourToInt = Int(hourToString) ?? 0
              hour = Hour(rawValue: hourToInt) ?? .default
            } else {
              hour = Hour(rawValue: 0) ?? .default
            }
            fineDust[hour] = item.fineDustValue
            ultrafineDust[hour] = item.ultrafineDustValue
            if hour == .zero { break }
          }
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
}
