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
      if let error = error {
        Toast.shared.show(error.localizedDescription)
        print(error.localizedDescription)
        return
      }
      print("최신 접속 날짜 갱신: ", date ?? "?")
    }
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) { }
  
  func applicationDidEnterBackground(_ application: UIApplication) { }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // 포어그라운드 진입시 위치 정보 갱신
    LocationManager.shared.startUpdatingLocation()
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
