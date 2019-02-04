//
//  StatisticsViewController.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 통계 관련 뷰 컨트롤러.
final class StatisticsViewController: UIViewController {
  
  /// CALayer 관련 상수 정의.
  enum Layer {
    
    /// 경계선 라운드 반지름.
    static let cornerRadius: CGFloat = 8.0
    
    /// 경계선 두께.
    static let borderWidth: CGFloat = 1.0
  }
  
  // MARK: IBOutlets
  
  /// 값 그래프 배경 뷰.
  @IBOutlet private weak var valueGraphBackgroundView: UIView! {
    didSet {
      valueGraphBackgroundView.layer.setBorder(
        color: Asset.graphBorder.color,
        width: Layer.borderWidth,
        radius: Layer.cornerRadius
      )
    }
  }
  
  /// 비율 그래프 배경 뷰.
  @IBOutlet private weak var ratioGraphBackgroundView: UIView! {
    didSet {
      ratioGraphBackgroundView.layer.setBorder(
        color: Asset.graphBorder.color,
        width: Layer.borderWidth,
        radius: Layer.cornerRadius
      )
    }
  }
  
  // MARK: View
  
  /// 값 그래프.
  private var valueGraphView: ValueGraphView! {
    didSet {
      valueGraphView.dataSource = self
      valueGraphView.delegate = self
    }
  }
  
  /// 비율 그래프.
  private var ratioGraphView: RatioGraphView! {
    didSet {
      ratioGraphView.dataSource = self
    }
  }
  
  // MARK: Property
  
  /// 7일간의 미세먼지 농도 값 모음.
  var fineDustValues: [CGFloat] = [18, 67, 176, 135, 96, 79, 51]
  
  /// 전체에 대한 마지막 값의 비율
  private var fineDustLastValueRatio: CGFloat {
    let sum = fineDustValues.reduce(0, +)
    let last = fineDustValues.last ?? 0.0
    return last / sum
  }
  
  /// 선택된 날짜.
  private var selectedDate: Date = Date()
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "미세먼지 분석".localized
    createSubviews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // 값 새로 받아오고 서브뷰 초기화
    var array = [CGFloat]()
    for _ in 0..<7 {
      array.append(CGFloat.random(in: 10...200))
    }
    fineDustValues = array
    setConstraintsToSubviews()
    initializeValueGraphView()
    initializeRatioGraphView()
  }
  
  // MARK: Method
  
  /// 미세먼지 농도 조회 통신이 완료된 노티피케이션을 받았을 경우 동작 정의.
  @objc private func didFetchFineDustConcentration(_ notification: Notification) {
    if let response = notification.userInfo?["data"] as? DustResponse {
      print(response)
    }
  }
}

// MARK: - ValueGraphView Data Source 구현

extension StatisticsViewController: ValueGraphViewDataSource {
  var referenceDate: Date {
    return selectedDate
  }
  var intakeAmounts: [CGFloat] {
    return fineDustValues
  }
}

// MARK: - ValueGraphView Delegate 구현

extension StatisticsViewController: ValueGraphViewDelegate {
  func valueGraphView(
    _ valueGraphView: ValueGraphView,
    didTapDoneButton button: UIBarButtonItem,
    in datePicker: UIDatePicker
  ) {
    selectedDate = datePicker.date
  }
}

// MARK: - RatioGraphView Data Source 구현

extension StatisticsViewController: RatioGraphViewDataSource {
  /// 흡입량 비율
  var intakeRatio: CGFloat {
    return fineDustLastValueRatio
  }
}

// MARK: - Private Extension

private extension StatisticsViewController {
  
  /// 서브뷰 생성하여 프로퍼티에 할당.
  func createSubviews() {
    valueGraphView
      = UIView.instantiate(fromXib: ValueGraphView.classNameToString) as? ValueGraphView
    ratioGraphView
      = UIView.instantiate(fromXib: RatioGraphView.classNameToString) as? RatioGraphView
    valueGraphView.translatesAutoresizingMaskIntoConstraints = false
    ratioGraphView.translatesAutoresizingMaskIntoConstraints = false
    valueGraphBackgroundView.addSubview(valueGraphView)
    ratioGraphBackgroundView.addSubview(ratioGraphView)
  }
  
  /// 서브뷰에 오토레이아웃 설정.
  func setConstraintsToSubviews() {
    NSLayoutConstraint.activate([
      valueGraphView.anchor.top.equal(to: valueGraphBackgroundView.anchor.top),
      valueGraphView.anchor.leading.equal(to: valueGraphBackgroundView.anchor.leading),
      valueGraphView.anchor.trailing.equal(to: valueGraphBackgroundView.anchor.trailing),
      valueGraphView.anchor.bottom.equal(to: valueGraphBackgroundView.anchor.bottom),
      ratioGraphView.anchor.top.equal(to: ratioGraphBackgroundView.anchor.top),
      ratioGraphView.anchor.leading.equal(to: ratioGraphBackgroundView.anchor.leading),
      ratioGraphView.anchor.trailing.equal(to: ratioGraphBackgroundView.anchor.trailing),
      ratioGraphView.anchor.bottom.equal(to: ratioGraphBackgroundView.anchor.bottom)
      ])
  }
}

// MARK: - Value Graph Private Extension

private extension StatisticsViewController {
  
  /// 값 그래프 뷰 초기화.
  func initializeValueGraphView() {
    valueGraphView.setup()
  }
  
  /// 비율 그래프 뷰 초기화.
  func initializeRatioGraphView() {
    ratioGraphView.setup()
  }
}
