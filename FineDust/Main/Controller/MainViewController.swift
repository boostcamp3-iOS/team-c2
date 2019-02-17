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
  
  ///한번만 표시해주기 위한 프로퍼티
  private var isPresented: Bool = false
  
  private let healthKitService = HealthKitService(healthKit: HealthKitManager())
  private let dustInfoService = DustInfoService(dustManager: DustInfoManager())
  private let intakeService = IntakeService()
  
  /// 오전(후) 시 : 분 으로 나타내주는 프로퍼티.
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "a hh : mm"
    return formatter
  }()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if !isPresented {
      isPresented.toggle()
      updateHealthKitInfo()
      updateAPIInfo()
    }
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
  /// MainViewController 초기 설정 메소드.
  private func setUp() {
    registerLocationObserver()
    registerHealthKitAuthorizationObserver()
    timeLabel.text = dateFormatter.string(from: Date())
    presentOpenHealthAppAlert()
  }
  
  /// HealthKit의 걸음 수, 걸은 거리 값 업데이트하는 메소드.
  private func updateHealthKitInfo() {
    // 걸음 수 label에 표시
    healthKitService.requestTodayStepCount { value, error in
      if let error = error as? ServiceErrorType {
        error.presentToast()
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
      if let error = error as? ServiceErrorType {
        error.presentToast()
        return
      }
      if let value = value {
        DispatchQueue.main.async {
          self.distanceLabel.text = String(format: "%.1f", value.kilometer) + " km"
        }
      }
    }
  }
  
  /// 미세먼지량과 위치정보 같은 API정보들을 업데이트 하는 메소드.
  private func updateAPIInfo() {
    // 위치에 관련된 Label들을 업데이트함.
    dustInfoService.requestRecentTimeInfo { info, error in
      if let error = error as? ServiceErrorType {
        error.presentToast()
        return
      }
      if let info = info {
        DispatchQueue.main.async {
          self.fineDustLabel.text = "\(info.fineDustValue)µg"
          self.locationLabel.text = SharedInfo.shared.address
          self.gradeLabel.text = info.fineDustGrade.description
        }
      }
    }
    
    // 마신 미세먼지양 Label들을 업데이트함.
    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
      if let error = error as? ServiceErrorType {
        error.presentToast()
        return
      }
      if let fineDust = fineDust, let ultrafineDust = ultrafineDust {
        if self.healthKitService.isAuthorized {
          DispatchQueue.main.async {
            self.intakeFineDustLable.text = "\(fineDust)µg"
            self.intakeUltrafineDustLabel.text = "\(ultrafineDust)µg"
          }
        }
      }
    }
  }
  
  /// 권한이 없을시 권한설정을 도와주는 AlertController.
  private func presentOpenHealthAppAlert() {
    if !healthKitService.isAuthorized {
      UIAlertController
        .alert(title: "건강 App 권한이 없습니다.",
               message: """
          내안의먼지는 건강 App에 대한 권한이 필요합니다. 건강 App-> 데이터소스 -> 내안의먼지 -> 모든 쓰기, 읽기 권한을 \
          허용해주세요.
          """
        )
        .action(title: "건강 App", style: .default) { _, _ in
          UIApplication.shared.open(URL(string: "x-apple-health://")!)
        }
        .action(title: "취소", style: .cancel)
        .present(to: self)
    }
  }
}
