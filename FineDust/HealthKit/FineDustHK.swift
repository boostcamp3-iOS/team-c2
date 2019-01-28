//
//  FineDustHK.swift
//  FineDust
//
//  Created by zun on 24/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit
import HealthKit

final class FineDustHK: OpenHealthDelegate {
  
  // MARK: - Properties
  
  static let shared = FineDustHK()
  
  ///Health 앱 데이터 권한을 요청하기 위한 프로퍼티
  private let healthStore = HKHealthStore()
  ///Health 앱 데이터 중 걸음 수를 가져오기 위한 프로퍼티
  private let stepCount = HKObjectType.quantityType(
    forIdentifier: HKQuantityTypeIdentifier.stepCount
  )
  ///Health 앱 데이터 중 걸은 거리를 가져오기 위한 프로퍼티
  private let distance = HKObjectType.quantityType(
    forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning
  )
  ///Health App 권한을 나타내는 변수
  private var isAuthorized = true
  
  // MARK: - Methods
  
  private init() { }
  
  func requestAuthorization() {
    guard let stepCount = stepCount else {
      print("step count request error")
      return
    }
    guard let distance = distance else {
      print("distance request error")
      return
    }
    //권한이 없을 경우 사용자가 직접 허용을 해야하게끔 해주기 위해 변수를 false로 설정
    if healthStore.authorizationStatus(for: stepCount) == .sharingDenied
      || healthStore.authorizationStatus(for: distance) == .sharingDenied {
      isAuthorized = false
      return
    }
    
    //걸음 데이터를 얻기 위해 Set을 만든 다음 권한 요청.
    let healthKitTypes: Set = [stepCount, distance]
    
    healthStore.requestAuthorization(
      toShare: healthKitTypes,
      read: healthKitTypes
    ) { _, error in
      if let err = error {
        print("request authorization error : \(err.localizedDescription)")
      } else {
        print("complete request authorization")
      }
    }
  }
  
  //권한이 없을경우 건강 App으로 이동시키는 메소드
  func openHealth(_ viewController: UIViewController) {
    if !isAuthorized {
      //이 코드로 인해 alert가 1번만 뜨게된다.
      isAuthorized = true
      UIAlertController
        .alert(
          title: "건강 App에 대한 권한이 없습니다.",
          message: "App을 이용하려면 건강 App에 대한 권한이 필요합니다. 건강 -> 3번째 탭 데이터 소스 -> FineDust -> 권한허용을 해주세요"
        )
        .action(
          title: "건강 App",
          style: .default
          ) { _, _ in
            UIApplication.shared.open(URL(string: "x-apple-health://")!)
        }
        .action(
          title: "취소", style: .cancel, handler: nil
        )
        .present(to: viewController)
    }
  }
}
