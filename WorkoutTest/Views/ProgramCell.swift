//
//  ProgramCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit
import SnapKit

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
    description.numberOfLines = 0
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
    layoutCell()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func layoutCell() {
    [difficultyLabel, nameLabel, descriprionLabel, programType].forEach {
      contentView.addSubview($0)
    }
    
    difficultyLabel.snp.makeConstraints {
      $0.top.equalTo(descriprionLabel.snp.bottom).offset(5)
      $0.leading.equalTo(contentView.snp.leading).offset(10)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-8)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(contentView.snp.top).offset(5)
      $0.left.equalTo(contentView.snp.left).offset(10)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-8)
    }
    
    descriprionLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(5)
      $0.leading.equalTo(contentView.snp.leading).offset(10)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-8)
    }
    
    programType.snp.makeConstraints {
      $0.top.equalTo(descriprionLabel.snp.bottom).offset(5)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-8)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
    }
  }
  
  func setupProgramCell(programCell: Program) {
    self.nameLabel.text = programCell.name
    self.descriprionLabel.text = programCell.descriptionText
    self.programType.text = programCell.programType
    self.difficultyLabel.text = " Difficulty \(programCell.difficulty)"
  }
}
