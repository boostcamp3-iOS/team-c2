//
//  XMLManagerType.swift
//  FineDust
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import SWXMLHash

protocol XMLManagerType: class {

  func decode<T>(_ data: Data, completion: @escaping (T?, Error?) -> Void) where T: XMLParsingType
}
