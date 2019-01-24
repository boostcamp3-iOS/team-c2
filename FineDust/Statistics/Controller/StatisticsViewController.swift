//
//  StatisticsViewController.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 통계 관련 뷰 컨트롤러
final class StatisticsViewController: UIViewController {
  
  /// CALayer 관련 상수 정의
  enum Layer {
    
    static let cornerRadius: CGFloat = 8.0
    
    static let borderWidth: CGFloat = 1.0
  }
  
  // MARK: IBOutlet
  
  /// 값 그래프 배경 뷰
  @IBOutlet private weak var valueGraphBackgroundView: UIView! {
    didSet {
      valueGraphBackgroundView.layer.setBorder(
        color: UIColor(red: 239, green: 239, blue: 244),
        width: Layer.borderWidth,
        radius: Layer.cornerRadius
      )
    }
  }
  
  /// 비율 그래프 배경 뷰
  @IBOutlet private weak var ratioGraphBackgroundView: UIView! {
    didSet {
      ratioGraphBackgroundView.layer.setBorder(
        color: UIColor(red: 239, green: 239, blue: 244),
        width: Layer.borderWidth,
        radius: Layer.cornerRadius
      )
    }
  }
  
  // MARK: View
  
  /// 값 그래프
  private var valueGraphView: ValueGraphView! {
    didSet {
      valueGraphView.delegate = self
    }
  }
  
  /// 비율 그래프
  private var ratioGraphView: RatioGraphView! {
    didSet {
      ratioGraphView.delegate = self
    }
  }
  
  // MARK: Property
  
  /// 7일간의 미세먼지 농도 값 모음
  var fineDustValues: [CGFloat] = [18, 67, 176, 135, 96, 79, 51]
  
  /// 전체에 대한 마지막 값의 비율
  private var fineDustLastValueRatio: CGFloat {
    let sum = fineDustValues.reduce(0, +)
    let max = fineDustValues.max() ?? 0.0
    return max / sum
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "미세먼지 분석"
    createSubviews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setConstraintsToSubviews()
    initializeValueGraphView()
    initializeRatioGraphView()
  }
}

// MARK: - ValueGraphView Delegate 구현

extension StatisticsViewController: ValueGraphViewDelegate {
  var day: Date {
    return Date()
  }
  
  var values: [CGFloat] {
    //return [18, 67, 176, 135, 96, 79, 51]
    return fineDustValues
  }
  
  func valueGraphView(_ view: ValueGraphView, didTapDateButton button: UIButton) {
    
    print(day.isToday)
  }
}

// MARK: - RatioGraphView Delegate 구현

extension StatisticsViewController: RatioGraphViewDelegate {
  
  var ratio: CGFloat {
    //return 0.64
    return fineDustLastValueRatio
  }
}

// MARK: - Private Extension

private extension StatisticsViewController {
  /// 서브뷰 생성하여 프로퍼티에 할당
  func createSubviews() {
    valueGraphView = UIView.create(fromXib: ValueGraphView.classNameToString) as? ValueGraphView
    ratioGraphView = UIView.create(fromXib: RatioGraphView.classNameToString) as? RatioGraphView
    valueGraphView.translatesAutoresizingMaskIntoConstraints = false
    ratioGraphView.translatesAutoresizingMaskIntoConstraints = false
    valueGraphBackgroundView.addSubview(valueGraphView)
    ratioGraphBackgroundView.addSubview(ratioGraphView)
  }
  
  /// 서브뷰에 오토레이아웃 설정
  func setConstraintsToSubviews() {
    NSLayoutConstraint.activate([
      valueGraphView.top.equal(to: valueGraphBackgroundView.top),
      valueGraphView.leading.equal(to: valueGraphBackgroundView.leading),
      valueGraphView.trailing.equal(to: valueGraphBackgroundView.trailing),
      valueGraphView.bottom.equal(to: valueGraphBackgroundView.bottom),
      ratioGraphView.top.equal(to: ratioGraphBackgroundView.top),
      ratioGraphView.leading.equal(to: ratioGraphBackgroundView.leading),
      ratioGraphView.trailing.equal(to: ratioGraphBackgroundView.trailing),
      ratioGraphView.bottom.equal(to: ratioGraphBackgroundView.bottom)
      ])
  }
}

// MARK: - Value Graph Private Extension

private extension StatisticsViewController {
  func initializeValueGraphView() {
    valueGraphView.setup()
  }
  
  func initializeRatioGraphView() {
    ratioGraphView.setup()
  }
}
