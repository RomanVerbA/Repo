//
//  DayCell.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import UIKit
import SnapKit

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
    
    weekDeyNum.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).offset(5)
      make.leading.equalTo(contentView.snp.leading).offset(10)
      make.bottom.equalTo(contentView.snp.bottom).offset(-5)
    }
    
    exercisesCount.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).offset(5)
      make.trailing.equalTo(contentView.snp.trailing).offset(-10)
      make.leading.equalTo(weekDeyNum.snp.trailing).offset(10)
    }
  }
  
  func setupDayCell(dayCell: Day) {
    let dayIndex = dayCell.weekDayNum
    if dayIndex >= 0 && dayIndex < daysOfWeek.count {
      let dayName = daysOfWeek[dayIndex]
      weekDeyNum.text = dayName
    } else {
      weekDeyNum.text = ""
    }
    self.exercisesCount.text = "Exercises \(dayCell.exercises.count)"
  }
}
