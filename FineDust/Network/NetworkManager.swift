//
//  Network.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 네트워크 요청 관련 클래스.
final class NetworkManager: NetworkManagerType {
  
  static let shared = NetworkManager()
  
  private init() { }
  
  /// 네트워크 요청.
  ///
  /// - Parameters:
  ///   - url: URL.
  ///   - method: HTTP Method.
  ///   - parameters: HTTP Body에 들어갈 키/값 쌍. 기본값은 `[:]`.
  ///   - headers: HTTP Header에 들어갈 키/값 쌍. 기본값은 `[:]`.
  ///   - completion: 컴플리션 핸들러.
  func request(
    _ url: URL,
    method: HTTPMethod,
    parameters: [String: Any]? = nil,
    headers: [String: String] = [:],
    completion: @escaping (Data?, HTTPStatusCode?, Error?) -> Void
  ) {
    let session = URLSession(configuration: .default)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    if let parameters = parameters {
      urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    }
    headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
    DispatchQueue.main.async {
      ProgressIndicator.shared.show()
    }
    let task = session.dataTask(with: urlRequest) { data, response, error in
      let statusCodeRawValue = (response as? HTTPURLResponse)?.statusCode ?? 0
      let statusCode = HTTPStatusCode(rawValue: statusCodeRawValue) ?? .default
      completion(data, statusCode, error)
      DispatchQueue.main.async {
        ProgressIndicator.shared.hide()
      }
      session.finishTasksAndInvalidate()
    }
    task.resume()
  }
}
