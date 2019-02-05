//
//  RecommendCollectionViewCell.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class RecommendCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var recommendImageView: UIImageView!
  @IBOutlet weak var recommendTitleLabel: UILabel!
  
  func setProperties() {
    recommendImageView.layer.cornerRadius = 5
    recommendImageView.layer.masksToBounds = true
    recommendImageView.image = UIImage(named: "info1")
  }
}
