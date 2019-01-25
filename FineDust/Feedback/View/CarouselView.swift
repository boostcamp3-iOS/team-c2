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
    let cellCenter = self.convert(cell.center, to: nil) // 셀의 중심 좌표
    let screenCenterX = UIScreen.main.bounds.width / 2  // 화면의 중심 좌표
    let reductionRatio: CGFloat = -0.0009               // 축소율
    let maxScale: CGFloat = 1
    let cellCenterDisX: CGFloat = abs(screenCenterX - cellCenter.x) // 중심까지의 거리
    let newScale = reductionRatio * cellCenterDisX + maxScale       // 새로운 크기
    cell.transform = CGAffineTransform(scaleX: newScale, y: newScale)
  }
  
  // 레이아웃을 즉시 업데이트하는 함수, 화면에 다시 돌아왔을 때 첫 셀이 맨 앞으로
  func updateLayout() {
    self.layoutIfNeeded()
    self.scrollToItem(at: IndexPath(row: 0, section: 0),
                      at: .centeredHorizontally, animated: false)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let cells = self.visibleCells
    
    for cell in cells {
      transformScale(cell: cell)
    }
  }
}
