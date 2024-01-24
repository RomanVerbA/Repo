//
//  DayViewController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit

class DayViewController: UIViewController {
  
  var tableView = UITableView .init()
  
  var program: Program?
  let addCells = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "Days"
    configureView()
    
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
    return addCells + (program?.days.count)!
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
      guard let day = program?.days[indexPath.row-2] else { fatalError() }
      dayCell.setupDayCell(dayCell: day)
      return dayCell
    }
  }
}

//MARK: - UITableViewDelegate

extension DayViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
