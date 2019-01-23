//
//  UIView+NSLayoutAnchor.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension UIView {
  var top: NSLayoutYAxisAnchor {
    return topAnchor
  }
  
  var bottom: NSLayoutYAxisAnchor {
    return bottomAnchor
  }
  
  var leading: NSLayoutXAxisAnchor {
    return leadingAnchor
  }
  
  var trailing: NSLayoutXAxisAnchor {
    return trailingAnchor
  }
  
  var centerX: NSLayoutXAxisAnchor {
    return centerXAnchor
  }
  
  var centerY: NSLayoutYAxisAnchor {
    return centerYAnchor
  }
  
  var width: NSLayoutDimension {
    return widthAnchor
  }
  
  var height: NSLayoutDimension {
    return heightAnchor
  }
}
