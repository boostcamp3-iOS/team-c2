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
  
  /// 미세먼지 정보 요청.
  ///
  /// numberOfRows는 1, pageNumber는 유동적으로.
  func request(dataTerm: DustDataTerm,
               numberOfRows numOfRows: Int,
               pageNumber pageNo: Int,
               completion: @escaping (DustAPIInfoResponse?, Error?) -> Void)
}
