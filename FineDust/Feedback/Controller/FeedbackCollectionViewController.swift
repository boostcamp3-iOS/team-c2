//
//  FeedbackCollectionViewController.swift
//  FineDust
//
//  Created by 이재은 on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

private let reuseIdentifier = "feedbackCell"

final class FeedbackCollectionViewController: UIViewController {

  @IBOutlet weak var feedbackCollectionView: UICollectionView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "먼지 정보"
        feedbackCollectionView.reloadData()
    }

  private var count = 8
  private let cornerRadius: CGFloat = 7

}
    // MARK: UICollectionViewDataSource

extension FeedbackCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(
      _ collectionView: UICollectionView,
      numberOfItemsInSection section: Int
      ) -> Int {
        return count
    }

    func collectionView(
      _ collectionView: UICollectionView,
      cellForItemAt indexPath: IndexPath
      ) -> UICollectionViewCell {

      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        as? FeedbackCollectionViewCell else {
          return UICollectionViewCell()
      }
      cell.feedbackImageView.layer.cornerRadius = cornerRadius
      cell.feedbackImageView.layer.masksToBounds = true
      cell.feedbackImageView.image = UIImage(named: "info1")

  
        return cell
    }
  }
    // MARK: UICollectionViewDelegate
