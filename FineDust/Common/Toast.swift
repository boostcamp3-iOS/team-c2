//
//  Toast.swift
//  FineDust
//
//  Created by Presto on 13/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

/// 간단한 메세지를 띄우는 토스트 정의.
final class Toast {
  
  /// Singleton Object
  static let shared = Toast()
  
  private init() { }
  
  /// 토스트 보이기.
  func show(_ message: String?, duration: TimeInterval = 4.0) {
    DispatchQueue.main.async {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 13, weight: .light)
      label.backgroundColor = .lightGray
      label.textAlignment = .center
      label.text = message
      label.sizeToFit()
      label.bounds.size = CGSize(width: label.bounds.width + 40, height: label.bounds.height + 20)
      label.center = CGPoint(
        x: UIScreen.main.bounds.width / 2,
        y: UIScreen.main.bounds.height - 49 - 64
      )
      label.layer.cornerRadius = label.bounds.height / 2
      label.layer.masksToBounds = true
      label.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: 4, blur: 16, spread: 0)
      label.alpha = 0
      if let window = UIApplication.shared.keyWindow {
        window.addSubview(label)
        UIView.animate(withDuration: 0.3) {
          label.alpha = 1
        }
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { timer in
          UIView.animate(
            withDuration: 0.3,
            animations: {
              label.alpha = 0
            },
            completion: { _ in
              label.removeFromSuperview()
            }
          )
          timer.invalidate()
        }
      }
    }
  }
}
