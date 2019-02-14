//
//  ViewController.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet private weak var intakeFineDustLable: UILabel!
  @IBOutlet private weak var intakeUltrafineDustLabel: UILabel!
  @IBOutlet private weak var distanceLabel: UILabel!
  @IBOutlet private weak var stepCountLabel: UILabel!
  @IBOutlet private weak var timeLabel: UILabel!
  @IBOutlet private weak var locationLabel: UILabel!
  @IBOutlet private weak var gradeLabel: UILabel!
  @IBOutlet private weak var fineDustLabel: UILabel!
  
  // MARK: - Properties
  
  let healthKitService = HealthKitService(healthKit: HealthKitManager())
  let dustInfoService = DustInfoService(dustManager: DustInfoManager())
  let intakeService = IntakeService()
  
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "a hh : mm"
    return formatter
  }()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateHealthKitInfo()
    updateAPIInfo()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  deinit {
    unregisterLocationObserver()
    unregisterHealthKitAuthorizationObserver()
  }
}

// MARK: - LocationObserver

extension MainViewController: LocationObserver {
  func handleIfSuccess(_ notification: Notification) {
    updateAPIInfo()
  }
}

// MARK: - HealthKitAuthorizationObserver

extension MainViewController: HealthKitAuthorizationObserver {
  func authorizationSharingAuthorized(_ notification: Notification) {
    updateHealthKitInfo()
    updateAPIInfo()
  }
}

// MARK: - Methods

extension MainViewController {
  private func setUp() {
    navigationItem.title = "내안의먼지".localized
    registerLocationObserver()
    registerHealthKitAuthorizationObserver()
    timeLabel.text = dateFormatter.string(from: Date())
  }
  
  /// 걸음 수, 걸은 거리 값 업데이트하는 메소드.
  private func updateHealthKitInfo() {
    // 걸음 수 label에 표시
    healthKitService.requestTodayStepCount { value, error in
      if let error = error {
        DispatchQueue.main.async {
          self.stepCountLabel.text = "0 걸음"
        }
        print(error)
        return
      }
      if let value = value {
        DispatchQueue.main.async {
          self.stepCountLabel.text = "\(Int(value)) 걸음"
        }
      }
    }
    
    // 걸은 거리 label에 표시
    healthKitService.requestTodayDistance { value, error in
      if let value = value {
        if let error = error {
          DispatchQueue.main.async {
            self.distanceLabel.text = "0 km"
          }
          print(error)
          return
        }
        DispatchQueue.main.async {
          self.distanceLabel.text = String(format: "%.1f", value.kilometer) + " km"
        }
      }
    }
  }
  
  ///미세먼지량과 위치정보 같은 API정보들을 업데이트 함.
  private func updateAPIInfo() {
    // 위치에 관련된 Label들을 업데이트함.
    dustInfoService.requestRecentTimeInfo { info, error in
      if let error = error as? ServiceErrorType {
        error.alert.present(to: self)
        return
      }
      if let info = info {
        DispatchQueue.main.async {
          self.fineDustLabel.text = "\(info.fineDustValue)µg"
          self.locationLabel.text = SharedInfo.shared.address
          self.gradeLabel.text = self.setUpGradeLabel(grade: info.fineDustGrade)
        }
      }
    }
    
    // 마신 미세먼지양 Label들을 업데이트함.
    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
      if let error = error {
        DispatchQueue.main.async {
          self.intakeFineDustLable.text = "0µg"
          self.intakeUltrafineDustLabel.text = "0µg"
        }
        print(error.localizedDescription)
        return
      }
      
      if let fineDust = fineDust, let ultrafineDust = ultrafineDust {
        DispatchQueue.main.async {
          self.intakeFineDustLable.text = "\(fineDust)µg"
          self.intakeUltrafineDustLabel.text = "\(ultrafineDust)µg"
        }
      }
    }
  }
  
  func setUpGradeLabel(grade: DustGrade) -> String {
    switch grade {
    case .good:
      return "좋은 공기"
    case .normal:
      return "보통 공기"
    case .bad:
      return "나쁜 공기"
    case .veryBad:
      return "매우 나쁨"
    case .default:
      return "기타"
    }
  }
}
