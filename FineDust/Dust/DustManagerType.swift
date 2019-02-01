//
//  API+FineDust.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// Dust Manager Type.
protocol DustManagerType: class {
  
  /// 측정소 정보 조회.
  ///
  /// - Parameters:
  ///   - pageNo: 페이지 인덱스.
  ///   - numOfRows: 한 페이지에 노출되는 정보량.
  ///   - completion: 컴플리션 핸들러.
  func fetchObservatory(numberOfRows numOfRows: Int,
                        pageNumber pageNo: Int,
                        completion: @escaping (ObservatoryResponse?, Error?) -> Void)
  
  /// 미세먼지 농도 조회.
  ///
  /// - Parameters:
  ///   - dataTerm: 데이터 기간. daily 또는 month.
  ///   - pageNo: 페이지 인덱스.
  ///   - numOfRows: 한 페이지에 노출되는 정보량.
  ///   - completion: 컴플리션 핸들러.
  func fetchDustInfo(term dataTerm: DataTerm,
                     numberOfRows numOfRows: Int,
                     pageNumber pageNo: Int,
                     completion: @escaping (DustResponse?, Error?) -> Void)
}
