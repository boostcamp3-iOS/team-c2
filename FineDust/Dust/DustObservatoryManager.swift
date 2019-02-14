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
  
  var networkManager: NetworkManagerType
  
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
                // HTTP 상태 코드가 200인지 확인. 그렇지 않으면 이에 대응하는 에러를 만들어 넘겨줌.
                guard status == .success else {
                  completion(nil, status?.error)
                  return
                }
                // 데이터가 있는지 확인. 그렇지 않으면 넘어온 에러를 넘겨줌.
                guard let data = data else {
                  completion(nil, error)
                  return
                }
                // XML 파싱하여 타입에 맞는 데이터로 캐스팅하여 넘겨줌.
                XMLManager<ObservatoryResponse>().parse(data) { parsingType, error in
                  let response = parsingType as? ObservatoryResponse
                  completion(response, error)
                }
    }
  }
}
