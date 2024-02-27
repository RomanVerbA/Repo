//
//  ImageCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 23.01.2024.
//

import UIKit
import SnapKit

class ImageCell: UITableViewCell {
  
  let myImageView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupLayout() {
    contentView.addSubview(myImageView)
    
    myImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.height.equalTo(350).priority(750)
    }
  }
  
  func setupImageCell(with imageName: String) {
    myImageView.image = UIImage(named: imageName)
  }
}
