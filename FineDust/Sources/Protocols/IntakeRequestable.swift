//
//  IntakeRequestable.swift
//  FineDust
//
//  Created by Presto on 22/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

protocol IntakeRequestable: class {

  func requestIntake(completion: @escaping (IntakeData?, Error?) -> Void)
  
  var requestIntakeHandler: (IntakeData?, Error?) -> Void { get }
}

// MARK: - IntakeRequestable 프로토콜 초기 구현

extension IntakeRequestable where Self: UIViewController {
  
  func injectDependency(_ intakeService: IntakeServiceType,
                        _ coreDataService: CoreDataServiceType) {
    self.intakeService = intakeService
    self.coreDataService = coreDataService
  }
  
  func requestIntake(completion: @escaping (IntakeData?, Error?) -> Void) {
    intakeService?.requestIntakesInWeek { [weak self] fineDusts, ultrafineDusts, error in
      if let error = error {
        completion(nil, error)
        return
      }
      guard let self = self else { return }
      self.intakeService?.requestTodayIntake { [weak self] fineDust, ultrafineDust, error in
        if let error = error {
          completion(nil, error)
          return
        }
        guard let self = self,
          let fineDusts = fineDusts,
          let ultrafineDusts = ultrafineDusts,
          let fineDust = fineDust,
          let ultrafineDust = ultrafineDust
          else { return }
        let fineDustWeekIntakes = [fineDusts, [fineDust]].flatMap { $0 }
        let ultrafineDustWeekIntakes = [ultrafineDusts, [ultrafineDust]].flatMap { $0 }
        self.coreDataService?
          .saveLastWeekIntake(fineDustWeekIntakes, ultrafineDustWeekIntakes) { error in
            if error != nil {
              errorLog("마지막으로 요청한 일주일 먼지 농도가 저장되지 않음")
            } else {
              debugLog("마지막으로 요청한 일주일 먼지 농도가 성공적으로 저장됨")
            }
        }
        debugLog(fineDustWeekIntakes)
        debugLog(ultrafineDustWeekIntakes)
        let intakeData = IntakeData(weekFineDust: fineDustWeekIntakes,
                                    weekUltrafineDust: ultrafineDustWeekIntakes,
                                    todayFineDust: fineDust,
                                    todayUltrafineDust: ultrafineDust)
        completion(intakeData, nil)
      }
    }
  }
}
