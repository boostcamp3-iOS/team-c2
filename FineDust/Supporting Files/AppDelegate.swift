//
//  AppDelegate.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import CoreLocation
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  private lazy var locationManager: CLLocationManager = {
    let manager = CLLocationManager()
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.distanceFilter = kCLDistanceFilterNone
    manager.delegate = self
    return manager    
  }()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window?.tintColor = Asset.graph1.color
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().barTintColor = Asset.graph1.color
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    UITabBar.appearance().tintColor = .white
    UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
    UITabBar.appearance().barTintColor = Asset.graph1.color
    UITextField.appearance().tintColor = .clear
    locationManager.requestAlwaysAuthorization()
    FineDustHK.shared.requestAuthorization()
    toggleFirstExecutionFlag()
    fetchAPI()
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) { }
  
  func applicationDidEnterBackground(_ application: UIApplication) { }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    fetchAPI()
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) { }
  
  func applicationWillTerminate(_ application: UIApplication) {
    self.saveContext()
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "FineDust")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}

extension AppDelegate: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("위치 갱신됨")
    let locale = Locale(identifier: "ko_KR")
    guard let location = locations.last else { return }
    let coordinate = location.coordinate
    let convertedCoordinate = GeoConverter().convert(
      sourceType: .WGS_84,
      destinationType: .TM,
      geoPoint: GeographicPoint(x: coordinate.longitude, y: coordinate.latitude)
    )
    GeoInfo.shared.setLocation(x: convertedCoordinate?.x ?? 0, y: convertedCoordinate?.y ?? 0)
    CLGeocoder().reverseGeocodeLocation(location, preferredLocale: locale) { placeMarks, error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      // administrativeArea / country / locality / name
      // 서울특별시 / 대한민국 / 강남구 / 강남대로 382
    }
    manager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("GPS Error: \(error.localizedDescription)")
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print("권한 허가 상태 변경: \(status)")
    if status == .authorizedWhenInUse || status == .authorizedAlways {
      locationManager.startUpdatingLocation()
    }
  }
}

// MARK: - API 응답 초기화

private extension AppDelegate {
  /// API 호출하는 메소드
  func fetchAPI() {
    DispatchQueue.global(qos: .background).async { [weak self] in
      guard let `self` = self else { return }
      self.fetchObservatory(self.fetchFineDustConcentration)
    }
  }
  
  /// 관측소 정보를 가져오는 메소드
  func fetchObservatory(_ completion: @escaping () -> Void) {
    API.shared.fetchObservatory { response, error in
      if let error = error {
        NotificationCenter.default.post(
          name: .fetchObservatoryDidError,
          object: nil,
          userInfo: ["error": error]
        )
        return
      }
      guard let response = response else { return }
      FineDustInfo.shared.set(observatory: response.observatory ?? "")
      completion()
    }
  }
  
  /// 미세먼지 농도 정보를 가져오는 메소드
  func fetchFineDustConcentration() {
    API.shared.fetchFineDustConcentration(term: .daily) { response, error in
      if let error = error {
        NotificationCenter.default.post(
          name: .fetchFineDustConcentrationDidError,
          object: nil,
          userInfo: ["error": error]
        )
        return
      }
      guard let response = response else { return }
      FineDustInfo.shared.set(fineDustResponse: response)
    }
  }
}

// MARK: - 첫 실행시에만 호출

extension AppDelegate {
  /// 첫 실행시에만 날짜를 저장하도록 함
  func toggleFirstExecutionFlag() {
    if !UserDefaults.standard.bool(forKey: "isFirstExecution") {
      CoreDataManager.shared.save([User.installedDate: Date()], forType: User.self) { error in
        if let error = error {
          print(error.localizedDescription)
          return
        }
        UserDefaults.standard.set(true, forKey: "isFirstExecution")
      }
    }
  }
}
