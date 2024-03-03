//
//  TimerView.swift
//  WorkoutTest
//
//  Created by Roman Verba on 07.02.2024.
//

import UIKit
import SnapKit

class TimerView: UIView {
  
  var exercise: Exercise?
  
  private let textLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.font = UIFont.systemFont(ofSize: 50)
    textLabel.text = "GET READY!"
    textLabel.textAlignment = .center
    return textLabel
  }()
  
  let timerLabel: UILabel = {
    let timerLabel = UILabel()
    timerLabel.font = UIFont.systemFont(ofSize: 150)
    timerLabel.textColor = .cyan
    timerLabel.textAlignment = .center
    return timerLabel
  }()
  
  private let workoutStartLabel: UILabel = {
    let workoutStart = UILabel()
    workoutStart.font = UIFont.systemFont(ofSize: 22)
    workoutStart.textColor = .lightGray
    workoutStart.textAlignment = .center
    workoutStart.text = "WORKOUT STARTS WITH"
    return workoutStart
  }()
  
  let nameLabel: UILabel = {
    let name = UILabel()
    name.font = UIFont.systemFont(ofSize: 32)
    name.textAlignment = .center
    name.numberOfLines = 0
    return name
  }()
  
  private let exerciseImage: UIImageView = {
    var image = UIImageView()
    image.image = UIImage(named: "1")
    return image
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupTimerView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupTimerView() {
    
    backgroundColor = .white
    
    addSubview(textLabel)
    addSubview(timerLabel)
    addSubview(workoutStartLabel)
    addSubview(nameLabel)
    addSubview(exerciseImage)
    
    textLabel.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
    }
    
    timerLabel.snp.makeConstraints {
      $0.top.equalTo(textLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
    }
    
    workoutStartLabel.snp.makeConstraints {
      $0.top.equalTo(timerLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(workoutStartLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
    }
    
    exerciseImage.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
    }
  }
}

