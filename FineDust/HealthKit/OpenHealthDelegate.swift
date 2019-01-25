//
//  OpenHealthDelegate.swift
//  FineDust
//
//  Created by zun on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

///건강 App으로 이동시키는 기능을 모듈화 하기 위한 프로토콜
protocol OpenHealthDelegate: class {
    func openHealth(_ viewController: UIViewController)
}
