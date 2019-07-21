//
//  NetworkManagerType.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// NetworkManager 프로토콜.
protocol NetworkManagerType: class {
  
  /// 네트워크 요청.
  ///
  /// - Parameters:
  ///   - url: URL.
  ///   - method: HTTP Method.
  ///   - parameters: HTTP Body에 들어갈 키/값 쌍. 기본값은 `[:]`.
  ///   - headers: HTTP Header에 들어갈 키/값 쌍. 기본값은 `[:]`.
  ///   - completion: 컴플리션 핸들러.
  func request(_ url: URL,
               method: HTTPMethod,
               parameters: [String: Any]?,
               headers: [String: String],
               completion: @escaping (Data?, HTTPStatusCode?, Error?) -> Void)
}
