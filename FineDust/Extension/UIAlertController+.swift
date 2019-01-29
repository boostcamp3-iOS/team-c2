//
//  UIAlertController+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension UIAlertController {
  /// `UIAlertController` Helper.
  static func alert(
    title: String?,
    message: String?,
    style: UIAlertController.Style = .alert
  ) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    return alert
  }
  
  /// `addTextField(_:)` Helper.
  @discardableResult
  func textField(_ configuration: ((UITextField) -> Void)? = nil) -> UIAlertController {
    addTextField(configurationHandler: configuration)
    return self
  }
  
  /// `UIAlertAction` Helper.
  @discardableResult
  func action(
    title: String?,
    style: UIAlertAction.Style = .default,
    handler: ((UIAlertAction, [UITextField]?) -> Void)? = nil
  ) -> UIAlertController {
    guard let textFields = textFields else {
      let action = UIAlertAction(title: title, style: style) { handler?($0, nil) }
      addAction(action)
      return self
    }
    let action = UIAlertAction(title: title, style: style) { handler?($0, textFields) }
    addAction(action)
    return self
  }
  
  /// 빌더 패턴을 통해 만들어진 `UIAlertController` present.
  func present(
    to viewController: UIViewController?,
    animated: Bool = true,
    handler: (() -> Void)? = nil
  ) {
    DispatchQueue.main.async {
      viewController?.present(self, animated: animated, completion: handler)
    }
  }
}
