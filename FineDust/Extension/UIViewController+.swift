//
//  UIViewController+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension UIViewController {
  static func create(fromStoryboard storyboard: String, identifier: String) -> UIViewController {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: identifier)
    return controller
  }
  
  @discardableResult
  func deliver(_ closure: (UIViewController) -> Void) -> UIViewController {
    closure(self)
    return self
  }
  
  func present(
    to viewController: UIViewController,
    transitionStyle style: UIModalTransitionStyle = .coverVertical,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    modalTransitionStyle = style
    viewController.present(self, animated: animated, completion: completion)
  }
  
  func push(at navigationController: UINavigationController?, animated: Bool = true) {
    navigationController?.pushViewController(self, animated: animated)
  }
}
