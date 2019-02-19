//
//  TodayViewController.swift
//  FineDustWidget
//
//  Created by Presto on 14/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit
import NotificationCenter

final class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet private weak var dustImageView: UIImageView!
  
  @IBOutlet private weak var fineDustIntakeLabel: UILabel!
  
  @IBOutlet private weak var ultrafineDustIntakeLabel: UILabel!
  
  private var label = UILabel()
  
  private let defaults = UserDefaults(suiteName: "group.kr.co.boostcamp3rd.FineDust")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    defaults?.synchronize()
    let fineDustIntake = defaults?.integer(forKey: "fineDustIntake")
    let ultrafineDustIntake = defaults?.integer(forKey: "ultrafineDustIntake")
    if let fineDustIntake = fineDustIntake,
      let ultrafineDustIntake = ultrafineDustIntake {
      label.isHidden = true
      fineDustIntakeLabel.text = "\(fineDustIntake)"
      ultrafineDustIntakeLabel.text = "\(ultrafineDustIntake)"
      dustImageView.image
        = UIImage(named: IntakeGrade(intake: fineDustIntake + ultrafineDustIntake).iconName)
    } else {
      label.isHidden = false
      label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
      label.textColor = .black
      label.text = "애플리케이션을 실행해주세요."
      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let url = URL(string: "finedust://") else { return }
    extensionContext?.open(url) { isSuccess in
      print(isSuccess)
    }
  }
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    completionHandler(NCUpdateResult.newData)
  }
  
  func widgetMarginInsets(
    forProposedMarginInsets defaultMarginInsets: UIEdgeInsets
    ) -> UIEdgeInsets {
    return .zero
  }
}
