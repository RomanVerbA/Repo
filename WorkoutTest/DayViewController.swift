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
  let cells = 2
  
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
    return cells + (program?.days.count)!
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.row == 0 {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
      cell.setupImage(with: "1")
      return cell
    }
    
    else if indexPath.row == 1 {
      
      let cell1 = tableView.dequeueReusableCell(withIdentifier: "descriptCell", for: indexPath) as!
      DescriptCell
      guard let description = program?.descriptionText else { fatalError() }
      cell1.descript.text = description.description
      return cell1
      
    }else{
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayCell
      guard let day = program?.days[indexPath.row-2] else { fatalError() }
      cell.setupCell(dayCell: day)
      return cell
    }
  }
}

//MARK: - UITableViewDelegate

extension DayViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
