//
//  JSONManagerType.swift
//  FineDust
//
//  Created by 이재은 on 09/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// JSON Manager Type.
protocol JSONManagerType {
  
  /// DustFeedbacks.json을 파싱하여 데이터를 가져옴.
  func fetchDustFeedbacks() -> [DustFeedbacks]
}
