//
//  MockDustObservatoryManager.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockDustObservatoryManager: DustObservatoryManagerType {
  
  var observatoryResponse: ObservatoryResponse?
  
  var error: Error?
  
  func requestObservatory(numberOfRows numOfRows: Int, pageNumber pageNo: Int, completion: @escaping (ObservatoryResponse?, Error?) -> Void) {
    completion(observatoryResponse, error)
  }
}
