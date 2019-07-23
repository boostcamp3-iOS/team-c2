//
//  StatisticsViewModel.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import RxRelay
import RxSwift

protocol StatisticsViewModelInputs {
  
  func selectSegmentedControl(at index: Int)
}

protocol StatisticsViewModelOutputs {
  
  var selectedSegmentedControlIndex: Observable<Int> { get }
}

final class StatisticsViewModel {
  
  private let selectedSegmentedControlIndexRelay = BehaviorRelay(value: 0)
  
  private let intakeService: IntakeServiceType
  
  init(intakeService: IntakeServiceType = IntakeService()) {
    self.intakeService = intakeService
  }
}

extension StatisticsViewModel: StatisticsViewModelInputs {
  
  func selectSegmentedControl(at index: Int) {
    selectedSegmentedControlIndexRelay.accept(index)
  }
}

extension StatisticsViewModel: StatisticsViewModelOutputs {
  
  var selectedSegmentedControlIndex: Observable<Int> {
    return selectedSegmentedControlIndexRelay.asObservable()
  }
}

extension StatisticsViewModel {

  var inputs: StatisticsViewModelInputs { return self }
  
  var outputs: StatisticsViewModelOutputs { return self }
}

