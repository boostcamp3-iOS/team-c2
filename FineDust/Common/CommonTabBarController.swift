//
//  CommonTabBarController.swift
//  FineDust
//
//  Created by Presto on 23/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 탭 바 컨트롤러.
final class CommonTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let viewControllers = viewControllers {
      // 통계 뷰 컨트롤러 의존성 주입
      for (index, viewController) in viewControllers.enumerated() where index == 1 {
        (viewController as? StatisticsViewController)?
          .injectDependency(IntakeService(), CoreDataService())
      }
    }
  }
}
