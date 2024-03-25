//
//  ProgramCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit
import SnapKit

class ProgramCell: UICollectionViewCell {
  
  var favoriteButtonAction:(() -> Void)?
  
  lazy var favoriteButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action:#selector(favoriteButtonTapped),for:.touchUpInside)
    return button
  }()
  
  let difficultyLabel: UILabel = {
    let difficulty = UILabel()
    difficulty.font = UIFont.systemFont(ofSize: 13)
    difficulty.textColor = .orange
    return difficulty
  }()
  
  let nameLabel: UILabel = {
    let name = UILabel()
    name.font = UIFont.systemFont(ofSize: 20)
    name.textColor = .yellow
    name.numberOfLines = 0
    return name
  }()
  
  var descriprionLabel: UILabel = {
    let description = UILabel()
    description.font = UIFont.systemFont(ofSize: 15)
    description.textColor = .white
    description.numberOfLines = 0
    return description
  }()
  
  let programType: UILabel = {
    let type = UILabel()
    type.font = UIFont.systemFont(ofSize: 13)
    type.textColor = .red
    return type
  }()
  
  let programImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    layoutCell()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func favoriteButtonTapped() {
    favoriteButtonAction?()
    favoriteButton.tintColor = favoriteButton.tintColor == .white ? .red: .white
  }
  
  
  private func layoutCell() {
    [programImageView, difficultyLabel, nameLabel, descriprionLabel, programType, favoriteButton].forEach {
      contentView.addSubview($0)
    }
    
    difficultyLabel.snp.makeConstraints {
      $0.top.equalTo(descriprionLabel.snp.bottom).offset(5)
      $0.leading.equalTo(contentView.snp.leading).offset(2)
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
      $0.trailing.equalTo(contentView.snp.trailing).offset(-2)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
    }
    
    programImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    favoriteButton.snp.makeConstraints {
      $0.top.equalTo(contentView.snp.top).offset(5)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
    }
  }
  
  func setupProgramCell(programCell: Program) {
    self.nameLabel.text = programCell.name
    self.descriprionLabel.text = programCell.descriptionText
    self.programType.text = programCell.programType
    self.difficultyLabel.text = " Difficulty \(programCell.difficulty)"
    self.programImageView.image = UIImage.init(named: "image1")
  }
}
