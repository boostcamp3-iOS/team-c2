//
//  Network.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

import SVProgressHUD

final class NetworkManager: NetworkManagerType {
  
  static let shared = NetworkManager()
  
  private init() { }
  
  func request(_ url: URL,
               method: HTTPMethod,
               parameters: [String: Any]? = nil,
               headers: [String: String] = [:],
               completion: @escaping (Data?, StatusCode?, Error?) -> Void) {
    let session = URLSession(configuration: .default)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    if let parameters = parameters {
      urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    }
    headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
    DispatchQueue.main.async {
      SVProgressHUD.show()
    }
    let task = session.dataTask(with: urlRequest) { data, response, error in
      defer {
        session.finishTasksAndInvalidate()
        DispatchQueue.main.async {
          SVProgressHUD.dismiss()
        }
      }
      let statusCodeRawValue = (response as? HTTPURLResponse)?.statusCode ?? 0
      let statusCode = StatusCode(rawValue: statusCodeRawValue) ?? .default
      completion(data, statusCode, error)
    }
    task.resume()
  }
}
