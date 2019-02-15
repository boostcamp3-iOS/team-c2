//
//  CoreDataIntakeManagerType.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation

/// `Intake` Entity에 대한 Manager 프로토콜.
protocol CoreDataIntakeManagerType: CoreDataManagerType {
  
  /// READ
  func request(completion: @escaping ([Intake]?, Error?) -> Void)
}
