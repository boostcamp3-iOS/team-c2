//
//  CoreDataHelper.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation
import UIKit

/// 코어데이터 매니저 베이스 클래스.
final class CoreDataManager: CoreDataManagerType {
  
  /// CoreDataManager의 싱글톤 객체.
  static let shared = CoreDataManager()
  
  func save(_ dictionary: [String: Any], completion: @escaping (Error?) -> Void) {
    completion(NSError(domain: "unexpected call", code: 0, userInfo: nil))
  }
}
