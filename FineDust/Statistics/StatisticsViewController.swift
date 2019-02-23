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
  private enum Layer {
    
    /// 경계선 라운드 반지름.
    static let cornerRadius: CGFloat = 8.0
    
    /// 경계선 두께.
    static let borderWidth: CGFloat = 1.0
  }
  
  // MARK: IBOutlets
  
  /// 서브뷰 포함하는 스크롤 뷰.
  @IBOutlet private weak var scrollView: UIScrollView!
  
  /// 미세먼지 / 초미세먼지 토글하는 세그먼티드 컨트롤.
  @IBOutlet private weak var segmentedControl: UISegmentedControl!
  
  /// 값 그래프 배경 뷰.
  @IBOutlet private weak var valueGraphBackgroundView: UIView!
  
  /// 비율 그래프 배경 뷰.
  @IBOutlet private weak var ratioGraphBackgroundView: UIView!
  
  // MARK: View
  
  /// 값 그래프.
  private var valueGraphView: ValueGraphView!
  
  /// 비율 그래프.
  private var ratioGraphView: RatioGraphView!
  
  // MARK: Dependency
  
  var intakeService: IntakeServiceType?
  
  var coreDataService: CoreDataServiceType?
  
  // MARK: Stored Property
  
  /// 화면이 표시가 되었는가.
  private var isPresented: Bool = false
  
  /// 흡입량 데이터.
  private var intakeData: IntakeData = IntakeData()
  
  // MARK: Computed Property
  
  /// 미세먼지의 전체에 대한 마지막 값의 비율
  private var fineDustLastValueRatio: Double {
    let reduced = intakeData.weekFineDust.reduce(0, +)
    let sum = reduced == 0 ? 1 : reduced
    let last = intakeData.weekFineDust.last ?? 1
    return Double(last) / Double(sum)
  }
  
  /// 초미세먼지의 전체에 대한 마지막 값의 비율
  private var ultrafineDustLastValueRatio: Double {
    let reduced = intakeData.weekUltrafineDust.reduce(0, +)
    let sum = reduced == 0 ? 1 : reduced
    let last = intakeData.weekUltrafineDust.last ?? 1
    return Double(last) / Double(sum)
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    injectDependency(IntakeService(), CoreDataService())
    setupSubviews()
    createGraphViews()
    setGraphViewConstraintsToSubviews()
    registerLocationObserver()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    initializeValueGraphView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    initializeRatioGraphView()
    // 한번 보여진 이후로는 비즈니스 로직을 수행하지 않음
    if !isPresented {
      isPresented.toggle()
      requestIntake(completion: requestIntakeHandler)
    }
  }
  
  deinit {
    unregisterLocationObserver()
  }
  
  /// 세그먼티드 컨트롤 값이 바뀌었을 때 호출됨.
  @objc private func segmentedControlValueDidChange(_ sender: UISegmentedControl) {
    initializeGraphViews()
  }
}

// MARK: - IntakeRequestable 구현

extension StatisticsViewController: IntakeRequestable {
  
  var requestIntakeHandler: (IntakeData?, Error?) -> Void {
    return { [weak self] intakeData, error in
      guard let self = self else { return }
      if let error = error as? ServiceErrorType {
        error.presentToast()
        self.presentLastSavedData()
        return
      }
      guard let intakeData = intakeData else { return }
      self.setIntakes(intakeData)
      DispatchQueue.main.async {
        self.initializeGraphViews()
      }
    }
  }
}

// MARK: - LocationObserver 구현

extension StatisticsViewController: LocationObserver {
  
  func handleIfSuccess(_ notification: Notification) {
    // 탭바 컨트롤러의 현재 뷰컨트롤러가 해당 뷰컨트롤러일 때만 노티피케이션 성공 핸들러 로직을 수행함
    let tabBarControllerCurrentViewController
      = (tabBarController?.selectedViewController as? UINavigationController)?
        .visibleViewController
    if tabBarControllerCurrentViewController == self {
      requestIntake(completion: requestIntakeHandler)
    }
  }
}

// MARK: - ValueGraphView Delegate 구현

extension StatisticsViewController: ValueGraphViewDataSource {
  
  var intakes: [Int] {
    return segmentedControl.selectedSegmentIndex == 0
      ? intakeData.weekFineDust
      : intakeData.weekUltrafineDust
  }
}

// MARK: - RatioGraphView Delegate 구현

extension StatisticsViewController: RatioGraphViewDataSource {
  
  var intakeRatio: Double {
    return segmentedControl.selectedSegmentIndex == 0
      ? fineDustLastValueRatio
      : ultrafineDustLastValueRatio
  }
  
  var totalIntake: Int {
    let reducedFineDust = intakeData.weekFineDust.reduce(0, +)
    let reducedUltrafineDust = intakeData.weekUltrafineDust.reduce(0, +)
    return segmentedControl.selectedSegmentIndex == 0 ? reducedFineDust : reducedUltrafineDust
  }
  
  var todayIntake: Int {
    return segmentedControl.selectedSegmentIndex == 0
      ? intakeData.todayFineDust
      : intakeData.todayUltrafineDust
  }
}

// MARK: - Private Extension (Data)

private extension StatisticsViewController {
  
  /// 마지막으로 저장된 데이터 보여주기.
  private func presentLastSavedData() {
    coreDataService?.requestLastSavedData { lastSavedData, error in
      if error != nil {
        print("마지막으로 저장된 데이터도 표시되지 않음")
        return
      }
      if let lastSavedData  = lastSavedData {
        let intakeData = IntakeData(weekFineDust: lastSavedData.weekFineDust,
                                    weekUltrafineDust: lastSavedData.weekUltrafineDust,
                                    todayFineDust: lastSavedData.todayFineDust,
                                    todayUltrafineDust: lastSavedData.todayUltrafineDust)
        self.intakeData.reset(intakeData)
        self.setIntakes(intakeData)
        DispatchQueue.main.async {
          self.initializeGraphViews()
        }
      }
    }
  }
  
  /// 흡입량 관련 프로퍼티 설정.
  func setIntakes(_ intakeData: IntakeData) {
    self.intakeData.reset(intakeData)
  }
}

// MARK: - Private Extension (View)

private extension StatisticsViewController {
  
  /// 서브뷰 초기 설정.
  func setupSubviews() {
    scrollView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
    segmentedControl.setTitle(L10n.fineDust, forSegmentAt: 0)
    segmentedControl.setTitle(L10n.ultrafineDust, forSegmentAt: 1)
    segmentedControl.addTarget(self,
                               action: #selector(segmentedControlValueDidChange(_:)),
                               for: .valueChanged)
    valueGraphBackgroundView.layer.setBorder(color: Asset.graphBorder.color,
                                             width: Layer.borderWidth,
                                             radius: Layer.cornerRadius)
    ratioGraphBackgroundView.layer.setBorder(color: Asset.graphBorder.color,
                                             width: Layer.borderWidth,
                                             radius: Layer.cornerRadius)
  }
  
  /// 서브뷰 생성하여 프로퍼티에 할당.
  func createGraphViews() {
    valueGraphView = instantiateGraphView(ValueGraphView.self)
    ratioGraphView = instantiateGraphView(RatioGraphView.self)
    valueGraphView.dataSource = self
    ratioGraphView.dataSource = self
    valueGraphBackgroundView.addSubview(valueGraphView)
    ratioGraphBackgroundView.addSubview(ratioGraphView)
  }
  
  /// 서브뷰에 오토레이아웃 설정.
  func setGraphViewConstraintsToSubviews() {
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
  
  /// 모든 서브뷰 초기화.
  func initializeGraphViews() {
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
  
  /// GraphDrawable 프로토콜을 준수하는 그래프 뷰 instantiate.
  func instantiateGraphView<T>(_ view: T.Type) -> T where T: GraphDrawable, T: UIView {
    let graphView = UIView.instantiate(fromXib: T.classNameToString) as? T ?? T()
    graphView.translatesAutoresizingMaskIntoConstraints = false
    return graphView
  }
}
