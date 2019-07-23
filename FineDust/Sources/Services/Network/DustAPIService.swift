//
//  DustAPIService.swift
//  FineDust
//
//  Created by Presto on 23/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Moya
import RxSwift

final class DustAPIService {
  
  private let provider = MoyaProvider<DustAPI>()
  
  func requestObservatory() -> Observable<DustAPIObservatoryResponse> {
    return .create { observer in
      self.provider.request(.observatory) { result in
        switch result {
        case let .success(response):
          let statusCode = response.statusCode
          let data = response.data
          observer.onNext(<#T##element: ObservatoryResponse##ObservatoryResponse#>)
          observer.onCompleted()
        case let .failure(error):
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
