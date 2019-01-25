//
//  CarouselView.swift
//  FineDust
//
//  Created by 이재은 on 26/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class CarouselView: UICollectionView {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // 셀의 비율을 변경하는 함수
  func transformScale(cell: UICollectionViewCell) {
    let cellCenter = self.convert(cell.center, to: nil)
    let screenCenterX = UIScreen.main.bounds.width / 2
    let reductionRatio: CGFloat = -0.0009
    let maxScale: CGFloat = 1
    let cellCenterDisX: CGFloat = abs(screenCenterX - cellCenter.x)
    let newScale = reductionRatio * cellCenterDisX + maxScale
    cell.transform = CGAffineTransform(scaleX: newScale, y: newScale)
  }
  
  // 레이아웃을 즉시 업데이트하는 함수
  func updateLayout() {
    self.layoutIfNeeded()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let cells = self.visibleCells
    
    for cell in cells {
      transformScale(cell: cell)
    }
  }
}
