//
//  ViewController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit

class ProgramViewController: UIViewController {
  
  let tableView: UITableView = .init()
  
  var welcome: Welcome?
  
  let repo = JsonRepo()
  
  let myRefreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    return refreshControl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Programs"
    
    tableView.backgroundColor = .white
    tableView.register(ProgramCell.self, forCellReuseIdentifier: "ProgramCell")
    tableView.refreshControl = myRefreshControl
    tableView.dataSource = self
    tableView.delegate = self
    configureTableView()
    refreshData()
  }
  
  @objc func refreshData() {
    repo.load(completion: { [weak self] data in
      self?.welcome = data
      self?.tableView.reloadData()
      self?.myRefreshControl.endRefreshing()
    })
  }
}

extension ProgramViewController {
  func configureTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

//MARK: - UITableViewDataSource

extension ProgramViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return welcome?.programs.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let programCell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell", for: indexPath) as? ProgramCell else { fatalError() }
    guard let program = welcome?.programs[indexPath.row] else { fatalError() }
    programCell.setupProgramCell(programCell: program)
    return programCell
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteProgramAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
      
      self.welcome?.programs.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      completion(true)
    }
    
    deleteProgramAction.backgroundColor = .orange
    deleteProgramAction.image = UIImage(named: "delete")
    return UISwipeActionsConfiguration(actions: [deleteProgramAction])
  }
  
  //MARK: - UITableViewDelegate
}
extension ProgramViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let selectedProgram = welcome?.programs[indexPath.row]
    let vc = DayViewController()
    vc.program = selectedProgram
    navigationController?.pushViewController(vc, animated: true)
  }
}
