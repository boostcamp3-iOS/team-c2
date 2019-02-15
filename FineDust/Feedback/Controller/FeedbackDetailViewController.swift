//
//  FeedbackDetailViewController.swift
//  FineDust
//
//  Created by Presto on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class FeedbackDetailViewController: UIViewController {
  @IBOutlet private weak var feedbackImageView: UIImageView!
  @IBOutlet private weak var feedbackTitleLabel: UILabel!
  @IBOutlet private weak var feedbackSourceLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var contentLabel: UILabel!
  @IBOutlet private weak var bookmarkButton: UIButton!
  
  var feedbackListService = FeedbackListService(jsonManager: JSONManager())
  var passedValue: String = ""
  var dustFeedback: DustFeedback?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dustFeedback = feedbackListService.fetchFeedbackbyTitle(title: passedValue)
    setFeedback(dustFeedback: dustFeedback!)
  }
  
  func setFeedback(dustFeedback: DustFeedback) {
    feedbackTitleLabel.text = dustFeedback.title
    feedbackSourceLabel.text = dustFeedback.source
    dateLabel.text = dustFeedback.date
    contentLabel.text = dustFeedback.contents
    feedbackImageView.image = UIImage(named: dustFeedback.imageName)
  }
}
