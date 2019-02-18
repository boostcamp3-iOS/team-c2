//
//  FeedbackListTableViewCell.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

protocol FeedbackListCellDelegate: class {
  func feedbackListCell(_ feedbackListCell: FeedbackListTableViewCell,
                        didTapBookmarkButton button: UIButton)
}

/// 3번째 탭 하단 정보 목록 테이블뷰셀.
final class FeedbackListTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var feedbackImageView: UIImageView!
  @IBOutlet private weak var feedbackTitleLabel: UILabel!
  @IBOutlet private weak var feedbackSourceLabel: UILabel!
  @IBOutlet private weak var feedbackDateLabel: UILabel!
  @IBOutlet private weak var bookmarkButton: UIButton! {
    didSet {
      bookmarkButton.addTarget(self,
                               action: #selector(bookmarkButtonDidTap(_:)),
                               for: .touchUpInside)
    }
  }
  
  var title: String {
    return feedbackTitleLabel.text ?? ""
  }
  
  weak var delegate: FeedbackListCellDelegate?
  
  let jsonManager = JSONManager()
  private var dustFeedbacks: [DustFeedback] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setImageView()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    feedbackImageView.image = nil
    feedbackTitleLabel.text = nil
    feedbackSourceLabel.text = nil
    bookmarkButton.isSelected = false
  }
  
  @objc private func bookmarkButtonDidTap(_ sender: UIButton) {
    delegate?.feedbackListCell(self, didTapBookmarkButton: sender)
  }
  
  /// 테이블뷰셀 데이터 설정
  func setTableViewCellProperties(dustFeedback: DustFeedback) {
    
    feedbackImageView.image = UIImage(named: dustFeedback.imageName)?.resized(newWidth: 150)
    feedbackTitleLabel.text = dustFeedback.title
    feedbackSourceLabel.text = dustFeedback.source
    feedbackDateLabel.text = dustFeedback.date
  }
  
  /// 북마크 버튼 이미지 설정
  func setBookmarkButtonState(isBookmarkedByTitle: [String: Bool]) {
    let isBookmarked = isBookmarkedByTitle[title] ?? false
    bookmarkButton.imageView?.image
      = isBookmarked ? Asset.yellowStar.image : Asset.starOutline.image
    bookmarkButton.isSelected = isBookmarked
  }
  
  /// 테이블뷰셀 이미지 UI 설정
  private func setImageView() {
    feedbackImageView.layer.setBorder(color: .clear,
                                      width: 0.0,
                                      radius: feedbackImageView.bounds.height / 2)
  }
}
