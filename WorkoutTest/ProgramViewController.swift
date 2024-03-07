//
//  ViewController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit
import SnapKit

class ProgramViewController: UIViewController {
  
  let tableView: UITableView = .init()
  
  var dataSource: UITableViewDiffableDataSource<Section, Program>?
  
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
    tableView.delegate = self
    configureTableView()
    createDataSource()
    refreshData()
  }
  
  @objc func refreshData() {
    repo.load(completion: { [weak self] data in
      self?.welcome = data
      self?.applySnapshot()
      self?.myRefreshControl.endRefreshing()
    })
  }
}

extension ProgramViewController {
  func configureTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

//MARK: - createDataSource & applySnapshot

extension ProgramViewController {
  
  func createDataSource() {
    dataSource = UITableViewDiffableDataSource<Section, Program>(tableView: tableView, cellProvider: { tableView, indexPath, program in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell", for: indexPath) as? ProgramCell else { fatalError() }
      cell.setupProgramCell(programCell: program)
      return cell
    })
  }
  
  func applySnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Program>()
    snapshot.appendSections([.programa])
    snapshot.appendItems(welcome?.programs ?? [], toSection: .programa)
    dataSource?.apply(snapshot, animatingDifferences: true)
  }
  
  //MARK: - trailingSwipeDelete
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteProgramAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
      guard let program = self.dataSource?.itemIdentifier(for: indexPath) else {
        completion(false)
        return
      }
      
      var snapshot = self.dataSource?.snapshot()
      snapshot?.deleteItems([program])
      self.dataSource?.apply(snapshot ?? NSDiffableDataSourceSnapshot<Section, Program>(), animatingDifferences: true)
      self.welcome?.programs.remove(at: indexPath.row)
      completion(true)
    }
    
    deleteProgramAction.backgroundColor = .orange
    deleteProgramAction.image = UIImage(named: "delete")
    return UISwipeActionsConfiguration(actions: [deleteProgramAction])
  }
}

//MARK: - UITableViewDelegate

extension ProgramViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let selectedProgram = welcome?.programs[indexPath.row]
    let vc = DayViewController()
    vc.program = selectedProgram
    vc.confirmDelete = { [weak self] in
      self?.deleteProgram(at: indexPath.row)
    }
    navigationController?.pushViewController(vc, animated: true)
  }
  // MARK: - Function for deleting a cell
  
  func deleteProgram(at index: Int) {
    welcome?.programs.remove(at: index)
    applySnapshot()
  }
}
