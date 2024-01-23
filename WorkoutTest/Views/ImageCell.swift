//
//  ImageCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 23.01.2024.
//

import UIKit

class ImageCell: UITableViewCell {
  
  var myImageView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    images()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func images() {
    contentView.addSubview(myImageView)
    myImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      myImageView.heightAnchor.constraint(equalToConstant: 350)
    ])
  }
  
  func setupImage(with imageName: String) {
    myImageView.image = UIImage(named: imageName)
  }
}
