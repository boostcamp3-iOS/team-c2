//
//  LocationError.swift
//  FineDust
//
//  Created by Presto on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation

extension CLError.Code: ServiceErrorType {
  
  var localizedDescription: String {
    switch self {
    case .deferredAccuracyTooLow:
      errorLog("deferred mode is not supported for the requested accuracy.")
    case .deferredCanceled:
      errorLog(
        """
        the request for deferred updates was cancelled by your app or by the location manager.
        """)
    case .deferredDistanceFiltered:
      errorLog("deferred mode does not support distance filters.")
    case .deferredFailed:
      errorLog("the location manager did not enter deferred mode for an unknown reason.")
    case .deferredNotUpdatingLocation:
      errorLog(
        """
        the location manager did not enter deferred mode because location updates were already disabled or paused.
        """)
    case .denied:
      errorLog("access to the location service was denied by the user.")
    case .geocodeCanceled:
      errorLog("the geocode request was canceled.")
    case .geocodeFoundNoResult:
      errorLog("the geocode request yielded no result.")
    case .geocodeFoundPartialResult:
      errorLog("the geocode request yielded a partial result.")
    case .headingFailure:
      errorLog("the heading could not be determined.")
    case .locationUnknown:
      errorLog("the location manager was unable to obtain a location value right now.")
    case .network:
      errorLog("the network was unavailable or a network error occurred.")
    case .rangingFailure:
      errorLog("a general ranging error occurred.")
    case .rangingUnavailable:
      errorLog("ranging is disabled.")
    case .regionMonitoringDenied:
      errorLog("access to the region monitoring service was denied by the user.")
    case .regionMonitoringFailure:
      errorLog("a registered region cannot be monitored.")
    case .regionMonitoringResponseDelayed:
      errorLog("Core Location will deliver events but they may be delayed.")
    case .regionMonitoringSetupDelayed:
      errorLog("Core Location could not initialize the region monitoring feature immediately.")
    }
    return "위치 권한을 확인해 주세요."
  }
}
