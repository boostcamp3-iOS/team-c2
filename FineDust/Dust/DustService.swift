//
//  DustService.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 서비스.
final class DustService: DustServiceType {

  /// 시간대별 섭취량 타입 별칭 정의.
  typealias IntakesByHour = [Hour: Int]
  
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
  let dustManager: DustManagerType
  
  // MARK: Dependency Injection
  
  init(dustManager: DustManagerType) {
    self.dustManager = dustManager
  }
  
  func fetchCurrentResponse(_ completion: @escaping (CurrentDustInfo?, Error?) -> Void) {
    dustManager.fetchDustInfo(term: .daily,
                              numberOfRows: 1,
                              pageNumber: 1) { [weak self] response, error in
      if let error = error {
        completion(nil, error)
        return
      }
      guard let self = self else { return }
      if let currentResponse = response?.items.first {
        let currentDustInfo = CurrentDustInfo(
          currentFineDustValue: currentResponse.fineDustValue,
          currentUltraFineDustValue: currentResponse.ultraFineDustValue,
          currentFineDustGrade: DustGrade(rawValue: currentResponse.fineDustGrade) ?? .default,
          currentUltraFineDustGrade: DustGrade(
            rawValue: currentResponse.ultraFineDustGrade
            ) ?? .default,
          recentUpdatingTime: self.fullDateFormatter.date(from: currentResponse.dataTime) ?? Date()
        )
        completion(currentDustInfo, nil)
      }
    }
  }
  
  func fetchTodayDust(_ completion: @escaping (IntakesByHour?, IntakesByHour?, Error?) -> Void) {
    dustManager.fetchDustInfo(term: .daily,
                              numberOfRows: 24,
                              pageNumber: 1) { [weak self] response, error in
      var fineDust: [Hour: Int] = [:]
      var ultraFineDust: [Hour: Int] = [:]
      guard let self = self else { return }
      if let error = error {
        completion(nil, nil, error)
        return
      }
      response?.items.forEach { item in
        let dataTimeToDate = self.fullDateFormatter.date(from: item.dataTime) ?? Date()
        let hourToString = self.monthDateFormatter.string(from: dataTimeToDate)
        let hourToInt = Int(hourToString) ?? 0
        let hour = Hour(rawValue: hourToInt) ?? .default
        fineDust[hour] = item.fineDustValue
        ultraFineDust[hour] = item.ultraFineDustValue
        if hour == .zero { return }
      }
      completion(fineDust, ultraFineDust, nil)
    }
  }
}
