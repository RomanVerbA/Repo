//
//  ViewController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit
import SnapKit

typealias ProgramListDataSource = UICollectionViewDiffableDataSource<ProgramViewController.ProgramListSection, Program>

final class ProgramViewController: UIViewController {
  enum ProgramListSection: Hashable {
    case programs
  }
  
  var collectionView: UICollectionView!
  
  private lazy var dataSource: ProgramListDataSource = {
    let dataSource = ProgramListDataSource (collectionView: collectionView, cellProvider: { collectionView, indexPath, program in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramCell", for: indexPath) as? ProgramCell else { fatalError() }
      cell.setupProgramCell(programCell: program)
      return cell
    })
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
    configureCollectionView()
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

private extension ProgramViewController {
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupLayout())
    view.addSubview(collectionView)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(ProgramCell.self, forCellWithReuseIdentifier: "ProgramCell")
    collectionView.delegate = self
    collectionView.refreshControl = myRefreshControl
  }
}

private extension ProgramViewController {
  func setupLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    let section = NSCollectionLayoutSection(group: group)
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
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
  
  func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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

extension ProgramViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
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
