//
//  DustInfoManager.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 정보 관련 Dust Manager 클래스.
final class DustInfoManager: DustInfoManagerType {

  var networkManager: NetworkManagerType
  
  init(networkManager: NetworkManagerType = NetworkManager.shared) {
    self.networkManager = networkManager
  }
}
