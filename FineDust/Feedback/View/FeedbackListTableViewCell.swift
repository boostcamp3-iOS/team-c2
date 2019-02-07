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
  @IBOutlet private weak var feedbackListShadowView: UIView!
  @IBOutlet private weak var bookmarkButton: UIButton!
  
  /// 셀 데이터 및 UI 설정
  func setProperties(at index: Int) {
    feedbackImageView.image = UIImage(named: "info1")
    feedbackTitleLabel.text = "미세먼지 정화 식물"
    feedbackSourceLabel.text = "KTV 국민 방송"
    
    feedbackImageView.setRounded()
    feedbackListShadowView.layer.applySketchShadow(
      color: UIColor.gray,
      alpha: 0.2,
      x: 2,
      y: 2,
      blur: 5,
      spread: 3
    )
    feedbackListShadowView.layer.cornerRadius = 5
  }
}
