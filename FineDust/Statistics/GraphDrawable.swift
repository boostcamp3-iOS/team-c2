//
//  GraphDrawable.swift
//  FineDust
//
//  Created by Presto on 20/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 그래프를 그리는 프로토콜.
protocol GraphDrawable: class {
  
  /// 뷰 리로드.
  func reloadGraphView()
  
  /// 서브뷰 초기화.
  func deinitializeSubviews()
  
  /// 그래프 그리기.
  func drawGraph()
  
  /// 레이블 설정하기
  func setLabels()
}

// MARK: - GraphDrawable 프로토콜 초기 구현

extension GraphDrawable {
  
  func reloadGraphView() {
    deinitializeSubviews()
    drawGraph()
    setLabels()
  }
  
  func deinitializeSubviews() { }
  
  func drawGraph() { }
  
  func setLabels() { }
}
