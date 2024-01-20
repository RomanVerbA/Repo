//
//  DayViewController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit

class DayViewController: UIViewController {
  
  var tableView = UITableView .init()
  
  var program: Program?{
    didSet {
      descriptionProgram.text = program?.descriptionText
      imageProgram.image = UIImage(named: "1")
    }
  }
  
  let scrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.backgroundColor = .white
    return scroll
  }()
  
  let imageProgram: UIImageView = {
    let image = UIImageView()
    image.backgroundColor = .green
    return image
  }()
  
  let descriptionProgram: UILabel = {
    let description = UILabel()
    description.backgroundColor = .white
    description.font = UIFont(name: "Helvetica-Bold", size: 18)
    description.numberOfLines = 0
    return description
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "Days"
    configureView()
    
    
    tableView.register(DayCell.self, forCellReuseIdentifier: "dayCell")
    tableView.dataSource = self
    tableView.delegate = self
    
  }
  
  func configureView() {
    tableView.reloadData()
    view.addSubview(scrollView)
    scrollView.addSubview(imageProgram)
    scrollView.addSubview(descriptionProgram)
    scrollView.addSubview(tableView)
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    imageProgram.translatesAutoresizingMaskIntoConstraints = false
    descriptionProgram.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      imageProgram.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
      imageProgram.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 10),
      imageProgram.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -10),
      imageProgram.heightAnchor.constraint(equalToConstant: 400),
      
      descriptionProgram.topAnchor.constraint(equalTo: imageProgram.bottomAnchor, constant: 10),
      descriptionProgram.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 10),
      descriptionProgram.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -10),
      descriptionProgram.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10),
      
      tableView.topAnchor.constraint(equalTo: descriptionProgram.bottomAnchor, constant: 10),
      tableView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 10),
      tableView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -10),
      tableView.heightAnchor.constraint(equalToConstant: 500),
      tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
    ])
  }
}
//MARK: - UITableViewDataSource

extension DayViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return program?.days.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayCell
    guard let day = program?.days[indexPath.row] else { fatalError() }
    cell.setupCell(dayCell: day)
    return cell
  }
}
//MARK: - UITableViewDelegate

extension DayViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
