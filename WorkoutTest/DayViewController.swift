//
//  DayViewController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit
import SnapKit

typealias DayListDataSource = UITableViewDiffableDataSource<DayViewController.Section, DayViewController.SectionItem>

class DayViewController: UIViewController {
  enum SectionType {
    case main
  }
  
  struct Section: Hashable {
    let type: SectionType
    let items: [SectionItem]
  }
  
  enum SectionItem: Hashable {
    case image(String)
    case description(String)
    case day(Day)
  }
  
  var tableView = UITableView .init()
  
  private lazy var dataSource: DayListDataSource = {
    let dataSource = DayListDataSource(tableView: tableView) { tableView, indexPath, item in
      switch item {
      case .image(let imageName):
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell
        imageCell?.setupImageCell(with: imageName)
        return imageCell
      case .description(let description):
        let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "descriptCell", for: indexPath) as? DescriptCell
        descriptionCell?.descriptionText.text = description
        return descriptionCell
      case .day(let day):
        let dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as? DayCell
        dayCell?.setupDayCell(dayCell: day)
        return dayCell
      }
    }
    return dataSource
  }()
  
  var confirmDelete: (() -> Void)?
  
  var program: Program?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "Days"
    configureView()
    applySnapshot()
    
    let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(showActionSheet))
    navigationItem.rightBarButtonItem = trashButton
    
    tableView.register(DayCell.self, forCellReuseIdentifier: "dayCell")
    tableView.register(DescriptCell.self, forCellReuseIdentifier: "descriptCell")
    tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
    tableView.delegate = self
  }
  
  private func configureView() {
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  //MARK: - applySnapshot
  
  private func applySnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
    
    var items: [SectionItem] = [.image("1"), .description(program?.descriptionText ?? "")]
    let dayItems = program?.days.map { SectionItem.day($0) } ?? []
    items.append(contentsOf: dayItems)
    let section = Section(
      type: .main,
      items: items
    )
    snapshot.appendSections([section])
    snapshot.appendItems(section.items)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

//MARK: - UITableViewDelegate

extension DayViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
    switch item {
    case .day(let day):
      let exerciseController = ExerciseController()
      let exercise = day.exercises
      exerciseController.exercises = exercise
      exerciseController.modalPresentationStyle = .fullScreen
      present(exerciseController, animated: true, completion: nil)
    default:
      return
    }
  }
}

//MARK: - ShowActionSheet

private extension DayViewController {
  
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
