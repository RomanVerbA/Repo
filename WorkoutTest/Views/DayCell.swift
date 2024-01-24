//
//  DayCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit

class DayCell: UITableViewCell {
  
  let daysOfWeek = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
  
  let weekDeyNum: UILabel = {
    let deyNum = UILabel()
    deyNum.font = UIFont.systemFont(ofSize: 18)
    deyNum.textColor = .red
    return deyNum
  }()
  
  let exercisesCount: UILabel = {
    let count = UILabel()
    count.font = UIFont.systemFont(ofSize: 18)
    count.textColor = .green
    return count
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layoutCell()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func layoutCell() {
    contentView.addSubview(weekDeyNum)
    contentView.addSubview(exercisesCount)
    weekDeyNum.translatesAutoresizingMaskIntoConstraints = false
    exercisesCount.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      weekDeyNum.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      weekDeyNum.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      weekDeyNum.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
      
      exercisesCount.topAnchor.constraint(equalTo: contentView.topAnchor),
      exercisesCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      exercisesCount.leadingAnchor.constraint(equalTo: weekDeyNum.trailingAnchor, constant: 10),
    ])
  }
  
  func setupDayCell(dayCell: Day) {
    let dayIndex = dayCell.weekDayNum
    if dayIndex >= 0 && dayIndex < daysOfWeek.count {
      let dayName = daysOfWeek[dayIndex]
      weekDeyNum.text = dayName
    } else {
      weekDeyNum.text = "         sfsadasdasd "
    }
    self.exercisesCount.text = "Exercises \(dayCell.exercises.count)"
  }
}
