//
//  UIAlertController+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

public extension UIAlertController {
  static func alert(
    title: String?,
    message: String?,
    style: UIAlertController.Style = .alert
  ) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    return alert
  }
  
  @discardableResult
  func textField(_ configuration: ((UITextField) -> Void)? = nil) -> UIAlertController {
    addTextField(configurationHandler: configuration)
    return self
  }
  
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
