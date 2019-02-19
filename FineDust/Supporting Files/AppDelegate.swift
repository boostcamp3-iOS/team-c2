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

  var healthKitManager = HealthKitManager()
  
  let coreDataService = CoreDataService()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window?.tintColor = Asset.graph2.color
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().barTintColor = .white
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    UITabBar.appearance().tintColor = Asset.graph1.color
    UITabBar.appearance().unselectedItemTintColor = .lightGray
    UITabBar.appearance().barTintColor = .white
    // 헬스킷 권한 요청
    // 위치 권한 요청
    // 최신 접속 날짜 갱신
    healthKitManager.requestAuthorization()
    LocationManager.shared.requestAuthorization()
    
    coreDataService.requestLastAccessedDate { date, error in
      print(date, error)
      if let error = error as NSError? {
        // 에러가 넘어온 경우
        if error.domain == "CoreDataNoUser" {
          // 그 에러가 첫 접속에 의해 유저 정보가 기록되지 않은 에러라면
          // 첫 접속 날짜를 저장
          self.coreDataService.saveLastAccessedDate { error in
            if let error = error {
              // 저장 도중 에러가 발생한다면 로그 찍어줌
              print("첫 접속 날짜 저장 실패: ", error.localizedDescription)
            } else {
              print("현재 Date로 첫 접속 날짜 갱신")
              self.coreDataService.requestLastAccessedDate(completion: { date, error in
                print(date, error)
              })
            }
          }
        } else {
          // 그렇지 않은 에러라면
          // 에러 로그를 찍음
          print("첫 접속 날짜 관련 알 수 없는 에러", error.localizedDescription)
        }
      } else {
        // 에러가 없는 경우 날짜 로그를 찍어줌
        print("첫 접속 날짜가 이미 기록되어 있음: ", date ?? "?")
      }
    }
    
//    coreDataService.requestLastAccessedDate { date, error in
//      if let error = error {
//        Toast.shared.show(error.localizedDescription)
//        print(error.localizedDescription)
//        return
//      }
//      print("최신 접속 날짜 갱신: ", date ?? "?")
//    }
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) { }
  
  func applicationDidEnterBackground(_ application: UIApplication) { }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // 포어그라운드 진입시 위치 정보 갱신
    LocationManager.shared.startUpdatingLocation()
    
    if healthKitManager.authorizationStatus ==
      (.sharingAuthorized, .sharingAuthorized) {
      NotificationCenter.default.post(
        name: .healthKitAuthorizationSharingAuthorized,
        object: nil,
        userInfo: nil
      )
    }
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
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
