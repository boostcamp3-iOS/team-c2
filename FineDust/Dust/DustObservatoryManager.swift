//
//  DustObservatoryManager.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 관측소 관련 Dust Manager 클래스.
final class DustObservatoryManager: DustObservatoryManagerType {
  
  let networkManager: NetworkManagerType
  
  // MARK: Dependency Injection
  
  init(networkManager: NetworkManagerType = NetworkManager.shared) {
    self.networkManager = networkManager
  }
  
  func requestObservatory(numberOfRows numOfRows: Int,
                          pageNumber pageNo: Int,
                          completion: @escaping (ObservatoryResponse?, Error?) -> Void) {
    let urlString = baseURL
      .appending("/MsrstnInfoInqireSvc/getNearbyMsrstnList")
      .appending("?tmX=\(SharedInfo.shared.x)")
      .appending("&tmY=\(SharedInfo.shared.y)")
      .appending("&numOfRows=\(numOfRows)")
      .appending("&pageNo=\(pageNo)")
      .appending("&serviceKey=\(serviceKey)")
    guard let url = URL(string: urlString) else { return }
    networkManager
      .request(url,
               method: .get,
               parameters: nil,
               headers: [:]) { data, status, error in
                // 네트워크 상태 코드가 success가 아니면 HTTP 에러를 던짐
                guard status == .success else {
                  completion(nil, status?.error)
                  return
                }
                // 네트워크 에러가 없으면 data가 있는 것은 보장됨
                guard let data = data else { return }
                // 해당 타입으로 XML 파싱 시도
                // 파싱 로직 내부에서 미세먼지 에러를 찾아 내려줌
                XMLManager().decode(data, completion: completion)
    }
  }
}
