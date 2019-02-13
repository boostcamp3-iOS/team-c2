//
//  DummyDustInfoService.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

struct DummyDustInfoService {
  
  static let fineDustHourlyValue: HourIntakePair = [.zero: 0, .one: 1, .two: 2, .three: 3, .four: 4, .five: 5, .six: 6, .seven: 7, .eight: 8, .nine: 9, .ten: 10, .eleven: 11, .twelve: 12, .thirteen: 13, .fourteen: 14, .fifteen: 15, .sixteen: 16, .seventeen: 17, .eighteen: 18, .nineteen: 19, .twenty: 20, .twentyOne: 21, .twentyTwo: 22, .twentyThree: 23]
  
  static let ultrafineDustHourlyValue: HourIntakePair = [.zero: 0, .one: 1, .two: 2, .three: 3, .four: 4, .five: 5, .six: 6, .seven: 7, .eight: 8, .nine: 9, .ten: 10, .eleven: 11, .twelve: 12, .thirteen: 13, .fourteen: 14, .fifteen: 15, .sixteen: 16, .seventeen: 17, .eighteen: 18, .nineteen: 19, .twenty: 20, .twentyOne: 21, .twentyTwo: 22, .twentyThree: 23]
  
  static let fineDustHourlyValuePerDate: DateHourIntakePair = [.before(days: 6): fineDustHourlyValue, .before(days: 5): fineDustHourlyValue, .before(days: 4): fineDustHourlyValue, .before(days: 3): fineDustHourlyValue, .before(days: 2): fineDustHourlyValue, .before(days: 1): fineDustHourlyValue]
  
  static let ultrafineDustHourlyValuePerDate: DateHourIntakePair = [.before(days: 6): ultrafineDustHourlyValue, .before(days: 5): ultrafineDustHourlyValue, .before(days: 4): ultrafineDustHourlyValue, .before(days: 3): ultrafineDustHourlyValue, .before(days: 2): ultrafineDustHourlyValue, .before(days: 1): ultrafineDustHourlyValue]
}
