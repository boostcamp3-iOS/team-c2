//
//  FeedbackListTableViewCell.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class FeedbackListTableViewCell: UITableViewCell {

  @IBOutlet private weak var feedbackImageView: UIImageView!
  @IBOutlet private weak var feedbackTitleLabel: UILabel!
  @IBOutlet private weak var feedbackSourceLabel: UILabel!
  @IBOutlet private weak var feedbackListShadowView: UIView!
  @IBOutlet private weak var feedbackListTitleLabel: UILabel!
  @IBOutlet private weak var bookmarkButton: UIButton!
}
