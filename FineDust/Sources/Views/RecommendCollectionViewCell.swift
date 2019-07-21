//
//  RecommendCollectionViewCell.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 3번째 탭 상단 정보 추천 컬렉션뷰셀. 
final class RecommendCollectionViewCell: UICollectionViewCell {

  @IBOutlet private weak var recommendImageView: UIImageView!
  @IBOutlet private weak var recommendTitleLabel: UILabel!
  
  var title: String {
    return recommendTitleLabel.text ?? ""
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setImageView()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    recommendImageView.image = nil
    recommendTitleLabel.text = nil
  }
  
  /// 컬렉션뷰셀 데이터 설정
  func setCollectionViewCellProperties(dustFeedback: FeedbackContents) {
    recommendImageView.image = UIImage(named: dustFeedback.imageName)?.resize(newWidth: 330)
    recommendTitleLabel.text = dustFeedback.title
  }
  
  /// 컬렉션뷰셀 이미지 UI 설정
  private func setImageView() {
    contentView.layer.applyBorder(color: .clear, width: 0.0, radius: 5.0)
  }
}
