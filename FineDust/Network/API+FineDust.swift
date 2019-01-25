//
//  API+FineDust.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 API 관련 API 정의
extension API {
  
  /// 측정소 정보 조회.
  func fetchObservatory(
    pageNumber pageNo: Int = 1,
    numberOfRows numOfRows: Int = 10,
    completion: @escaping (ObservatoryResponse?, Error?) -> Void
  ) {
    let urlString = baseURL
      .appending("/MsrstnInfoInqireSvc/getNearbyMsrstnList")
      .appending("?tmX=\(GeoInfo.shared.x)")
      .appending("&tmY=\(GeoInfo.shared.y)")
      .appending("&numOfRows=\(numOfRows)")
      .appending("&pageNo=\(pageNo)")
      .appending("&serviceKey=\(serviceKey)")
      .appending("&_returnType=json")
    guard let url = URL(string: urlString) else { return }
    Network.request(url, method: .get) { data, error in
      guard let data = data else {
        completion(nil, error)
        return
      }
      do {
        let response = try JSONDecoder().decode(ObservatoryResponse.self, from: data)
        completion(response, nil)
      } catch {
        completion(nil, error)
      }
    }
  }

  /// 미세먼지 농도 조회.
  func fetchFineDustConcentration(
    term dataTerm: DataTerm,
    pageNumber pageNo: Int = 1,
    numberOfRows numOfRows: Int = 10,
    completion: @escaping (FineDustResponse?, Error?) -> Void
  ) {
    let observatory = FineDustInfo.shared.observatory.percentEncoded
    let urlString = baseURL
      .appending("/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty")
      .appending("?stationName=\(observatory)")
      .appending("&dataTerm=\(dataTerm.rawValue)")
      .appending("&pageNo=\(pageNo)")
      .appending("&numOfRows=\(numOfRows)")
      .appending("&serviceKey=\(serviceKey)")
      .appending("&ver=1.1")
      .appending("&_returnType=json")
    guard let url = URL(string: urlString) else { return }
    Network.request(url, method: .get) { data, error in
      guard let data = data else {
        completion(nil, error)
        return
      }
      do {
        let response = try JSONDecoder().decode(FineDustResponse.self, from: data)
        completion(response, nil)
      } catch {
        completion(nil, error)
      }
    }
  }
}
