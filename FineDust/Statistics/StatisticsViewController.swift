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
  
  /// 화면이 표시가 되었는가.
  private var isPresented: Bool = false
  
  /// 7일간의 미세먼지 농도 값 모음.
  private var dustIntakes: [CGFloat] = [100, 100, 100, 100, 100, 100, 100]
  
  /// 흡입량 서비스 프로퍼티.
  private let intakeService = IntakeService()
  
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
  
  /// 미세먼지 흡입량 요청.
  private func requestIntake() {
    requestWeekDustInfo { [weak self] fineDusts, ultrafineDusts, error in
      if let error = error as? ServiceErrorType {
        error.alert.present(to: self)
        return
      }
      guard let self = self else { return }
      self.requestTodayDustInfo { [weak self] fineDust, ultrafineDust, error in
        if let error = error as? ServiceErrorType {
          error.alert.present(to: self)
          return
        }
        guard let self = self else { return }
        guard let fineDusts = fineDusts else { return }
        guard let fineDust = fineDust else { return }
        // 조작
        let weekIntakes = [fineDusts, [fineDust]]
          .flatMap { $0 }
          .map { CGFloat($0) }
        print(weekIntakes)
        self.dustIntakes = weekIntakes
        DispatchQueue.main.async {
          self.initializeValueGraphView()
          self.initializeRatioGraphView()
        }
      }
    }
  }
  
  /// 오늘 제외한 일주일간 정보 요청.
  private func requestWeekDustInfo(completion: @escaping ([Int]?, [Int]?, Error?) -> Void) {
    intakeService
      .requestIntakesInWeek(since: .before(days: 6)) { fineDusts, ultrafineDusts, error in
        if let error = error {
          completion(nil, nil, error)
          return
        }
        completion(fineDusts, ultrafineDusts, nil)
    }
  }
  
  /// 오늘의 정보 요청.
  private func requestTodayDustInfo(completion: @escaping (Int?, Int?, Error?) -> Void) {
    intakeService
      .requestTodayIntake { fineDust, ultrafineDust, error in
        if let error = error {
          completion(nil, nil, error)
          return
        }
        completion(fineDust, ultrafineDust, nil)
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
