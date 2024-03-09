//
//  DayViewController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit
import SnapKit

class DayViewController: UIViewController {
  
  var tableView = UITableView .init()
  
  var dataSource: UITableViewDiffableDataSource<Section, Day>?
  
  var confirmDelete: (() -> Void)?
  
  var program: Program?
  let staticCellsCount = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "Days"
    configureView()
    configureDataSource()
    applySnapshot()
    
    let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(showActionSheet))
    navigationItem.rightBarButtonItem = trashButton
    
    tableView.register(DayCell.self, forCellReuseIdentifier: "dayCell")
    tableView.register(DescriptCell.self, forCellReuseIdentifier: "descriptCell")
    tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
    tableView.delegate = self
  }
  
  func configureView() {
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
//MARK: - configureDataSource

extension DayViewController {
  
  func configureDataSource() {
    dataSource = UITableViewDiffableDataSource<Section, Day>(tableView: tableView) { [self] tableView, indexPath, day in
      
      if indexPath.row == 0 {
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
        imageCell.setupImageCell(with: "1")
        return imageCell
      }
      
      else if indexPath.row == 1 {
        let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "descriptCell", for: indexPath) as!
        DescriptCell
        guard let description = program?.descriptionText else { fatalError() }
        descriptionCell.descriptionText.text = description.description
        return descriptionCell
        
      }else{
        let dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayCell
        guard let day = program?.days[indexPath.row - staticCellsCount] else { fatalError() }
        dayCell.setupDayCell(dayCell: day)
        return dayCell
      }
    }
  }
  //MARK: - applySnapshot
  
  func applySnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Day>()
    snapshot.appendSections([.main])
    snapshot.appendItems([Day(weekDayNum: 0, exercises: [])])
    snapshot.appendItems([Day(weekDayNum: 1, exercises: [])])
    snapshot.appendItems(program?.days ?? [], toSection: .main)
    dataSource?.apply(snapshot, animatingDifferences: true)
  }
}

//MARK: - UITableViewDelegate

extension DayViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let dayIndex = indexPath.row - staticCellsCount
    guard dayIndex >= 0, dayIndex < program?.days.count ?? 0 else { return }
    let selectedDay = program?.days[dayIndex]
    
    let exerciseController = ExerciseController()
    
    let exercises = selectedDay?.exercises ?? []
    exerciseController.exercises = exercises
    
    exerciseController.modalPresentationStyle = .fullScreen
    self.present(exerciseController, animated: true, completion: nil)
  }
}

//MARK: - ShowActionSheet

extension DayViewController {
  
  @objc func showActionSheet() {
    let alertController = UIAlertController(title: "Do you really want to remove this program?", message: nil, preferredStyle: .actionSheet)
    
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
      self.confirmDelete?()
      self.navigationController?.popViewController(animated: true)
    }
    let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel) { _ in  }
    alertController.addAction(cancelAlert)
    alertController.addAction(deleteAction)
    present(alertController, animated: true) {
    }
  }
}
