//
//  MockAPI.swift
//  FineDustTests
//
//  Created by Presto on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

// 4. Mock 만듦
@testable import FineDust

import Foundation

final class MockAPI: APIFineDustType {
  
  var error: Error?
  
  var observatoryResponse: ObservatoryResponse?

  var fineDustResponse: FineDustResponse?
  
  func fetchObservatory(pageNumber pageNo: Int,
                        numberOfRows numOfRows: Int,
                        completion: @escaping (ObservatoryResponse?, Error?) -> Void) {
    completion(observatoryResponse, nil)
  }
  
  func fetchFineDustConcentration(term dataTerm: DataTerm,
                                  pageNumber pageNo: Int,
                                  numberOfRows numOfRows: Int,
                                  completion: @escaping (FineDustResponse?, Error?) -> Void) {
    completion(fineDustResponse, nil)
  }
}
