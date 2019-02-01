//
//  DustService.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class DustService: DustServiceType {

  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter
  }()
  
  let networkManager: NetworkManagerType
  
  let dustManager: DustManagerType
  
  init(dustManager: DustManagerType, networkManager: NetworkManagerType = NetworkManager.shared) {
    self.networkManager = networkManager
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
          recentUpdatingTime: self.dateFormatter.date(from: currentResponse.dataTime) ?? Date()
        )
        completion(currentDustInfo, nil)
      }
    }
  }
  
  func fetchTodayDust(_ completion: ([Hour : Int]?, [Hour: Int]?, Error?) -> Void) -> Void {
    let fineDust: [Hour: Int] = [.zero: 1, .one: 2]
    let ultraFineDust: [Hour: Int] = [.zero: 1, .one: 2]
  completion(fineDust, ultraFineDust, nil)
  }
}
