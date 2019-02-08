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
      valueGraphView.delegate = self
    }
  }
  
  /// 비율 그래프.
  private var ratioGraphView: RatioGraphView! {
    didSet {
      ratioGraphView.delegate = self
    }
  }
  
  // MARK: Property
  
  /// 7일간의 미세먼지 농도 값 모음.
  var dustIntakes: [CGFloat] = [17, 27, 68, 74, 127, 67, 183]
  
  /// 전체에 대한 마지막 값의 비율
  private var dustLastValueRatio: CGFloat {
    let sum = dustIntakes.reduce(0, +)
    let last = dustIntakes.last ?? 0.0
    return last / sum
  }
  
  /// 선택된 날짜.
  private var selectedDate: Date = Date()
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "미세먼지 분석".localized
    createSubviews()
    setConstraintsToSubviews()
    registerLocationObserver()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // 값 새로 받아오고 서브뷰 초기화
    initializeValueGraphView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    initializeRatioGraphView()
  }
  
  deinit {
    unregisterLocationObserver()
  }
  
  private func requestDustTodayInfo() {
    DustInfoService()
      .fetchInfo(from: Date.before(days: 2),
                 to: Date.before(days: 1)) { fineDustPerDate, ultrafineDustPerDate, error in
                  if let error = error {
                    print(error.localizedDescription)
                    return
                  }
                  print(fineDustPerDate)
    }
  }
}

// MARK: - LocationObserver 구현

extension StatisticsViewController: LocationObserver {
  func handleIfSuccess(_ notification: Notification) {
    requestDustTodayInfo()
  }
  
  func handleIfFail(_ notification: Notification) {
    UIAlertController
      .alert(title: "", message: notification.locationTaskError?.localizedDescription)
      .action(title: "확인")
      .present(to: self)
  }
  
  func handleIfAuthorizationDenied(_ notification: Notification) {
    print("authorization denied")
  }
}

// MARK: - ValueGraphView Delegate 구현

extension StatisticsViewController: ValueGraphViewDelegate {

  var intakeAmounts: [CGFloat] {
    return dustIntakes
  }
}

// MARK: - RatioGraphView Delegate 구현

extension StatisticsViewController: RatioGraphViewDelegate {
  
  var intakeRatio: CGFloat {
    return dustLastValueRatio
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
