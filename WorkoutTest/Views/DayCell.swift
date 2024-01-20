//
//  DayCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit

class DayCell: UITableViewCell {
  
  let daysOfWeek = ["Monday","Tuesday","Wednesday","Thurstay","Friday","Saturday","Sunday"]
  
  let weekDeyNum: UILabel = {
    let deyNum = UILabel()
    deyNum.font = UIFont.systemFont(ofSize: 18)
    deyNum.textColor = .red
    return deyNum
  }()
  
  let excercisesCount: UILabel = {
    let count = UILabel()
    count.font = UIFont.systemFont(ofSize: 18)
    count.textColor = .green
    return count
  }()
  
  let imagerogram: UIImageView = {
    var image = UIImageView()
    return image
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    layoutCell()
    
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func layoutCell() {
    contentView.addSubview(weekDeyNum)
    contentView.addSubview(excercisesCount)
    weekDeyNum.translatesAutoresizingMaskIntoConstraints = false
    excercisesCount.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      weekDeyNum.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      weekDeyNum.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      weekDeyNum.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
      
      excercisesCount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      excercisesCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      excercisesCount.leadingAnchor.constraint(equalTo: weekDeyNum.trailingAnchor, constant: 10),
      excercisesCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
    ])
    
  }
  
  func setupCell(dayCell: Day) {
    
    let dayIndex = dayCell.weekDayNum
    if dayIndex >= 0 && dayIndex < daysOfWeek.count {
      let dayName = daysOfWeek[dayIndex]
      weekDeyNum.text = dayName
    } else {
      weekDeyNum.text = ""
    }
    self.excercisesCount.text = "Excercises \(dayCell.exercises.count)"
  }
}
