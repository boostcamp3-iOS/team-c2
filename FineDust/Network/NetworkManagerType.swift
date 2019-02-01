//
//  NetworkManagerType.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

protocol NetworkManagerType: class {
  func request(_ url: URL,
               method: HTTPMethod,
               parameters: [String: Any]?,
               headers: [String: String],
               completion: @escaping (Data?, HTTPStatusCode?, Error?) -> Void)
}
