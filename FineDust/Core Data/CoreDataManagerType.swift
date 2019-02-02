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

protocol CoreDataManagerType {
  
  var context: NSManagedObjectContext { get }
}

extension CoreDataManagerType {
  
  var context: NSManagedObjectContext {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
    return delegate.persistentContainer.viewContext
  }
}
