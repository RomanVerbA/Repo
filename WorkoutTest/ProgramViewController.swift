//
//  ViewController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit
import SnapKit

typealias ProgramListDataSource = UITableViewDiffableDataSource<ProgramViewController.ProgramListSection, Program>

final class ProgramViewController: UIViewController {
  enum ProgramListSection: Hashable {
    case programs
  }
  
  let tableView: UITableView = .init()
  
  private lazy var dataSource: ProgramListDataSource = {
    let dataSource = ProgramListDataSource (tableView: tableView, cellProvider: { tableView, indexPath, program in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell", for: indexPath) as? ProgramCell else { fatalError() }
      cell.setupProgramCell(programCell: program)
      return cell
    })
    dataSource.defaultRowAnimation = .right
    return dataSource
  }()
  
  private var welcome: Welcome?
  
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
    refreshData()
  }
  
  @objc private func refreshData() {
    repo.load(completion: { [weak self] data in
      self?.welcome = data
      self?.applySnapshot()
      self?.myRefreshControl.endRefreshing()
    })
  }
}

extension ProgramViewController {
  private func configureTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

//MARK: - applySnapshot

extension ProgramViewController {
  
  private func applySnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<ProgramListSection, Program>()
    snapshot.appendSections([.programs])
    snapshot.appendItems(welcome?.programs ?? [], toSection: .programs)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  //MARK: - trailingSwipeDelete
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteProgramAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
      guard self.dataSource.itemIdentifier(for: indexPath) != nil else {
        completion(false)
        return
      }
      
      self.welcome?.programs.remove(at: indexPath.row)
      self.applySnapshot()
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
  
  private func deleteProgram(at index: Int) {
    welcome?.programs.remove(at: index)
    applySnapshot()
  }
}
