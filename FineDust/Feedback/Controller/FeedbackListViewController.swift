//
//  FeedbackListViewController.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

private let reuseIdentifier = ["feedbackCell", "feedbackListCell"]

final class FeedbackListViewController: UIViewController {

  @IBOutlet weak var feedbackCollectionView: UICollectionView!
  @IBOutlet weak var feedbackListTabelView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "먼지 정보"

    feedbackCollectionView.reloadData()
    feedbackListTabelView.reloadData()
  }

  private var count = 10
  private let cornerRadius: CGFloat = 7

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

      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier[0], for: indexPath)
        as? FeedbackCollectionViewCell else {
          return UICollectionViewCell()
      }
      cell.feedbackImageView.layer.cornerRadius = cornerRadius
      cell.feedbackImageView.layer.masksToBounds = true
      cell.feedbackImageView.image = UIImage(named: "info1")
      
      cell.feedbackTitleLabel.text = "미세먼지 정화 식물"
      cell.feedbackTitleLabel.layer.cornerRadius = cornerRadius
      cell.feedbackTitleLabel.layer.masksToBounds = true
  
        return cell
    }
  }
    // MARK: - UICollectionViewDelegate

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
      withIdentifier: reuseIdentifier[1],
      for: indexPath
      ) as? FeedbackListTableViewCell else {
        return UITableViewCell()
    }
    cell.feedbackImageView.image = UIImage(named: "info1")
    cell.feedbackTitleLabel.text = "미세먼지 정화 식물"
    cell.feedbackSourceLabel.text = "KTV 국민 방송"

    cell.feedbackImageView.setRounded()
    
    cell.feedbackListShadowView.layer.applySketchShadow(
      color: UIColor.gray, alpha: 0.2, x: 0, y: 0, blur: 5, spread: 3)
    cell.feedbackListShadowView.layer.cornerRadius = 5
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension FeedbackListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
}
