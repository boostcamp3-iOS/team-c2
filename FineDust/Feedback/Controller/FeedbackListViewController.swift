//
//  FeedbackListViewController.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 3번째 탭 피드백 화면
final class FeedbackListViewController: UIViewController {
  
  // MARK: - IBOutlet
  
  @IBOutlet private weak var feedbackListTableView: UITableView!
  
  @IBAction private func touchUpSortingButton(_ sender: UIBarButtonItem) {
    setSortActionSheet(to: self)
  }
  
  // MARK: - Properties
  
  var feedbackListService = FeedbackListService(jsonManager: JSONManager())
  private let reuseIdentifiers = ["recommendTableCell", "feedbackListCell"]
  private var feedbackCount = 0
  private var newDustFeedback: [DustFeedback]?
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "먼지 정보".localized
    
    feedbackCount = feedbackListService.fetchFeedbackCount()
    feedbackListTableView.reloadData()
  }
  
  // MARK: - Function
  
  /// 화면 이동
  func changeView() {
    if let view = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") {
      self.navigationController?.pushViewController(view, animated: true)
    }
  }
  
  /// 미세먼지 정보 정렬 액션시트
  func setSortActionSheet(to viewController: UIViewController) {
    
    let sectionToReload = 1
    let indexSet: IndexSet = [sectionToReload]
    
    UIAlertController
      .alert(title: "정렬방식 선택", message: "미세먼지 관련 정보를 어떤 순서로 정렬할까요?", style: .actionSheet)
      .action(title: "최신순", style: .default) { _, _ in
        self.newDustFeedback = self.feedbackListService.fetchFeedbackRecentDate()
        self.feedbackListTableView.reloadSections(indexSet, with: .none)
      }
      .action(title: "제목순", style: .default) { _, _ in
        self.newDustFeedback = self.feedbackListService.fetchFeedbackTitle()
        self.feedbackListTableView.reloadSections(indexSet, with: .none)
      }
      .action(title: "즐겨찾기순")
      .action(title: "취소", style: .cancel)
      .present(to: viewController)
  }
}

// MARK: - UITabelViewDataSource

extension FeedbackListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else {
      return feedbackListService.fetchFeedbackCount()
    }
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: reuseIdentifiers[indexPath.section],
                           for: indexPath) as? FeedbackListTableViewCell
      else { return UITableViewCell() }
    
    let feedback = feedbackListService.fetchFeedbackData(at: indexPath.row)
    
    if newDustFeedback != nil {
      if let newDustFeedback = newDustFeedback {
        cell.setTabelViewCellProperties(dustFeedback: newDustFeedback[indexPath.row])
      }
      
    } else {
      
      cell.setTabelViewCellProperties(dustFeedback: feedback)
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension FeedbackListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 330
    }
    return 130
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    changeView()
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  /// 테이블뷰 헤더 이름 설정.
  func tableView(_ tableView: UITableView,
                 titleForHeaderInSection section: Int) -> String? {
    
    if section == 0 {
      return "추천"
    }
    return "목록"
  }
}

// MARK: - UICollectionViewDataSource

extension FeedbackListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return feedbackCount > 2 ? 3 : feedbackCount
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "recommendCell",
                           for: indexPath) as? RecommendCollectionViewCell
      else { return UICollectionViewCell() }
    
    let feedback = feedbackListService.fetchFeedbackData(at: indexPath.item)
    cell.setCollectionViewCellProperties(dustFeedback: feedback)
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension FeedbackListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    changeView()
  }
}
