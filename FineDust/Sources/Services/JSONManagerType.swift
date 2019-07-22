//
//  JSONManagerType.swift
//  FineDust
//
//  Created by Presto on 22/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

protocol JSONManagerType: class {
  
  func parse<T>(_ resourceName: String, to type: T.Type) -> T? where T: Decodable
}
