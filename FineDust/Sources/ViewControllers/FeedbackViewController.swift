//
//  FeedbackListViewController.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class FeedbackViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  fileprivate let viewModel = FeedbackViewModel()
  
  @IBOutlet private weak var tableView: UITableView!
  
  // MARK: - Properties
  
  var feedbackListService = FeedbackService()
  private let reuseIdentifiers = ["recommendTableCell", "feedbackListCell"]
  private var feedbackCount = 0
  private var newDustFeedbacks: [FeedbackContents]?
  private var isBookmarkedByTitle: [String: Bool] = [:]
  private var recommendFeedbacks: [FeedbackContents] = []
  
  private var fineDustIntake: Int = 30
  
  private var ultrafineDustIntake: Int = 20
  
  private var currentState: IntakeGrade = .good
  private let sectionToReload: IndexSet = [1]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadFeedback()
  }
}

private extension FeedbackViewController {
  
  func bindViewModel() {
    viewModel.settingButtonTapped.asDriver(onErrorJustReturn: Void())
      .drive(onNext: { [weak self] _ in
        self?.presentSettingActionSheet()
      })
      .disposed(by: disposeBag)
  }
  
  func presentSettingActionSheet() {
    UIAlertController
      .alert(title: "정렬 방법",
             message: "정렬 방법을 선택해 주세요.",
             style: .actionSheet)
      .action(title: "최신순") { [weak self] _, _ in
        self?.newDustFeedbacks = self.feedbackListService.fetchFeedbacksByRecentDate()
        self?.tableView.reloadSections(self.sectionToReload, with: .none)
      }
      .action(title: "제목순") { [weak self] _, _ in
        self?.newDustFeedbacks = self.feedbackListService.fetchFeedbacksByTitle()
        self?.tableView.reloadSections(self.sectionToReload, with: .none)
      }
      .action(title: "북마크") { [weak self] _, _ in
        self?.newDustFeedbacks = self.feedbackListService.fetchFeedbacksByBookmark()
        self?.tableView.reloadSections(self.sectionToReload, with: .none)
      }
      .action(title: "취소", style: .cancel)
      .present(to: self)
  }
  
  func setup() {
    feedbackCount = feedbackListService.fetchFeedbackCount()
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
  }
  
  func loadFeedback() {
    isBookmarkedByTitle = feedbackListService.isBookmarkedByTitle
    tableView.reloadSections(sectionToReload, with: .none)
    calculateState()
    recommendFeedbacks = feedbackListService.fetchRecommededFeedbacks(by: currentState)
  }
  
  /// 미세먼지 섭취량으로 현재 상태를 계산함.
  func calculateState() {
    if let defaults = defaults {
      fineDustIntake = defaults.integer(forKey: "fineDustIntake")
      ultrafineDustIntake = defaults.integer(forKey: "ultrafineDustIntake")
      
      let totalIntake = fineDustIntake + ultrafineDustIntake
      currentState = IntakeGrade(intake: totalIntake)
    }
  }
  
  func pushDetailViewController(title: String) {
    guard let detailViewController = storyboard?
      .instantiateViewController(withIdentifier: FeedbackDetailViewController.classNameToString)
      as? FeedbackDetailViewController else { return }
    detailViewController.feedbackTitle = title
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}

// MARK: - Implement UITabelViewDataSource

extension FeedbackViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: reuseIdentifiers[indexPath.section], for: indexPath)
      as? FeedbackCell else { return UITableViewCell() }
    cell.delegate = self
    
    if let newDustFeedbacks = newDustFeedbacks {
      cell.configure(feedbackContents: newDustFeedbacks[indexPath.row])
    } else {
      let feedback = feedbackListService.fetchFeedbacksByBookmark()
      cell.configure(feedbackContents: feedback[indexPath.row])
    }
    cell.setBookmarkButtonState(isBookmarkedByTitle: isBookmarkedByTitle)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : feedbackCount
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
}

// MARK: - Implement UITableViewDelegate

extension FeedbackViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.section == 0 ? 330 : UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let currentCell = tableView.cellForRow(at: indexPath)
      as? FeedbackCell else { return }
    pushDetailViewController(title: currentCell.title)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView(frame: .init(x: 0,
                                         y: 0,
                                         width: view.bounds.width,
                                         height: 60))
    headerView.backgroundColor = .init(white: 1, alpha: 0.7)
    
    let headerLabel = UILabel().then {
      $0.textColor = .darkGray
      $0.font = .systemFont(ofSize: $0.font.pointSize, weight: .bold)
    }
    headerView.addSubview(headerLabel) {
      $0.leading.equalTo(headerView.snp.leading).offset(20)
      $0.centerY.equalTo(headerView.snp.centerY)
    }
    
    // 정렬 액션시트 버튼 설정
    let button = UIButton(type: .system).then {
      $0.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
      $0.setImage(Asset.sort.image, for: [])
      $0.rx.tap.asDriver()
        .drive(onNext: { [weak self] _ in
          self?.viewModel.tapSettingButton()
        })
        .disposed(by: disposeBag)
    }
    headerView.addSubview(button) {
      $0.centerY.equalTo(headerView.snp.centerY)
      $0.leading.equalTo(headerLabel.snp.trailing).offset(5)
      $0.width.equalTo(44)
      $0.height.equalTo(44)
    }
    button.isHidden = section != 1
    headerLabel.text = section == 1 ? "전체 목록" : "맞춤 정보 추천"
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
}

// MARK: - Implement UICollectionViewDataSource

extension FeedbackViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "recommendCell",
                           for: indexPath) as? RecommendCollectionViewCell
      else { return UICollectionViewCell() }
    
    let feedback = recommendFeedbacks[indexPath.item]
    cell.setCollectionViewCellProperties(dustFeedback: feedback)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return recommendFeedbacks.count
  }
}

// MARK: - Implement UICollectionViewDelegate

extension FeedbackViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    guard let currentCell = collectionView.cellForItem(at: indexPath)
      as? RecommendCollectionViewCell else { return }
    pushDetailViewController(feedbackTitle: currentCell.title)
  }
}

// MARK: - FeedbackListCellDelegate

extension FeedbackViewController: FeedbackListCellDelegate {
  
  func feedbackListCell(_ feedbackListCell: FeedbackCell,
                        didTapBookmarkButton button: UIButton) {
    button.isSelected.toggle()
    let title = feedbackListCell.title
    if button.isSelected {
      isBookmarkedByTitle[title] = true
      feedbackListService.saveBookmark(by: title)
    } else {
      isBookmarkedByTitle[title] = false
      feedbackListService.deleteBookmark(by: title)
    }
    self.newDustFeedbacks = self.feedbackListService.fetchFeedbacksByBookmark()
    self.tableView.reloadSections(sectionToReload, with: .none)
  }
}
