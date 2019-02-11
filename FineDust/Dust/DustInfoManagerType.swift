//
//  DustInfoManagerType.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 정보 관련 Dust Manager 프로토콜.
protocol DustInfoManagerType: DustManagerType {
  func request(dataTerm: DataTerm,
               numberOfRows numOfRows: Int,
               pageNumber pageNo: Int,
               completion: @escaping (DustResponse?, Error?) -> Void)
}

// MARK: - DustInfoManagerType 프로토콜 초기 구현

extension DustInfoManagerType {
  func request(dataTerm: DataTerm,
               numberOfRows numOfRows: Int,
               pageNumber pageNo: Int,
               completion: @escaping (DustResponse?, Error?) -> Void) {
    let observatory = SharedInfo.shared.observatory.percentEncoded
    let urlString = baseURL
      .appending("/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty")
      .appending("?stationName=\(observatory)")
      .appending("&dataTerm=\(dataTerm.rawValue)")
      .appending("&pageNo=\(pageNo)")
      .appending("&numOfRows=\(numOfRows)")
      .appending("&serviceKey=\(serviceKey)")
      .appending("&ver=1.1")
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
                XMLManager<DustResponse>().parse(data) { parsingType, error in
                  let response = parsingType as? DustResponse
                  completion(response, error)
                }
    }
  }
}
