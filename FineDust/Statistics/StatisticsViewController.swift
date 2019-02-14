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
  
  /// 서브뷰 포함하는 스크롤 뷰.
  @IBOutlet private weak var scrollView: UIScrollView! {
    didSet {
      scrollView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
    }
  }
  
  /// 미세먼지 / 초미세먼지 토글하는 세그먼티드 컨트롤.
  @IBOutlet private weak var segmentedControl: UISegmentedControl! {
    didSet {
      segmentedControl.addTarget(self,
                                 action: #selector(segmentedControlValueDidChange(_:)),
                                 for: .valueChanged)
    }
  }
  
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
    }
  }
  
  /// 비율 그래프.
  private var ratioGraphView: RatioGraphView! {
    didSet {
      ratioGraphView.dataSource = self
    }
  }
  
  // MARK: Property
  
  /// 화면이 표시가 되었는가.
  private var isPresented: Bool = false
  
  /// 7일간의 미세먼지 농도 값 모음.
  private var fineDustTotalIntakes: [CGFloat]
    = (UserDefaults.standard.array(forKey: "fineDustIntakes") as? [Int])?.map { CGFloat($0) }
      ?? [100, 100, 100, 100, 100, 100, 100]
  
  /// 7일간의 초미세먼지 농도 값 모음.
  private var ultrafineDustTotalIntakes: [CGFloat]
    = (UserDefaults.standard.array(forKey: "ultrafineDustIntakes") as? [Int])?.map { CGFloat($0) }
      ?? [100, 100, 100, 100, 100, 100, 100]
  
  /// 흡입량 서비스 프로퍼티.
  private let intakeService = IntakeService()
  
  /// 미세먼지의 전체에 대한 마지막 값의 비율
  private var fineDustLastValueRatio: CGFloat {
    let reduced = fineDustTotalIntakes.reduce(0, +)
    let sum = reduced == 0 ? 0.1 : reduced
    let last = fineDustTotalIntakes.last ?? 0.1
    return last / sum
  }
  
  /// 초미세먼지의 전체에 대한 마지막 값의 비율
  private var ultrafineDustLastValueRatio: CGFloat {
    let reduced = ultrafineDustTotalIntakes.reduce(0, +)
    let sum = reduced == 0 ? 0.1 : reduced
    let last = ultrafineDustTotalIntakes.last ?? 0.1
    return last / sum
  }
  
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
    initializeValueGraphView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    initializeRatioGraphView()
    if !isPresented {
      isPresented.toggle()
      requestIntake()
    }
  }
  
  deinit {
    unregisterLocationObserver()
  }
  
  @objc private func segmentedControlValueDidChange(_ sender: UISegmentedControl) {
    initializeSubviews()
  }
  
  /// 미세먼지 흡입량 요청.
  private func requestIntake() {
    intakeService.requestIntakesInWeek { [weak self] fineDusts, ultrafineDusts, error in
      if let error = error as? ServiceErrorType {
        error.presentToast()
        return
      }
      guard let self = self else { return }
      self.intakeService.requestTodayIntake { [weak self] fineDust, ultrafineDust, error in
        if let error = error as? ServiceErrorType {
          error.presentToast()
          return
        }
        guard let self = self,
          let fineDusts = fineDusts,
          let ultrafineDusts = ultrafineDusts,
          let fineDust = fineDust,
          let ultrafineDust = ultrafineDust
        else { return }
        let fineDustWeekIntakes = [fineDusts, [fineDust]]
          .flatMap { $0 }
          .map { CGFloat($0) }
        let ultrafineDustWeekIntakes = [ultrafineDusts, [ultrafineDust]]
          .flatMap { $0 }
          .map { CGFloat($0) }
        UserDefaults.standard
          .set([fineDusts, [fineDust]].flatMap { $0 }, forKey: "fineDustIntakes")
        UserDefaults.standard
          .set([ultrafineDusts, [ultrafineDust]].flatMap { $0 }, forKey: "ultrafineDustIntakes")
        self.fineDustTotalIntakes = fineDustWeekIntakes
        self.ultrafineDustTotalIntakes = ultrafineDustWeekIntakes
        print(fineDustWeekIntakes, ultrafineDustWeekIntakes)
        DispatchQueue.main.async {
          self.initializeSubviews()
        }
      }
    }
  }
}

// MARK: - LocationObserver 구현

extension StatisticsViewController: LocationObserver {
  func handleIfSuccess(_ notification: Notification) {
    requestIntake()
  }
}

// MARK: - ValueGraphView Delegate 구현

extension StatisticsViewController: ValueGraphViewDataSource {
  
  var intakes: [CGFloat] {
    if segmentedControl.selectedSegmentIndex == 0 {
      return fineDustTotalIntakes
    }
    return ultrafineDustTotalIntakes
  }
}

// MARK: - RatioGraphView Delegate 구현

extension StatisticsViewController: RatioGraphViewDataSource {
  
  var intakeRatio: CGFloat {
    if segmentedControl.selectedSegmentIndex == 0 {
      return fineDustLastValueRatio
    }
    return ultrafineDustLastValueRatio
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
  
  /// 모든 서브뷰 초기화.
  func initializeSubviews() {
    initializeValueGraphView()
    initializeRatioGraphView()
  }
  
  /// 값 그래프 뷰 초기화.
  func initializeValueGraphView() {
    valueGraphView.setup()
  }
  
  /// 비율 그래프 뷰 초기화.
  func initializeRatioGraphView() {
    ratioGraphView.setup()
  }
}
