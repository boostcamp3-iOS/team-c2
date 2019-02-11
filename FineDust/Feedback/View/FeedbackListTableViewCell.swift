//
//  FeedbackListTableViewCell.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 3번째 탭 하단 정보 목록 테이블뷰셀.
final class FeedbackListTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var feedbackImageView: UIImageView!
  @IBOutlet private weak var feedbackTitleLabel: UILabel!
  @IBOutlet private weak var feedbackSourceLabel: UILabel!
  @IBOutlet private weak var bookmarkButton: UIButton!
  
  let jsonManager = JSONManager()
  fileprivate var dustFeedbacks: [DustFeedbacks] = []
  /// 테이블뷰셀 데이터 및 UI 설정
  func setTabelViewCellProperties(at index: Int) {
    dustFeedbacks = jsonManager.fetchDustFeedbacks()
    
    feedbackImageView.image = UIImage(named: dustFeedbacks[index].imageName)
    feedbackTitleLabel.text = dustFeedbacks[index].title
    feedbackSourceLabel.text = dustFeedbacks[index].source
    
    feedbackImageView.setRounded()
    
  }
}
