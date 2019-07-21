//
//  FeedbackViewModel.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import RxRelay
import RxSwift

protocol FeedbackViewModelInputs {
  
  func tapSettingButton()
}

protocol FeedbackViewModelOutputs {
  
  var settingButtonTapped: Observable<Void> { get }
}

final class FeedbackViewModel {
  
  private let settingButtonTappedRelay = PublishRelay<Void>()
}

extension FeedbackViewModel: FeedbackViewModelInputs {
  
  func tapSettingButton() {
    settingButtonTappedRelay.accept(Void())
  }
}

extension FeedbackViewModel: FeedbackViewModelOutputs {
  
  var settingButtonTapped: Observable<Void> {
    return settingButtonTappedRelay.asObservable()
  }
}

extension FeedbackViewModel {
  
  var inputs: FeedbackViewModelInputs { return self }

  var outputs: FeedbackViewModelOutputs { return self }
}

