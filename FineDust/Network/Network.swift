//
//  Network.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 네트워크 요청 관련 클래스.
final class Network {
  
  /// HTTP 메소드를 정의한 열거형.
  enum HTTPMethod: String {
    
    case get = "GET"
    
    case post = "POST"
  }
  
  /// 네트워크 요청을 위한 타입 메소드.
  ///
  /// - Parameters:
  ///   - url: URL
  ///   - method: HTTP Method
  ///   - parameters: HTTP Body에 들어갈 키/값 쌍. 기본값은 `[:]`
  ///   - headers: HTTP Header에 들어갈 키/값 쌍. 기본값은 `[:]`
  ///   - completion: 컴플리션 핸들러
  class func request(
    _ url: URL,
    method: HTTPMethod,
    parameters: [String: Any]? = nil,
    headers: [String: String] = [:],
    completion: @escaping (Data?, Error?) -> Void
  ) {
    let session = URLSession(configuration: .default)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    if let parameters = parameters {
      urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    }
    headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
    let task = session.dataTask(with: urlRequest) { data, _, error in
      completion(data, error)
      session.finishTasksAndInvalidate()
    }
    task.resume()
  }
}
