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
  func setTabelViewCellProperties(dustFeedback: DustFeedback) {
    
    feedbackImageView.image = UIImage(named: dustFeedback.imageName)
    feedbackTitleLabel.text = dustFeedback.title
    feedbackSourceLabel.text = dustFeedback.source
    feedbackDateLabel.text = dustFeedback.date
  }
  
  /// 북마크 버튼 이미지 설정
  func setBookmarkButtonImage(bookmarkDictionary: [String: Bool]) {
    bookmarkButton.imageView?.image = bookmarkDictionary[title] ?? false ?
      UIImage(named: Asset.yellowStar.name) : UIImage(named: Asset.starOutline.name)
  }
  
  /// 테이블뷰셀 이미지 UI 설정
  private func setImageView() {
    feedbackImageView.setRounded()
  }
}
