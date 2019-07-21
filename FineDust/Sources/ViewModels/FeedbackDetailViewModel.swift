//
//  FeedbackDetailViewModel.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import RxRelay
import RxSwift

protocol FeedbackDetailViewModelInputs {
  
  func tapBackButton()
  
  func tapBookmarkButton()
}

protocol FeedbackDetailViewModelOutputs {
  
  var backButtonTapped: Observable<Void> { get }
  
  var bookmarkButtonTapped: Observable<Void> { get }
}

final class FeedbackDetailViewModel {
  
  private let backButtonTappedRelay = PublishRelay<Void>()
  
  private let bookmarkButtonTappedRelay = PublishRelay<Void>()
}

extension FeedbackDetailViewModel: FeedbackDetailViewModelInputs {
  
  func tapBackButton() {
    backButtonTappedRelay.accept(Void())
  }
  
  func tapBookmarkButton() {
    bookmarkButtonTappedRelay.accept(Void())
  }
}

extension FeedbackDetailViewModel: FeedbackDetailViewModelOutputs {
  
  var backButtonTapped: Observable<Void> {
    return backButtonTappedRelay.asObservable()
  }
  
  var bookmarkButtonTapped: Observable<Void> {
    return bookmarkButtonTappedRelay.asObservable()
  }
}

extension FeedbackDetailViewModel {
  
  var inputs: FeedbackDetailViewModelInputs { return self }
  
  var outputs: FeedbackDetailViewModelOutputs { return self }
}
