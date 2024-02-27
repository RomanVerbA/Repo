//
//  DescriptCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 23.01.2024.
//

import UIKit
import SnapKit

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
    
    descriptionText.snp.makeConstraints {
      $0.top.equalToSuperview().offset(5)
      $0.leading.equalTo(contentView.snp.leading).offset(10)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-5)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
    }
  }
}

