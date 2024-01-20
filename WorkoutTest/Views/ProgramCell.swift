//
//  ProgramCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit

class ProgramCell: UITableViewCell {
  
  let difficultyLabel: UILabel = {
    let difficulty = UILabel()
    difficulty.font = UIFont.systemFont(ofSize: 15)
    difficulty.textColor = .orange
    return difficulty
  }()
  
  let nameLabel: UILabel = {
    let name = UILabel()
    name.font = UIFont.systemFont(ofSize: 20)
    name.textColor = .black
    return name
  }()
  
  var descriprionLabel: UILabel = {
    let description = UILabel()
    description.font = UIFont.systemFont(ofSize: 15)
    description.textColor = .gray
    return description
  }()
  
  let programType: UILabel = {
    let type = UILabel()
    type.font = UIFont.systemFont(ofSize: 15)
    type.textColor = .red
    return type
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupCell() {
    [difficultyLabel, nameLabel, descriprionLabel,programType].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    descriprionLabel.numberOfLines = 0
    
    NSLayoutConstraint.activate([
      difficultyLabel.topAnchor.constraint(equalTo: descriprionLabel.bottomAnchor, constant: 5),
      difficultyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      difficultyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      difficultyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
      
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
      
      descriprionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
      descriprionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
      descriprionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
      
      programType.topAnchor.constraint(equalTo: descriprionLabel.bottomAnchor, constant: 5),
      programType.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      programType.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
    ])
    
  }
  func setupCell(programCell: Program) {
    self.nameLabel.text = programCell.name
    self.descriprionLabel.text = programCell.descriptionText
    self.programType.text = programCell.programType
    self.difficultyLabel.text = " Difficulty \(programCell.difficulty)"
  }
}
