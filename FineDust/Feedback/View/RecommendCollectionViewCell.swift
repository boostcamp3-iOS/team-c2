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

  @IBOutlet weak var recommendImageView: UIImageView!
  @IBOutlet weak var recommendTitleLabel: UILabel!
  
  fileprivate let jsonManager = JSONManager()
  fileprivate var dustFeedbacks: [DustFeedbacks] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setImageView()
  }
  
  /// 셀 데이터 및 UI 설정
  func setCollectionViewCellProperties(at index: Int) {
    dustFeedbacks = jsonManager.fetchDustFeedbacks()
    
    recommendImageView.image = UIImage(named: dustFeedbacks[index].imageName )
    recommendTitleLabel.text = dustFeedbacks[index].title
  }
  
  func setImageView() {
    recommendImageView.layer.cornerRadius = 5
    recommendImageView.layer.masksToBounds = true
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    recommendImageView.image = nil
    recommendTitleLabel.text = nil
  }
}
