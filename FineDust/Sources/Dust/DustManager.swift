//
//  API.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// Dust Manager 기반 프로토콜.
final class DustManager: DustManagerType {
  
  /// Singleton Object.
  static let shared = DustManager()
  
  private init() { }
}
