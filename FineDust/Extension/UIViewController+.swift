//
//  UIViewController+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension UIViewController {
  
  /// `UIViewController` instantiate.
  static func instantiate(fromStoryboard storyboard: String,
                          identifier: String) -> UIViewController {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: identifier)
    return controller
  }
  
  /// instantiate된 `UIViewController` 구성
  @discardableResult
  func configure<T: UIViewController>(_ configureHandler: (T) -> Void) -> UIViewController {
    if let casted = self as? T {
      configureHandler(casted)
    }
    return self
  }
  
  /// 빌더 패턴을 통해 만들어진 `UIViewController`를 모달 present.
  func present(to viewController: UIViewController,
               transitionStyle style: UIModalTransitionStyle = .coverVertical,
               animated: Bool = true,
               completion: (() -> Void)? = nil) {
    modalTransitionStyle = style
    if !(viewController.presentedViewController is UIAlertController) {
      DispatchQueue.main.async {
        viewController.present(self, animated: animated, completion: completion)
      }
    }
  }
  
  /// 빌더 패턴을 통해 만들어진 `UIViewController`를 내비게이션 스택에 추가.
  func push(at viewController: UIViewController?, animated: Bool = true) {
    if let navigationController = viewController?.navigationController {
      DispatchQueue.main.async {
        navigationController.pushViewController(self, animated: animated)
      }
    } else {
      fatalError("해당 ViewController는 Navigation 스택에 있지 않습니다.")
    }
  }
}
