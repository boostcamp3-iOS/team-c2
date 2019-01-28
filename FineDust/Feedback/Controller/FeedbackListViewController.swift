//
//  FeedbackListViewController.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class FeedbackListViewController: UIViewController {
  
  // MARK: IBOutlet
  @IBOutlet private weak var feedbackCollectionView: UICollectionView!
  @IBOutlet private weak var feedbackListTabelView: UITableView!
  
  // MARK: Properties
  private let reuseIdentifiers = ["feedbackCell", "feedbackListCell"]
  private var count = 10
  private let cornerRadius: CGFloat = 5
  private let screenSize = UIScreen.main.bounds
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "먼지 정보"
    
    feedbackCollectionView.reloadData()
    feedbackListTabelView.reloadData()
  }
}

// MARK: - UICollectionViewDataSource

extension FeedbackListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 3
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifiers[0],
      for: indexPath
    ) as? FeedbackCollectionViewCell
      else { return UICollectionViewCell() }
    
    cell.setProperties()
    //    cell.feedbackTitleLabel.text = "미세먼지 정화 식물"
    //    cell.feedbackTitleLabel.layer.cornerRadius = cornerRadius
    //    cell.feedbackTitleLabel.layer.masksToBounds = true
    
    return cell
  }
}

// MARK: - UITabelViewDataSource

extension FeedbackListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: reuseIdentifiers[1],
      for: indexPath
    ) as? FeedbackListTableViewCell else {
        return UITableViewCell()
    }
    
    cell.setProperties(at: indexPath.row)
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension FeedbackListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 165
  }
}
