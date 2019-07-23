//
//  GeocoderManager.swift
//  FineDust
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation

import RxSwift

final class GeocodeManager: GeocodeManagerType {
  
  func geocode(for location: CLLocation) -> Observable<String> {
    return .create { observer in
      CLGeocoder()
        .reverseGeocodeLocation(location, preferredLocale: .korea) { placemarks, error in
          if let error = error {
            observer.onError(error)
            return
          }
          guard let placemark = placemarks?.first else { return }
          let locality = placemark.locality ?? ""
          let name = placemark.name ?? ""
          let address = "\(locality) \(name)"
          observer.onNext(address)
          observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
