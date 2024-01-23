//
//  DescriptCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 23.01.2024.
//

import UIKit

class DescriptCell: UITableViewCell {
  
  var descript: UILabel = {
    var description = UILabel()
    description.font = UIFont.systemFont(ofSize: 18)
    description.textColor = .blue
    description.numberOfLines = 0
    return description
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    layoutCell()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func layoutCell() {
    contentView.addSubview(descript)
    descript.translatesAutoresizingMaskIntoConstraints = false
    
    
    NSLayoutConstraint.activate([
      descript.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      descript.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      descript.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      descript.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
    ])
    
  }
  
  func setupCellDescript(descriptCell: Program) {
    self.descript.text = descriptCell.descriptionText
  }
}
