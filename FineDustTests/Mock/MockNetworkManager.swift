//
//  MockNetworkManager.swift
//  FineDustTests
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockNetworkManager: NetworkManagerType {
  
  var data: Data?
  
  var httpStatusCode: HTTPStatusCode?
  
  var error: Error?
  
  func request(_ url: URL,
               method: HTTPMethod,
               parameters: [String: Any]?,
               headers: [String: String],
               completion: @escaping (Data?, HTTPStatusCode?, Error?) -> Void) {
    completion(data, httpStatusCode, error)
  }
}
