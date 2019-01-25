//
//  ValueGraphView.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// Value Graph View Data Source
protocol ValueGraphViewDataSource: class {
  
  var day: Date { get }
  
  var values: [CGFloat] { get }
}

/// Value Graph View Delegate
protocol ValueGraphViewDelegate: class {
  
  func valueGraphView(
    _ valueGraphView: ValueGraphView,
    didTapDoneButton button: UIBarButtonItem,
    for date: Date
  )
}

/// 지정 날짜 기준 일주일 그래프 관련 뷰
final class ValueGraphView: UIView {

  /// 레이어 관련 상수 모음
  enum Layer {
    
    static let borderWidth: CGFloat = 1.0
  }
  
  /// 애니메이션 관련 상수 모음
  enum Animation {
    
    static let duration: TimeInterval = 0.3
    
    static let delay: TimeInterval = 0.0
    
    static let damping: CGFloat = 0.7
    
    static let springVelocity: CGFloat = 0.5
    
    static let option: UIView.AnimationOptions = .curveEaseInOut
  }
  
  // MARK: Delegate
  
  weak var dataSource: ValueGraphViewDataSource?

  weak var delegate: ValueGraphViewDelegate?
  
  // MARK: Lazy Property
  
  /// DatePicker 프로퍼티
  private lazy var datePicker: UIDatePicker = {
    let picker = UIDatePicker()
    picker.calendar = Calendar.current
    picker.date = Date()
    picker.datePickerMode = .date
    picker.maximumDate = Date()
    picker.minimumDate = Calendar.current.date(from: DateComponents(year: 2019, month: 1, day: 1))
    picker.locale = Locale(identifier: "ko_KR")
    return picker
  }()
  
  /// DateFormatter 프로퍼티
  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy년 M월 d일 EEEE"
    return formatter
  }()
  
  // MARK: Private Properties
  
  /// 선택된 날짜
  private var selectedDate: Date = Date() {
    didSet {
      dateTextField.text = dateFormatter.string(from: selectedDate)
    }
  }
  
  /// 값 모음
  private var values: [CGFloat] {
    return dataSource?.values ?? []
  }
  
  /// 최대값
  private var maxValue: CGFloat {
    return (values.max() ?? 0.0) + 1.0
  }
  
  /// 값 모음을 최대값에 대한 비율로 산출. `1 - (비율)`
  private var ratios: [CGFloat] {
    return values.map { 1.0 - $0 / maxValue }
  }
  
  /// 주축 레이블
  private var axisTexts: [String] {
    return ["\(Int(maxValue))", "\(Int(maxValue / 2))", "0"]
  }
  
  /// 일 텍스트
  private var dayTexts: [String] {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "d"
    var array = [Date].init(repeating: selectedDate, count: 7)
    for (index, element) in array.enumerated() {
      array[index] = element.day(beforeDays: index)
    }
    return array.map { dateFormatter.string(from: $0) }.reversed()
  }
  
  // MARK: IBOutlets
  
  /// 날짜 표시 텍스트 필드
  @IBOutlet private weak var dateTextField: UITextField! {
    didSet {
      let toolBar = UIToolbar(
        frame: CGRect(
          x: 0,
          y: 0,
          width: UIScreen.main.bounds.width,
          height: 44
        )
      )
      toolBar.items = [
        UIBarButtonItem(
          barButtonSystemItem: .flexibleSpace,
          target: nil,
          action: nil
        ),
        UIBarButtonItem(
          barButtonSystemItem: .done,
          target: self,
          action: #selector(doneButtonDidTap(_:))
        )
      ]
      selectedDate = Date()
      dateTextField.inputView = datePicker
      dateTextField.inputAccessoryView = toolBar
    }
  }
  
  /// 제목 레이블
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// 요일 레이블 모음
  @IBOutlet private var dayLabels: [UILabel]!
  
  /// 그래프 뷰 모음
  @IBOutlet private var graphViews: [UIView]! {
    didSet {
      for (index, view) in graphViews.enumerated() {
        view.layer.setBorder(
          color: .black,
          width: 0,
          radius: 2.0
        )
        view.backgroundColor = graphBackgroundColor(at: index)
      }
    }
  }
  
  /// 단위 레이블 모음
  @IBOutlet private var unitLabels: [UILabel]!
  
  /// 그래프 높이 제약 모음
  @IBOutlet private var graphViewHeightConstraints: [NSLayoutConstraint]!
  
  // MARK: Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setup() {
    initializeHeights()
    animateHeights()
    setUnitLabels()
    setTitleDayLabels()
    print(values, maxValue, ratios)
  }
  
  /// 키보드에 달린 완료 버튼을 눌렀을 때의 동작 정의
  @objc private func doneButtonDidTap(_ sender: UIBarButtonItem) {
    dateTextField.resignFirstResponder()
    dateTextField.text = dateFormatter.string(from: datePicker.date)
    selectedDate = datePicker.date
    setup()
    delegate?.valueGraphView(self, didTapDoneButton: sender, for: datePicker.date)
  }
}

// MARK: - Private Extension

private extension ValueGraphView {
  /// 그래프 뷰 높이 초기화
  func initializeHeights() {
    for (index, constraint) in graphViewHeightConstraints.enumerated() {
      graphViewHeightConstraints[index] = constraint.changedMultiplier(to: 1.0)
    }
    layoutIfNeeded()
  }
  
  /// 그래프 뷰 높이 제약에 애니메이션 효과 설정
  func animateHeights() {
    for (index, ratio) in ratios.enumerated() {
      var heightConstraint = graphViewHeightConstraints[index]
      DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
        UIView.animate(
          withDuration: Animation.duration,
          delay: Animation.delay,
          usingSpringWithDamping: Animation.damping,
          initialSpringVelocity: Animation.springVelocity,
          options: .curveEaseInOut,
          animations: {
            heightConstraint = heightConstraint.changedMultiplier(to: ratio)
            self?.layoutIfNeeded()
        },
          completion: nil
        )
      }
    }
  }
  
  /// 주축 레이블 설정
  func setUnitLabels() {
    zip(unitLabels, axisTexts).forEach { (label, text) in
      label.text = text
    }
  }
  
  /// 요일 레이블 텍스트 설정
  func setTitleDayLabels() {
    zip(dayLabels, dayTexts).forEach { (label, text) in
      label.text = text
    }
  }
  
  /// 그래프 색상 설정
  func graphBackgroundColor(at index: Int) -> UIColor? {
    if index == 6 {
      return Asset.graphToday.color
    }
    if index % 2 == 0 {
      return Asset.graph1.color
    } else {
      return Asset.graph2.color
    }
  }
}
