//
//  APIService.swift
//  FineDust
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

protocol APIServiceType {
  func fetchCurrentObservatory(completion: @escaping (String?, Error?) -> Void)
  func fetchFineDust(in date: Date, for days: Int, completion: @escaping ([Hour: Int]?, [Hour: Int]?, Error?) -> Void)
}

final class APIService: APIServiceType {
  
  let locationManager: LocationManagerType
  
  let geocoderManager: GeocoderManagerType
  
  init(locationManager: LocationManagerType = LocationManager.shared,
       geocoderManager: GeocoderManagerType = GeocoderManager.shared) {
    self.locationManager = locationManager
    self.geocoderManager = geocoderManager
  }
  
  func fetchCurrentObservatory(completion: @escaping (String?, Error?) -> Void) {
    API.shared.fetchObservatory { response, error in
      if let error = error {
        completion(nil, error)
        return
      }
      completion(response?.observatory, nil)
    }
  }
  
  func fetchFineDust(in date: Date, for days: Int, completion: @escaping ([Hour : Int]?, [Hour: Int]?, Error?) -> Void) {
    API.shared.fetchFineDustConcentration(term: .daily, pageNumber: 1, numberOfRows: 1) { response, error in
      if let error = error {
        completion(nil, nil, error)
        return
      }
      let fineDustDictionary: [Hour: Int] = [:]
      let ultraFineDustDictionary: [Hour: Int] = [:]
      completion(fineDustDictionary, ultraFineDustDictionary, nil)
    }
  }
}
