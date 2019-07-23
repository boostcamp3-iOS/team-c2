//
//  DustObservatoryTarget.swift
//  FineDust
//
//  Created by Presto on 23/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Moya

enum DustAPI {
  
  case observatory
}

extension DustAPI: TargetType {
  
  private var serviceKey: String {
    return "BfJjA4%2BuaBHhfAzyF2Ni6xoVDaf%2FhsZylifmFKdW3kyaZECH6c2Lua05fV%2F%2BYgbzPBaSl0YLZwI%2BW%2FK2xzO7sw%3D%3D"
  }
  
  var baseURL: URL {
    guard let url = URL(string: "http://openapi.airkorea.or.kr/openapi/services/rest") else {
      fatalError("invalid url")
    }
    return url
  }
  
  var path: String {
    switch self {
    case .observatory:
      return "/MsrstnInfoInqireSvc/getNearbyMsrstnList"
        .appending("?tmX=\(SharedInfo.shared.x)")
        .appending("&tmY=\(SharedInfo.shared.y)")
        .appending("&numOfRows=1")
        .appending("&pageNo=1")
        .appending("&serviceKey=\(serviceKey)")
    }
  }
  
  var method: Method {
    return .get
  }
  
  var sampleData: Data {
    return .init()
  }
  
  var task: Task {
    switch self {
    case .observatory:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .observatory:
      return nil
    }
  }
}
