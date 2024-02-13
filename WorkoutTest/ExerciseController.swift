//
//  ExerciseController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 07.02.2024.
//

import UIKit

class ExerciseController: UIViewController {
  
  var timerView = TimerView()
  var secondRemaining = 10
  var timer: Timer?
  
  var exercise: Exercise? {
    didSet {
      nameExercise.text = exercise?.name
      descriptionLabel.text = exercise?.exDescription.technique
      timerView.nameLabel.text = exercise?.name
    }
  }
  
  
  private let myimage: UIImageView = {
    var myimage = UIImageView()
    myimage.backgroundColor = .white
    myimage = UIImageView.init(image: UIImage(named: "1"))
    return myimage
  }()
  
  private let nameExercise: UILabel = {
    let name = UILabel()
    name.font = .systemFont(ofSize: 20)
    name.numberOfLines = 0
    name.textAlignment = .center
    name.textColor = .blue
    return name
  }()
  
  private let descriptionLabel: UILabel = {
    let description = UILabel()
    description.font = .systemFont(ofSize: 18)
    description.numberOfLines = 0
    description.textAlignment = .center
    return description
  }()
  
  private lazy var backButton: UIButton = {
    let backButton = UIButton()
    backButton.setTitle("back", for: .normal)
    backButton.backgroundColor = .cyan
    backButton.addTarget(self, action: #selector(actionBackButton), for: .touchUpInside)
    return backButton
  }()
  
  private let nextButton: UIButton = {
    let nextButton = UIButton()
    nextButton.setTitle("tap when done", for: .normal)
    nextButton.backgroundColor = .cyan
    return nextButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView()
    setupTimerView()
    startTimer()
    
  }
  // MARK: - setupView
  
  private func setupView() {
    
    view.addSubview(myimage)
    view.addSubview(nameExercise)
    view.addSubview(descriptionLabel)
    view.addSubview(backButton)
    view.addSubview(nextButton)
    
    myimage.translatesAutoresizingMaskIntoConstraints = false
    nameExercise.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    backButton.translatesAutoresizingMaskIntoConstraints = false
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      myimage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      myimage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      myimage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      myimage.heightAnchor.constraint(equalToConstant: 350),
      
      nameExercise.topAnchor.constraint(equalTo: myimage.bottomAnchor, constant: 10),
      nameExercise.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      nameExercise.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      
      
      descriptionLabel.topAnchor.constraint(equalTo: nameExercise.bottomAnchor, constant: 10),
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      
      backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      backButton.widthAnchor.constraint(equalToConstant: 100),
      backButton.heightAnchor.constraint(equalToConstant: 50),
      
      nextButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
      nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      nextButton.heightAnchor.constraint(equalToConstant: 50),
    ])
    
  }
  // MARK: - setupTimerView
  
  private func setupTimerView() {
    
    view.addSubview(timerView)
    timerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      timerView.topAnchor.constraint(equalTo: view.topAnchor),
      timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      timerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
  }
  
  // MARK: - startTimer
  
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
  }
  
  @objc private func updateTimer() {
    secondRemaining -= 1
    timerView.timerLabel.text = "\(secondRemaining)"
    
    if secondRemaining == 0 {
      stopTimer()
      removeTimerView()
    }
  }
  
  func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  func removeTimerView() {
    timerView.removeFromSuperview()
  }
  
  // MARK: - backButton + Alert
  
  @objc private func actionBackButton() {
    let alertController = UIAlertController(title: "Are you sure you want to quit?", message: nil, preferredStyle: .alert)
    
    alertController.addAction(UIAlertAction(title: "Yes", style: .destructive) { _ in
      self.dismiss(animated: true, completion: nil)
    })
    
    alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    present(alertController, animated: true, completion: nil)
  }
}
