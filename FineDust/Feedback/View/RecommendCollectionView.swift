//
//  RecommendCollectionView.swift
//  FineDust
//
//  Created by 이재은 on 05/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class RecommendCollectionView: UICollectionViewFlowLayout {

   private let reuseIdentifier = "recommendCollectionCell"

}

// MARK: - UICollectionViewDataSource

extension RecommendCollectionView: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int
    ) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier,
      for: indexPath
      ) as? RecommendCollectionViewCell
      else { return UICollectionViewCell() }
    
    cell.setProperties()
    //    cell.feedbackTitleLabel.text = "미세먼지 정화 식물"
    //    cell.feedbackTitleLabel.layer.cornerRadius = cornerRadius
    //    cell.feedbackTitleLabel.layer.masksToBounds = true
    
    return cell
  }
}
