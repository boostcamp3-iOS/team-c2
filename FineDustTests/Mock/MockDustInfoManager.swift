//
//  MockDustManager.swift
//  FineDustTests
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockDustInfoManager: DustInfoManagerType {
  
  var networkManager: NetworkManagerType?
  
  var dustResponse: DustResponse?
  
  var error: Error?
  
  func request(dataTerm: DustDataTerm, numberOfRows numOfRows: Int, pageNumber pageNo: Int, completion: @escaping (DustResponse?, Error?) -> Void) {
    completion(dustResponse, error)
  }
}
