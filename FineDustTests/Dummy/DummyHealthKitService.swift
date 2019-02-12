//
//  DummyHealthKitService.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

struct DummyHealthKitService {
  
  static let hourlyDistance: HourIntakePair = [.zero: 0, .one: 1, .two: 2, .three: 3, .four: 4, .five: 5, .six: 6, .seven: 7, .eight: 8, .nine: 9, .ten: 10, .eleven: 11, .twelve: 12, .thirteen: 13, .fourteen: 14, .fifteen: 15, .sixteen: 16, .seventeen: 17, .eighteen: 18, .nineteen: 19, .twenty: 20, .twentyOne: 21, .twentyTwo: 22, .twentyThree: 23]
  
  static let hourlyDistancePerDate: DateHourIntakePair = [Date(): hourlyDistance]
}
