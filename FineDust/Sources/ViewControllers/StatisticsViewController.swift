//
//  StatisticsViewController.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class StatisticsViewController: UIViewController {
  
  private enum Layer {
    
    static let cornerRadius: CGFloat = 8.0
    
    static let borderWidth: CGFloat = 1.0
  }
  
  private let disposeBag = DisposeBag()
  
  private let viewModel = StatisticsViewModel()
  
  @IBOutlet private weak var scrollView: UIScrollView!
  
  @IBOutlet private weak var segmentedControl: UISegmentedControl!
  
  @IBOutlet private weak var stickGraphBackgroundView: UIView!
  
  @IBOutlet private weak var ratioGraphBackgroundView: UIView!
  
  private let stickGraphView = UIView.instantiate(fromType: StickGraphView.self)
  
  private let ratioGraphView = UIView.instantiate(fromType: RatioGraphView.self)
  
  private let intakeService = IntakeService()
  
  private let persistenceService = PersistenceService()
  
  private var isPresented: Bool = false
  
  private var intakeData = IntakeData()
  
  /// 미세먼지의 전체에 대한 오늘의 비율.
  private var todayFineDustRatio: Double {
    let reduced = intakeData.weekFineDust.reduce(0, +)
    let sum = reduced == 0 ? 1 : reduced
    let last = intakeData.weekFineDust.last ?? 1
    return Double(last) / Double(sum)
  }
  
  /// 초미세먼지의 전체에 대한 오늘의 비율.
  private var todayUltrafineDustRatio: Double {
    let reduced = intakeData.weekUltrafineDust.reduce(0, +)
    let sum = reduced == 0 ? 1 : reduced
    let last = intakeData.weekUltrafineDust.last ?? 1
    return Double(last) / Double(sum)
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
    createGraphViews()
    registerLocationObserver()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    initializeGraphViews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // 한번 보여진 이후로는 비즈니스 로직을 수행하지 않음
    if !isPresented {
      isPresented.toggle()
      requestIntake(completion: requestIntakeHandler)
    }
  }
  
  deinit {
    unregisterLocationObserver()
  }
  
  func bindViewModel() {
    segmentedControl.rx.selectedSegmentIndex.asDriver()
      .drive(onNext: { [weak self] index in
        self?.viewModel.selectSegmentedControl(at: index)
      })
      .disposed(by: disposeBag)
    
    viewModel.selectedSegmentedControlIndex.asDriver(onErrorJustReturn: 0)
      .distinctUntilChanged()
      .drive(onNext: { [weak self] index in
        self?.initializeGraphViews()
      })
      .disposed(by: disposeBag)
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
      self.intakeData.reset(to: intakeData)
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

extension StatisticsViewController: StickGraphViewDataSource {
  
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
      ? todayFineDustRatio
      : todayUltrafineDustRatio
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
        errorLog("마지막으로 저장된 데이터도 표시되지 않음")
        return
      }
      if let lastSavedData  = lastSavedData {
        let intakeData = IntakeData(weekFineDust: lastSavedData.weekFineDust,
                                    weekUltrafineDust: lastSavedData.weekUltraFineDust,
                                    todayFineDust: lastSavedData.todayFineDust,
                                    todayUltrafineDust: lastSavedData.todayUltraFineDust)
        self.intakeData.reset(to: intakeData)
        DispatchQueue.main.async {
          self.initializeGraphViews()
        }
      }
    }
  }
}

// MARK: - Private Extension (View)

private extension StatisticsViewController {
  
  func setupSubviews() {
    scrollView.contentInset = .init(top: 8, left: 0, bottom: 16, right: 0)
    stickGraphBackgroundView.layer.applyBorder(color: Asset.graphBorder.color,
                                               width: Layer.borderWidth,
                                               radius: Layer.cornerRadius)
    ratioGraphBackgroundView.layer.applyBorder(color: Asset.graphBorder.color,
                                               width: Layer.borderWidth,
                                               radius: Layer.cornerRadius)
  }
  
  /// 서브뷰 생성하여 프로퍼티에 할당.
  func createGraphViews() {
    stickGraphView.dataSource = self
    ratioGraphView.dataSource = self
    stickGraphBackgroundView.addSubview(stickGraphBackgroundView) { $0.edges.equalToSuperview() }
    ratioGraphBackgroundView.addSubview(ratioGraphBackgroundView) { $0.edges.equalToSuperview() }
  }
  
  /// 모든 그래프 뷰 초기화.
  func initializeGraphViews() {
    stickGraphView.setup()
    ratioGraphView.setup()
  }
}
