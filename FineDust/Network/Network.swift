//
//  Network.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class Network {
  
  class func request(
    _ url: URL,
    method: HTTPMethod,
    parameters: [String: Any] = [:],
    headers: [String: String] = [:],
    completion: @escaping (Data?, Int?, Error?) -> Void
  ) {
    let session = URLSession(configuration: .default)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    else { return }
    urlRequest.httpBody = httpBody
    headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
    let task = session.dataTask(with: urlRequest) { data, response, error in
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
      completion(data, statusCode, error)
      session.finishTasksAndInvalidate()
    }
    task.resume()
  }
}
