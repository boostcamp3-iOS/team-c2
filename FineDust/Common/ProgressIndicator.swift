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
  
  // MARK: Singleton Object
  static let shared = ProgressIndicator(frame: UIScreen.main.bounds)
  
  /// 배경 뷰
  private var backgroundView: UIVisualEffectView! {
    didSet {
      backgroundView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(backgroundView)
      NSLayoutConstraint.activate([
        backgroundView.anchor.top.equal(to: anchor.top),
        backgroundView.anchor.leading.equal(to: anchor.leading),
        backgroundView.anchor.bottom.equal(to: anchor.bottom),
        backgroundView.anchor.trailing.equal(to: anchor.trailing)
        ])
    }
  }
  
  // 액티비티 인디케이터
  private var indicator: UIActivityIndicatorView! {
    didSet {
      indicator.style = .gray
      indicator.hidesWhenStopped = true
      indicator.translatesAutoresizingMaskIntoConstraints = false
      backgroundView.contentView.addSubview(indicator)
      NSLayoutConstraint.activate([
        indicator.anchor.centerX.equal(to: backgroundView.anchor.centerX),
        indicator.anchor.centerY.equal(to: backgroundView.anchor.centerY)
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
    backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    indicator = UIActivityIndicatorView()
  }
  
  /// `ProgressIndicator.shared.show()`로 인디케이터 표시
  func show() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      self.indicator.startAnimating()
      if let window = UIApplication.shared.keyWindow {
        window.addSubview(self)
      }
    }
  }
  
  /// `ProgressIndicator.shared.hide()`로 인디케이터 표시
  func hide() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      self.indicator.stopAnimating()
      self.removeFromSuperview()
    }
  }
}
