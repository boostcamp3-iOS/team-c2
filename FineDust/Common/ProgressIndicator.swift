//
//  ProgressIndicator.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 네트워크 인디케이터 뷰
final class ProgressIndicator: UIView {
  
  /// 배경 뷰
  private var backgroundView: UIView! {
    didSet {
      backgroundView.backgroundColor = .black
      backgroundView.clipsToBounds = true
      backgroundView.layer.cornerRadius = 10
      addSubview(backgroundView)
      NSLayoutConstraint.activate([
        backgroundView.centerX.equal(to: centerX),
        backgroundView.centerY.equal(to: centerY),
        backgroundView.width.equal(toConstant: 100),
        backgroundView.height.equal(toConstant: 100)
        ])
    }
  }
  
  // 액티비티 인디케이터
  private var indicator: UIActivityIndicatorView! {
    didSet {
      indicator.style = .whiteLarge
      backgroundView.addSubview(indicator)
      NSLayoutConstraint.activate([
        indicator.centerX.equal(to: backgroundView.centerX),
        indicator.centerY.equal(to: backgroundView.centerY)
        ])
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    backgroundColor = .clear
    backgroundView = UIView()
    indicator = UIActivityIndicatorView()
  }
  
  /// `ProgressIndicator.show()`로 인디케이터 표시
  func show() {
    DispatchQueue.main.async { [weak self] in
      guard let `self` = self else { return }
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      if let window = UIApplication.shared.keyWindow {
        window.addSubview(self.backgroundView)
      }
    }
  }
  
  /// `ProgressIndicator.hide()`로 인디케이터 표시
  func hide() {
    DispatchQueue.main.async { [weak self] in
      guard let `self` = self else { return }
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      self.backgroundView.removeFromSuperview()
    }
  }
}
