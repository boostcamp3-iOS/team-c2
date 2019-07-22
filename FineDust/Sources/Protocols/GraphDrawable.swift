//
//  GraphDrawable.swift
//  FineDust
//
//  Created by Presto on 20/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

protocol GraphDrawable: class {
  
  func reloadGraphView()
  
  func deinitializeSubviews()
  
  func drawGraph()
  
  func setLabels()
}

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
