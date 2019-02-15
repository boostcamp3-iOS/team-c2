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
  
  // MARK: - Properties
  
  var feedbackListService = FeedbackListService(jsonManager: JSONManager())
  private let reuseIdentifiers = ["recommendTableCell", "feedbackListCell"]
  private var feedbackCount = 0
  private var newDustFeedbacks: [DustFeedback]?
  private var isBookmarkedByTitle: [String: Bool] = [:]
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "먼지 정보".localized
    isBookmarkedByTitle
      = UserDefaults.standard.dictionary(forKey: "isBookmarkedByTitle") as? [String: Bool] ?? [:]
    
    do {
      feedbackCount = try feedbackListService.fetchFeedbackCount()
    } catch {
      print(error.localizedDescription)
    }
    
    feedbackListTableView.reloadData()
  }
  
  // MARK: - Function
  
  private func pushDetailViewController() {
    if let viewController = storyboard?
      .instantiateViewController(withIdentifier: FeedbackDetailViewController.classNameToString) {
      navigationController?.pushViewController(viewController, animated: true)
    }
  }
  
  /// 미세먼지 정보 정렬 액션시트
  @objc func settingButtonDidTap(_ sender: UIButton) {
    
    let sectionToReload = 1
    let indexSet: IndexSet = [sectionToReload]
    
    UIAlertController
      .alert(title: "정렬방식 선택", message: "미세먼지 관련 정보를 어떤 순서로 정렬할까요?", style: .actionSheet)
      .action(title: "최신순") { _, _ in
        self.newDustFeedbacks = self.feedbackListService.fetchFeedbacksByRecentDate()
        self.feedbackListTableView.reloadSections(indexSet, with: .none)
      }
      .action(title: "제목순") { _, _ in
        self.newDustFeedbacks = self.feedbackListService.fetchFeedbacksByTitle()
        self.feedbackListTableView.reloadSections(indexSet, with: .none)
      }
      .action(title: "즐겨찾기순") { _, _ in
        self.newDustFeedbacks = self.feedbackListService.fetchFeedbacksByBookmark()
        self.feedbackListTableView.reloadSections(indexSet, with: .none)
      }
      .action(title: "취소", style: .cancel)
      .present(to: self)
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
      return feedbackCount
    }
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: reuseIdentifiers[indexPath.section],
                           for: indexPath) as? FeedbackListTableViewCell
    else { return UITableViewCell() }
    cell.delegate = self
    let feedback = feedbackListService.fetchFeedback(at: indexPath.row)
    
    if let newDustFeedbacks = newDustFeedbacks {
      cell.setTableViewCellProperties(dustFeedback: newDustFeedbacks[indexPath.row])
    } else {
      cell.setTableViewCellProperties(dustFeedback: feedback)
    }
    cell.setBookmarkButtonState(isBookmarkedByTitle: isBookmarkedByTitle)
    
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
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    pushDetailViewController()
  }
  
  func tableView(_ tableView: UITableView,
                 viewForHeaderInSection section: Int) -> UIView? {
    
    // headerView 설정
    let headerView = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.bounds.width,
                                          height: 60))
    headerView.backgroundColor = UIColor(white: 1, alpha: 0.7)
    
    // header title 설정
    let label = UILabel()
    label.textColor = .darkGray
    label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    headerView.addSubview(label)
    NSLayoutConstraint.activate([
      label.anchor.leading.equal(to: headerView.anchor.leading, offset: 20),
      label.anchor.centerY.equal(to: headerView.anchor.centerY)
      ])
    
    // 정렬 액션시트 버튼 설정
    let button = UIButton(type: .system)
    headerView.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    NSLayoutConstraint.activate([
      button.anchor.centerY.equal(to: headerView.anchor.centerY),
      button.anchor.trailing.equal(to: headerView.anchor.trailing, offset: -20),
      button.anchor.width.equal(toConstant: 44),
      button.anchor.height.equal(toConstant: 44)
      ])
    button.setImage(Asset.sort.image, for: [])
    button.addTarget(self,
                     action: #selector(settingButtonDidTap),
                     for: .touchUpInside)
    if section == 1 {
      button.isHidden = false
      label.text = "전체 목록"
    } else {
      button.isHidden = true
      label.text = "정보 추천"
    }
    
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
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
    
    let feedback = feedbackListService.fetchFeedback(at: indexPath.item)
    cell.setCollectionViewCellProperties(dustFeedback: feedback)
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension FeedbackListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    pushDetailViewController()
  }
}

// MARK: - FeedbackListCellDelegate

extension FeedbackListViewController: FeedbackListCellDelegate {
  func feedbackListCell(_ feedbackListCell: FeedbackListTableViewCell,
                        didTapBookmarkButton button: UIButton) {
    button.isSelected.toggle()
    let title = feedbackListCell.title
    if button.isSelected {
      isBookmarkedByTitle[title] = true
      feedbackListService.saveBookmark(by: title)
    } else {
      isBookmarkedByTitle[feedbackListCell.title] = false
      feedbackListService.deleteBookmark(by: title)
    }
  }
}
