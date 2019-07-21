//
//  Banner.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import NotificationBannerSwift

protocol BannerType {
  
  static func show(title: String?, subtitle: String?, style: BannerStyle)
}

final class Banner: BannerType {
  
  static func show(title: String?, subtitle: String? = nil, style: BannerStyle = .success) {
    let notificationBanner = NotificationBanner(title: title, subtitle: subtitle, style: style)
    notificationBanner.show()
  }
}
