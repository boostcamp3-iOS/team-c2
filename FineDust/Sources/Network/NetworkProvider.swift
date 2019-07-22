//
//  NetworkProvider.swift
//  FineDust
//
//  Created by Presto on 22/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Alamofire
import RxSwift

protocol NetworkProviderType: class {
  
  associatedtype Target: TargetType
  
  func request(_ target: Target) -> Observable<DataResponse>
}

final class NetworkProvider: NetworkProviderType {
  
  
}
