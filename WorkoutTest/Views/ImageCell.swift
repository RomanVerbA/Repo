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
    myImageView.sd_setImage(with: URL(string:"https://www.dropbox.com/scl/fi/a4958tbqpaakffnllcp11/plank.gif?rlkey=kp0ik4ad9t5mj993v694rr0lm&dl=1"), placeholderImage: UIImage(named: "plank"))
  }
}
