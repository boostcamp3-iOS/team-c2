//
//  PagingPerCellFlowLayout.swift
//  FineDust
//
//  Created by 이재은 on 26/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class PagingPerCellFlowLayout: UICollectionViewFlowLayout {
  
  /// 스크롤이 멈출 지점을 반환하는 함수
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                    withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
    if let collectionViewBounds = self.collectionView?.bounds {
      let halfWidthOfVC = collectionViewBounds.size.width * 0.5
      let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidthOfVC
      if let attributesForVisibleCells = self.layoutAttributesForElements(
        in: collectionViewBounds
        ) { var nextAttribute : UICollectionViewLayoutAttributes?
        for attributes in attributesForVisibleCells {
          let nextAttr = nextAttribute
          if nextAttr != nil {
            let aValue = attributes.center.x - proposedContentOffsetCenterX
            let bValue = nextAttr?.center.x ?? 0.0 - proposedContentOffsetCenterX
            if abs(aValue) < abs(bValue) {
              nextAttribute = attributes
              continue
            }
          }
        }
        if nextAttribute != nil {
          return CGPoint(
            x: nextAttribute?.center.x ?? 0.0 - halfWidthOfVC,
            y: proposedContentOffset.y)
        }
      }
    }
    return CGPoint.zero
  }
}
