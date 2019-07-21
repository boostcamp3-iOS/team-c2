//
//  FeedbackDetailViewController.swift
//  FineDust
//
//  Created by Presto on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class FeedbackDetailViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  fileprivate let viewModel = FeedbackDetailViewModel()
  
  @IBOutlet private weak var backButton: UIButton!
  
  @IBOutlet private weak var bookmarkButton: UIButton!
  
  @IBOutlet private weak var imageScrollView: UIScrollView!
  
  @IBOutlet private weak var totalScrollView: UIScrollView!
  
  @IBOutlet private weak var imageView: UIImageView!
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  @IBOutlet private weak var sourceLabel: UILabel!
  
  @IBOutlet private weak var dateLabel: UILabel!
  
  @IBOutlet private weak var contentLabel: UILabel!
  
  // MARK: - Properties
  
  private let feedbackListService = FeedbackService()
  var feedbackTitle: String = ""
  private var dustFeedback: FeedbackContents?
  private var isBookmarkedByTitle: [String: Bool] = [:]
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    
    imageScrollView.delegate = self
    
    isBookmarkedByTitle
      = UserDefaults.standard.dictionary(forKey: "isBookmarkedByTitle") as? [String: Bool] ?? [:]
    
    if let dustFeedback = feedbackListService.fetchFeedback(by: feedbackTitle) {
      setFeedback(dustFeedback)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    isBookmarkedByTitle = feedbackListService.isBookmarkedByTitle
    setBookmarkButtonState(isBookmarkedByTitle: isBookmarkedByTitle)
  }
  
  /// 북마크 버튼 이미지 설정
  func setBookmarkButtonState(isBookmarkedByTitle: [String: Bool]) {
    let isBookmarked = isBookmarkedByTitle[feedbackTitle] ?? false
    bookmarkButton.imageView?.image
      = isBookmarked ? Asset.yellowStar.image : Asset.starOutline.image
    bookmarkButton.isSelected = isBookmarked
  }
}

// MARK: - Private Method

private extension FeedbackDetailViewController {
  
  func bindViewModel() {
    backButton.rx.tap.asDriver()
      .drive(onNext: { [weak self] _ in
        self?.viewModel.tapBackButton()
      })
      .disposed(by: disposeBag)
    
    bookmarkButton.rx.tap.asDriver()
      .drive(onNext: { [weak self] _ in
        self?.viewModel.tapBookmarkButton()
      })
      .disposed(by: disposeBag)
    
    viewModel.backButtonTapped.asDriver(onErrorJustReturn: Void())
      .drive(onNext: { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
      })
      .disposed(by: disposeBag)
    
    viewModel.bookmarkButtonTapped.asDriver(onErrorJustReturn: Void())
      .drive(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.bookmarkButton.isSelected.toggle()
        if self.bookmarkButton.isSelected {
          self.isBookmarkedByTitle[self.feedbackTitle] = true
          self.feedbackListService.saveBookmark(by: self.feedbackTitle)
        } else {
          self.isBookmarkedByTitle[self.feedbackTitle] = false
          self.feedbackListService.deleteBookmark(by: self.feedbackTitle)
        }
      })
      .disposed(by: disposeBag)
  }
  
  func setFeedback(_ feedbackContents: FeedbackContents) {
    titleLabel.text = feedbackContents.title
    sourceLabel.text = feedbackContents.source
    dateLabel.text = feedbackContents.date
    contentLabel.text = feedbackContents.contents
    imageView.image = UIImage(named: feedbackContents.imageName)?
      .resize(newWidth: UIScreen.main.bounds.width)
  }
}

// MARK: - Implement UIScrollViewDelegate

extension FeedbackDetailViewController: UIScrollViewDelegate {
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}
