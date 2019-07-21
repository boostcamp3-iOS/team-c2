//
//  IntakeSpeechBubbleViewModel.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import RxRelay
import RxSwift

protocol IntakeSpeechBubbleViewModelInputs {
  
  func setDustType(_ type: IntakeSpeechBubbleView.DustType)
  
  func setValue(_ value: Int)
}

protocol IntakeSpeechBubbleViewModelOutputs {
  
  var dustType: Observable<IntakeSpeechBubbleView.DustType> { get }
  
  var value: Observable<Int> { get }
}

final class IntakeSpeechBubbleViewModel {
  
  private let dustTypeRelay =  BehaviorRelay<IntakeSpeechBubbleView.DustType>(value: .fineDust)
  
  private let valueRelay = BehaviorRelay<Int>(value: 0)
}

extension IntakeSpeechBubbleViewModel: IntakeSpeechBubbleViewModelInputs {
  
  func setDustType(_ type: IntakeSpeechBubbleView.DustType) {
    dustTypeRelay.accept(type)
  }
  
  func setValue(_ value: Int) {
    valueRelay.accept(value)
  }
}

extension IntakeSpeechBubbleViewModel: IntakeSpeechBubbleViewModelOutputs {
  
  var dustType: Observable<IntakeSpeechBubbleView.DustType> {
    return dustTypeRelay.asObservable()
  }
  
  var value: Observable<Int> {
    return valueRelay.asObservable()
  }
}

extension IntakeSpeechBubbleViewModel {
  
  var inputs: IntakeSpeechBubbleViewModelInputs { return self }
  
  var outputs: IntakeSpeechBubbleViewModelOutputs { return self }
}
