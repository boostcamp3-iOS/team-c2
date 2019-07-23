//
//  DummyDustObservatoryManager.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

struct DummyDustObservatoryManager {
  
  static let observatoryResponse: DustAPIObservatoryResponse = DustAPIObservatoryResponse(result: DustAPIObservatoryResponse.Result(code: 0, message: "wow"), totalCount: 1, items: [DustAPIObservatoryResponse.Item(address: "강남구 강남대로", observatory: "강남대로", distance: 10.0)])
}
