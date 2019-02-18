//
//  FeedbackDetailViewController.swift
//  FineDust
//
//  Created by Presto on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 피드백 정보 상세 화면
final class FeedbackDetailViewController: UIViewController {
  @IBOutlet private weak var feedbackImageView: UIImageView!
  @IBOutlet private weak var feedbackTitleLabel: UILabel!
  @IBOutlet private weak var feedbackSourceLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var contentLabel: UILabel!
  @IBOutlet private weak var bookmarkButton: UIButton!
  
  private let feedbackListService = FeedbackListService(jsonManager: JSONManager())
  var feedbackTitle: String = ""
  private var dustFeedback: DustFeedback?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let dustFeedback = feedbackListService.fetchFeedback(by: feedbackTitle) {
      setFeedback(dustFeedback)
    }
  }
  
  /// 뷰컨 데이터 설정
  func setFeedback(_ dustFeedback: DustFeedback) {
    feedbackTitleLabel.text = dustFeedback.title
    feedbackSourceLabel.text = dustFeedback.source
    dateLabel.text = dustFeedback.date
    contentLabel.text = dustFeedback.contents
    feedbackImageView.image = UIImage(named: dustFeedback.imageName)
  }
}
