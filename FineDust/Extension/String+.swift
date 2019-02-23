//
//  String+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension String {
  
  /// 문자열 로컬라이징.
//  var localized: String {
//    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
//  }
  
  /// 문자열 퍼센트 인코딩.
  var percentEncoded: String {
    return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
  }
}
