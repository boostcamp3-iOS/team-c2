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
  
  // MARK: - IBOutlets
  
  @IBOutlet private weak var imageScrollView: UIScrollView!
  @IBOutlet private weak var totalScrollView: UIScrollView!
  @IBOutlet private weak var feedbackImageView: UIImageView!
  @IBOutlet private weak var feedbackTitleLabel: UILabel!
  @IBOutlet private weak var feedbackSourceLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var contentLabel: UILabel!
  @IBOutlet private weak var bookmarkButton: UIButton!
  
  // MARK: - Properties
  
  private let feedbackListService = FeedbackListService(jsonManager: JSONManager())
  var feedbackTitle: String = ""
  private var dustFeedback: DustFeedback?
  private var isBookmarkedByTitle: [String: Bool] = [:]
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageScrollView.delegate = self
    
    isBookmarkedByTitle
      = UserDefaults.standard.dictionary(forKey: "isBookmarkedByTitle") as? [String: Bool] ?? [:]
    
    if let dustFeedback = feedbackListService.fetchFeedback(by: feedbackTitle) {
      setFeedback(dustFeedback)
      setBookmarkButtonState(isBookmarkedByTitle: isBookmarkedByTitle)
    }
  }
  
  // MARK: - IBAction
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func bookmarkButtonDidTap(button: UIButton) {
    button.isSelected.toggle()
    if button.isSelected {
      isBookmarkedByTitle[feedbackTitle] = true
      feedbackListService.saveBookmark(by: feedbackTitle)
    } else {
      isBookmarkedByTitle[feedbackTitle] = false
      feedbackListService.deleteBookmark(by: feedbackTitle)
    }
  }
  
  // MARK: - Function
  
  /// 뷰컨 데이터 설정
  func setFeedback(_ dustFeedback: DustFeedback) {
    feedbackTitleLabel.text = dustFeedback.title
    feedbackSourceLabel.text = dustFeedback.source
    dateLabel.text = dustFeedback.date
    contentLabel.text = dustFeedback.contents
    feedbackImageView.image = UIImage(named: dustFeedback.imageName)?
      .resize(newWidth: UIScreen.main.bounds.width)
  }
  
  /// 북마크 버튼 이미지 설정
  func setBookmarkButtonState(isBookmarkedByTitle: [String: Bool]) {
    let isBookmarked = isBookmarkedByTitle[feedbackTitle] ?? false
    bookmarkButton.imageView?.image
      = isBookmarked ? Asset.yellowStar.image : Asset.starOutline.image
    bookmarkButton.isSelected = isBookmarked
  }
}

extension FeedbackDetailViewController: UIScrollViewDelegate {
  /// 이미지 확대하기.
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return feedbackImageView
  }
  
}
