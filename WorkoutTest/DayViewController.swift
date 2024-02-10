//
//  DayViewController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit

class DayViewController: UIViewController {
  
  var tableView = UITableView .init()
  
  var confirmDelete: (() -> Void)?
  
  var program: Program?
  let staticCellsCount = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "Days"
    configureView()
    
    let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(showActionSheet))
    navigationItem.rightBarButtonItem = trashButton
    
    tableView.register(DayCell.self, forCellReuseIdentifier: "dayCell")
    tableView.register(DescriptCell.self, forCellReuseIdentifier: "descriptCell")
    tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
    
    tableView.dataSource = self
    tableView.delegate = self
    
  }
  
  func configureView() {
    view.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
//MARK: - UITableViewDataSource

extension DayViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return staticCellsCount + (program?.days.count)!
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
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
      guard let day = program?.days[indexPath.row-staticCellsCount] else { fatalError() }
      dayCell.setupDayCell(dayCell: day)
      return dayCell
    }
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
    
    let firstExercise = selectedDay?.exercises.first
    exerciseController.exercise = firstExercise
    exerciseController.timerView.exercise = firstExercise
    
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
