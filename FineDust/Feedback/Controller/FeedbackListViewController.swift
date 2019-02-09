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
  
  // MARK: IBOutlet
  
  @IBOutlet private weak var feedbackListTableView: UITableView!
  
  // MARK: Properties
  
  let feedbackService = FeedbackService()
  private let reuseIdentifiers = ["recommendTableCell", "feedbackListCell"]
  private var count = 10
  private var dustFeedbacks: [DustFeedback] = []
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "먼지 정보".localized
    
    feedbackListTableView.reloadData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(didReceiveFeedback(_:)),
                   name: .didReceiveFeedback,
                   object: nil)
    feedbackService.requestDustFeedbacks()
    print(dustFeedbacks)
  }

  @objc func didReceiveFeedback(_ noti: Notification) {
    guard let dustFeedbacks = noti.userInfo?["feedbacks"] as? [DustFeedback]
      else { return }
    
    self.dustFeedbacks = dustFeedbacks
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
      return count
    }
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView
      .dequeueReusableCell(withIdentifier: reuseIdentifiers[indexPath.section],
                           for: indexPath)
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension FeedbackListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
  
  /// 테이블뷰 헤더 이름 설정.
  func tableView(_ tableView: UITableView,
                 titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "추천"
    } else {
      return "목록"
    }
  }
}

// MARK: - UICollectionViewDataSource

extension FeedbackListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "recommendCell",
      for: indexPath
      ) as? RecommendCollectionViewCell
      else { return UICollectionViewCell() }
    
    return cell
  }
}
