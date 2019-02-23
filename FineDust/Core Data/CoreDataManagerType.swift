//
//  CoreDataManagerType.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation
import UIKit

/// 코어데이터 매니저 베이스 프로토콜.
protocol CoreDataManagerType {
  
  /// 코어 데이터 컨텍스트.
  var context: NSManagedObjectContext { get }
  
  /// 전달한 딕셔너리 저장.
  func save(_ dictionary: [String: Any], completion: @escaping (Error?) -> Void)
}

// MARK: - CoreDataManagerType 프로토콜 초기 구현

extension CoreDataManagerType {
  
  var context: NSManagedObjectContext {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
    return delegate.persistentContainer.viewContext
  }
}
