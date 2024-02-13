//
//  TimerView.swift
//  WorkoutTest
//
//  Created by Roman Verba on 07.02.2024.
//

import UIKit

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
    timerLabel.text = "10"
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
    image = UIImageView.init(image: UIImage(named: "1"))
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
    
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    timerLabel.translatesAutoresizingMaskIntoConstraints = false
    workoutStartLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    exerciseImage.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      textLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      
      timerLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
      timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      
      workoutStartLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 10),
      workoutStartLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      workoutStartLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      
      nameLabel.topAnchor.constraint(equalTo: workoutStartLabel.bottomAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      
      exerciseImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      exerciseImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      exerciseImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      exerciseImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
    ])
  }
}
