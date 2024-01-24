//
//  DescriptCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 23.01.2024.
//

import UIKit

class DescriptCell: UITableViewCell {
  
  var descriptionText: UILabel = {
    var description = UILabel()
    description.font = UIFont.systemFont(ofSize: 18)
    description.textColor = .blue
    description.numberOfLines = 0
    return description
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    setupLayoutCell()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupLayoutCell() {
    contentView.addSubview(descriptionText)
    descriptionText.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      descriptionText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      descriptionText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      descriptionText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      descriptionText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
    ])
    
  }
}

