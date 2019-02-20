//
//  LocationError.swift
//  FineDust
//
//  Created by Presto on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation
import Foundation

/// Core Location Error가 ServiceErrorType을 준수하게 함.
extension CLError.Code: ServiceErrorType {
  
  var localizedDescription: String {
    switch self {
    case .deferredAccuracyTooLow:
      print("Core Location Error: ", "deferred mode is not supported for the requested accuracy.")
    case .deferredCanceled:
      print("Core Location Error: ",
            "the request for deferred updates was cancelled by your app or by the location manager.")
    case .deferredDistanceFiltered:
      print("Core Location Error: ", "deferred mode does not support distance filters.")
    case .deferredFailed:
      print("Core Location Error: ",
            "the location manager did not enter deferred mode for an unknown reason.")
    case .deferredNotUpdatingLocation:
      print("Core Location Error: ",
            """
            the location manager did not enter deferred mode because location updates were already disabled or paused.
            """)
    case .denied:
      print("Core Location Error: ", "access to the location service was denied by the user.")
    case .geocodeCanceled:
      print("Core Location Error: ", "the geocode request was canceled.")
    case .geocodeFoundNoResult:
      print("Core Location Error: ", "the geocode request yielded no result.")
    case .geocodeFoundPartialResult:
      print("Core Location Error: ", "the geocode request yielded a partial result.")
    case .headingFailure:
      print("Core Location Error: ", "the heading could not be determined.")
    case .locationUnknown:
      print("Core Location Error: ",
            "the location manager was unable to obtain a location value right now.")
    case .network:
      print("Core Location Error: ", "the network was unavailable or a network error occurred.")
    case .rangingFailure:
      print("Core Location Error: ", "a general ranging error occurred.")
    case .rangingUnavailable:
      print("Core Location Error: ", "ranging is disabled.")
    case .regionMonitoringDenied:
      print("Core Location Error: ",
            "access to the region monitoring service was denied by the user.")
    case .regionMonitoringFailure:
      print("Core Location Error: ", "a registered region cannot be monitored.")
    case .regionMonitoringResponseDelayed:
      print("Core Location Error: ", "Core Location will deliver events but they may be delayed.")
    case .regionMonitoringSetupDelayed:
      print("Core Location Error: ",
            "Core Location could not initialize the region monitoring feature immediately.")
    }
    return "위치 권한을 확인해 주세요."
  }
}
