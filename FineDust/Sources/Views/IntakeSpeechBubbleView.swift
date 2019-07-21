//
//  SpeechBalloonView.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class IntakeSpeechBubbleView: UIView {
  
  enum DustType {
    
    case fineDust
    
    case ultrafineDust
  }
  
  private let disposeBag = DisposeBag()
  
  fileprivate let viewModel = IntakeSpeechBubbleViewModel()
  
  @IBOutlet private weak var balloonImageView: UIImageView!
  
  @IBOutlet private weak var upperLabel: UILabel!
  
  @IBOutlet private weak var centerLabel: UILabel!
  
  @IBOutlet private weak var valueLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    bindViewModel()
    upperLabel.text = "오늘 마신"
  }
}

private extension IntakeSpeechBubbleView {
  
  func bindViewModel() {
    viewModel.dustType
      .map { $0 == .fineDust ? "미세먼지" : "초미세먼지" }
      .bind(to: centerLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.dustType
      .map { $0 == .fineDust ? #imageLiteral(resourceName: "speechBubble1") : #imageLiteral(resourceName: "speechBubble2") }
      .bind(to: balloonImageView.rx.image)
      .disposed(by: disposeBag)
    
    viewModel.value
      .map { "\($0)μg" }
      .bind(to: valueLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

extension Reactive where Base: IntakeSpeechBubbleView {
  
  var dustType: Binder<IntakeSpeechBubbleView.DustType> {
    return .init(base) { base, dustType in
      base.viewModel.setDustType(dustType)
    }
  }
  
  var value: Binder<Int> {
    return .init(base) { base, value in
      base.viewModel.setValue(value)
    }
  }
}
