//
//  String+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension String {
  var percentEncoded: String {
    return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
  }
}
