//
//  MockDustManager.swift
//  FineDustTests
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockDustManager: DustInfoManagerType {
  
  var error: Error?
  
  var dustResponse: DustResponse!
  
  func fetchObservatory(numberOfRows numOfRows: Int,
                        pageNumber pageNo: Int,
                        completion: @escaping (ObservatoryResponse?, Error?) -> Void) {
    completion(nil, nil)
  }
  
  func requestDustInfo(term dataTerm: DataTerm,
                     numberOfRows numOfRows: Int,
                     pageNumber pageNo: Int,
                     completion: @escaping (DustResponse?, Error?) -> Void) {
    completion(dustResponse, error)
  }
}

struct DustManagerInfo {
  
  static let dummyDustResponse: DustResponse = DustResponse(
    result: DustResponse.Result(code: 0, message: "wow"),
    totalCount: 1,
    items: [DustResponse.Item(dataTime: "2018-01-23 17:00",
                              fineDustValueString: "1",
                              fineDustValue24String: "1",
                              fineDustGradeString: "1",
                              ultrafineDustValueString: "1",
                              ultrafineDustValue24String: "1",
                              ultrafineDustGradeString: "1")])
}
