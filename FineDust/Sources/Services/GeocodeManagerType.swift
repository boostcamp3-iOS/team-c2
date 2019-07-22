//
//  GeocoderManagerType.swift
//  FineDust
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import class CoreLocation.CLLocation

import RxSwift

protocol GeocodeManagerType: class {
  
  func geocode(for location: CLLocation) -> Observable<String>
}
