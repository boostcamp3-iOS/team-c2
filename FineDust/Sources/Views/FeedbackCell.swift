//
//  FeedbackListTableViewCell.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class FeedbackCell: UITableViewCell {
  
  private let disposeBag = DisposeBag()
  
  fileprivate let viewModel = FeedbackCellModel()
  
  @IBOutlet private weak var feedbackImageView: UIImageView!
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  @IBOutlet private weak var sourceLabel: UILabel!
  
  @IBOutlet private weak var dateLabel: UILabel!
  
  @IBOutlet private weak var bookmarkButton: UIButton!
  
  var title: String {
    return titleLabel.text ?? ""
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    bindViewModel()
    feedbackImageView.layer
      .applyBorder(color: .clear, width: 0, radius: feedbackImageView.bounds.height / 2)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    resetViews()
  }
  
  func configure(with feedbackContents: FeedbackContents) {
    feedbackImageView.image = UIImage(named: feedbackContents.imageName)?.resize(newWidth: 150)
    titleLabel.text = feedbackContents.title
    sourceLabel.text = feedbackContents.source
    dateLabel.text = feedbackContents.date
  }
  
  func setBookmarkButtonState(isBookmarkedByTitle: [String: Bool]) {
    let isBookmarked = isBookmarkedByTitle[title] ?? false
    bookmarkButton.imageView?.image
      = isBookmarked ? Asset.yellowStar.image : Asset.starOutline.image
    bookmarkButton.isSelected = isBookmarked
  }
}

// MARK: - Private Method

private extension FeedbackCell {
  
  func bindViewModel() {
    bookmarkButton.rx.tap.asDriver()
      .drive(onNext: { [weak self] _ in
        self?.viewModel.tapBookmarkButton()
      })
      .disposed(by: disposeBag)
  }
  
  func resetViews() {
    feedbackImageView.image = nil
    titleLabel.text = nil
    sourceLabel.text = nil
    bookmarkButton.isSelected = false
  }
}

// MARK: - Reactive Extension

extension Reactive where Base: FeedbackCell {
  
  var bookmarkButtonTapped: ControlEvent<Void> {
    return .init(events: base.viewModel.bookmarkButtonTapped)
  }
}
