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
  
  private var searchText: String?
  private var favoritePrograms:[String] = []
  private var isShowingFavorites: Bool = false
  private let storage: StorageManagerProtocol = StorageManager()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
    collectionView.register(ProgramCell.self, forCellWithReuseIdentifier: "ProgramCell")
    return collectionView
  }()
  
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search Programs"
    return searchBar
  }()
  
  private lazy var dataSource: ProgramListDataSource = {
    let dataSource = ProgramListDataSource (collectionView: collectionView, cellProvider: { collectionView, indexPath, program in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramCell", for: indexPath) as? ProgramCell else { fatalError() }
      let isFavorite = self.favoritePrograms.contains(program.name)
      cell.setupProgramCell(programCell: program, isFavorite: isFavorite)
      cell.favoriteButtonAction = {
        self.toggleFavorite(program: program)
      }
      return cell
    })
    return dataSource
  }()
  
  private var welcome: Welcome?
  
  let repo = JsonRepo()
  
  private lazy var myRefreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    return refreshControl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Programs"
    configureFavoriteButton()
    configureSearchBar()
    configureCollectionView()
    loadFavoritePrograms()
    refreshData()
  }
  
  @objc private func refreshData() {
    guard searchBar.text?.isEmpty ?? true else {
      self.myRefreshControl.endRefreshing()
      return
    }
    
    repo.load(completion: { [weak self] data in
      self?.welcome = data
      self?.applySnapshot()
      self?.myRefreshControl.endRefreshing()
    })
  }
  
  private func configureSearchBar() {
    searchBar.delegate = self
    navigationItem.titleView = searchBar
  }
  
  private func configureFavoriteButton() {
    let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(showFavoritePrograms))
    favoriteButton.tintColor = isShowingFavorites ? .red : .systemBlue
    navigationItem.rightBarButtonItem = favoriteButton
  }
}

private extension ProgramViewController {
  
  func configureCollectionView() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    collectionView.delegate = self
    collectionView.refreshControl = myRefreshControl
  }
  
  func createLayout() -> UICollectionViewLayout {
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
    var data = welcome?.programs ?? []
    
    if let searchText = searchText {
      data = data.filter { program in program.name.contains(searchText) }
    }
    
    if isShowingFavorites {
      data = data.filter { program in favoritePrograms.contains(program.name) }
    }
    
    var snapshot = NSDiffableDataSourceSnapshot<ProgramListSection, Program>()
    snapshot.appendSections([.programs])
    snapshot.appendItems(data, toSection: .programs)
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

//MARK: - UISearchBarDelegate

extension ProgramViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    self.searchText = searchText.isEmpty ? nil : searchText
    applySnapshot()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.resignFirstResponder()
    applySnapshot()
  }
}

//MARK: - Favorites

extension ProgramViewController {
  private func toggleFavorite(program: Program) {
    if favoritePrograms.contains(program.name) {
      favoritePrograms.removeAll{$0 == program.name}
    } else {
      favoritePrograms.append(program.name)
    }
    saveFavoritePrograms()
    applySnapshot()
  }
  
  @objc private func showFavoritePrograms() {
    isShowingFavorites.toggle()
    applySnapshot()
    configureFavoriteButton()
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

extension ProgramViewController {
  private func saveFavoritePrograms() {
    storage.set(favoritePrograms, forKey: .favoritePrograms)
  }
  
  private func loadFavoritePrograms() {
    favoritePrograms = storage.array(forKey: .favoritePrograms)  ?? []
  }
}
