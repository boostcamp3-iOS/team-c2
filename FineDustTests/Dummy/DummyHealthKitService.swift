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
  static let hourlyZeroDistance: HourIntakePair = [.zero: 0, .one: 0, .two: 0, .three: 0, .four: 0, .five: 0, .six: 0, .seven: 0, .eight: 0, .nine: 0, .ten: 0, .eleven: 0, .twelve: 0, .thirteen: 0, .fourteen: 0, .fifteen: 0, .sixteen: 0, .seventeen: 0, .eighteen: 0, .nineteen: 0, .twenty: 0, .twentyOne: 0, .twentyTwo: 0, .twentyThree: 0]
  
  static let hourlyDistance: HourIntakePair = [.zero: 0, .one: 1, .two: 2, .three: 3, .four: 4, .five: 5, .six: 6, .seven: 7, .eight: 8, .nine: 9, .ten: 10, .eleven: 11, .twelve: 12, .thirteen: 13, .fourteen: 14, .fifteen: 15, .sixteen: 16, .seventeen: 17, .eighteen: 18, .nineteen: 19, .twenty: 20, .twentyOne: 21, .twentyTwo: 22, .twentyThree: 23]
  
  static let hourlyZeroDistancePerDate: DateHourIntakePair = [Date.before(days: 6).start: hourlyZeroDistance, Date.before(days: 5).start: hourlyZeroDistance, Date.before(days: 4).start: hourlyZeroDistance, Date.before(days: 3).start: hourlyZeroDistance, Date.before(days: 2).start: hourlyZeroDistance, Date.before(days: 1).start: hourlyZeroDistance]
  
  static let hourlyDistancePerDate: DateHourIntakePair = [.before(days: 6): hourlyDistance, .before(days: 5): hourlyDistance, .before(days: 4): hourlyDistance, .before(days: 3): hourlyDistance, .before(days: 2): hourlyDistance, .before(days: 1): hourlyDistance]
}
