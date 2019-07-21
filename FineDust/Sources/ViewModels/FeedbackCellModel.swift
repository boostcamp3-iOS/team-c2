//
//  FeedbackListCellModel.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import RxRelay
import RxSwift

protocol FeedbackCellModelInputs {
  
  func tapBookmarkButton()
}

protocol FeedbackCellModelOutputs {
  
  var bookmarkButtonTapped: Observable<Void> { get }
}

final class FeedbackCellModel {
  
  private let bookmarkButtonTappedRelay = PublishRelay<Void>()
}

extension FeedbackCellModel: FeedbackCellModelInputs {
  
  func tapBookmarkButton() {
    bookmarkButtonTappedRelay.accept(Void())
  }
}

extension FeedbackCellModel: FeedbackCellModelOutputs {
  
  var bookmarkButtonTapped: Observable<Void> {
    return bookmarkButtonTappedRelay.asObservable()
  }
}

extension FeedbackCellModel {
  
  var inputs: FeedbackCellModelInputs { return self }
  
  var outputs: FeedbackCellModelOutputs { return self }
}
