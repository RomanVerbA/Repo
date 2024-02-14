//
//  ExerciseController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 07.02.2024.
//

import UIKit

class ExerciseController: UIViewController {
  
  private var timerView = TimerView()
  private var secondRemaining = 10
  var timer: Timer?
  var currentExerciseIndex = 0
  
  var exercise: [Exercise] = [] {
    didSet {
      nameExercise.text = exercise.first?.name
      descriptionLabel.text = exercise.first?.exDescription.technique
      timerView.nameLabel.text = exercise.first?.name
    }
  }
  
  
  private lazy var myScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .white
    scrollView.alwaysBounceVertical = true
    return scrollView
  }()
  
  private let myImage: UIImageView = {
    var myImage = UIImageView()
    myImage.backgroundColor = .white
    myImage = UIImageView.init(image: UIImage(named: "1"))
    return myImage
  }()
  
  private let nameExercise: UILabel = {
    let name = UILabel()
    name.font = .systemFont(ofSize: 30)
    name.numberOfLines = 0
    name.textAlignment = .center
    return name
  }()
  
  private let descriptionLabel: UILabel = {
    let description = UILabel()
    description.font = .systemFont(ofSize: 21)
    description.numberOfLines = 0
    description.textAlignment = .center
    description.textColor = .lightGray
    return description
  }()
  
  private lazy var backButton: UIButton = {
    let backButton = UIButton()
    backButton.setTitle("back", for: .normal)
    backButton.backgroundColor = .red
    backButton.addTarget(self, action: #selector(actionBackButton), for: .touchUpInside)
    return backButton
  }()
  
  private lazy var nextButton: UIButton = {
    let nextButton = UIButton()
    nextButton.setTitle("tap when done", for: .normal)
    nextButton.backgroundColor = .green
    nextButton.addTarget(self, action: #selector(goToNextExcercise), for: .touchUpInside)
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
    view.addSubview(myScrollView)
    myScrollView.addSubview(myImage)
    myScrollView.addSubview(nameExercise)
    myScrollView.addSubview(descriptionLabel)
    myScrollView.addSubview(backButton)
    myScrollView.addSubview(nextButton)
    
    myScrollView.translatesAutoresizingMaskIntoConstraints = false
    myImage.translatesAutoresizingMaskIntoConstraints = false
    nameExercise.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    backButton.translatesAutoresizingMaskIntoConstraints = false
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      myScrollView.topAnchor.constraint(equalTo: view.topAnchor),
      myScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      myScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      myImage.topAnchor.constraint(equalTo: myScrollView.contentLayoutGuide.topAnchor, constant: 10),
      myImage.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor, constant: 10),
      myImage.trailingAnchor.constraint(equalTo: myScrollView.frameLayoutGuide.trailingAnchor, constant: -10),
      myImage.heightAnchor.constraint(equalToConstant: 350),
      
      nameExercise.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: 10),
      nameExercise.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor, constant: 10),
      nameExercise.trailingAnchor.constraint(equalTo: myScrollView.frameLayoutGuide.trailingAnchor, constant: -10),
      
      
      descriptionLabel.topAnchor.constraint(equalTo: nameExercise.bottomAnchor, constant: 10),
      descriptionLabel.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor, constant: 10),
      descriptionLabel.trailingAnchor.constraint(equalTo: myScrollView.frameLayoutGuide.trailingAnchor, constant: -10),
      descriptionLabel.bottomAnchor.constraint(equalTo: myScrollView.contentLayoutGuide.bottomAnchor),
      
      backButton.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor, constant: 10),
      backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      backButton.widthAnchor.constraint(equalToConstant: 100),
      backButton.heightAnchor.constraint(equalToConstant: 50),
      
      nextButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
      nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      nextButton.trailingAnchor.constraint(equalTo: myScrollView.frameLayoutGuide.trailingAnchor, constant: -10),
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
  
  private func startTimer() {
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
  
  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  private func removeTimerView() {
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
  
  @objc private func goToNextExcercise() {
    
    guard currentExerciseIndex < exercise.count - 1 else {
      dismiss(animated: true, completion: nil)
      return
    }
    
    currentExerciseIndex += 1
    
    let exercis = exercise[currentExerciseIndex]
    nameExercise.text = exercis.name
    descriptionLabel.text = exercis.exDescription.technique
    
    myScrollView.setContentOffset(CGPoint.zero, animated: false)
  }
}
