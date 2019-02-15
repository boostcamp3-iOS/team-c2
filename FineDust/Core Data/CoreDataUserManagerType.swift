//
//  CoreDataUserManagerType.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation

/// 코어데이터의 `User` 모델 관련 매니저 프로토콜.
protocol CoreDataUserManagerType: CoreDataManagerType {

  /// READ
  func request(completion: @escaping (User?, Error?) -> Void)
}
