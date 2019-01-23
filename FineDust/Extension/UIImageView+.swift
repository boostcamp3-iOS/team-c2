//
//  UIImageView+.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension UIImageView {
  func setRounded() {
    layer.cornerRadius = frame.height / 2
    layer.masksToBounds = true
  }
}
