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
  var currentExerciseIndex = 0
  
  var exercise: [Exercise] = [] {
    didSet {
      nameExercise.text = exercise.first?.name
      descriptionLabel.text = exercise.first?.exDescription.technique
      timerView.nameLabel.text = exercise.first?.name
    }
  }
  
  
  lazy var myScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .red
    scrollView.frame = view.bounds
    scrollView.contentSize = contentCize
    return scrollView
  }()
  
  var contentCize: CGSize {
    CGSize(width: view.frame.width, height: view.frame.height + 400)
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
  
  private lazy var nextButton: UIButton = {
    let nextButton = UIButton()
    nextButton.setTitle("tap when done", for: .normal)
    nextButton.backgroundColor = .cyan
    nextButton.addTarget(self, action: #selector(goToNextExcercise), for: .touchUpInside)
    return nextButton
  }()
 
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
    setupView()
    setupTimerView()
    startTimer()
    
  }
  // MARK: - setupView
  
  private func setupView() {
    view.addSubview(myScrollView)
    myScrollView.addSubview(myimage)
    myScrollView.addSubview(nameExercise)
    myScrollView.addSubview(descriptionLabel)
    myScrollView.addSubview(backButton)
    myScrollView.addSubview(nextButton)
  
    
    myScrollView.translatesAutoresizingMaskIntoConstraints = false
    myimage.translatesAutoresizingMaskIntoConstraints = false
    nameExercise.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    backButton.translatesAutoresizingMaskIntoConstraints = false
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      myScrollView.topAnchor.constraint(equalTo: view.topAnchor),
      myScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      myScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      myScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
      myScrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
      
      myimage.topAnchor.constraint(equalTo: myScrollView.topAnchor, constant: 10),
      myimage.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor, constant: 10),
      myimage.trailingAnchor.constraint(equalTo: myScrollView.trailingAnchor, constant: -10),
      myimage.heightAnchor.constraint(equalToConstant: 350),
      
      nameExercise.topAnchor.constraint(equalTo: myimage.bottomAnchor, constant: 10),
      nameExercise.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor, constant: 10),
      nameExercise.trailingAnchor.constraint(equalTo: myScrollView.trailingAnchor, constant: -10),
      
      
      descriptionLabel.topAnchor.constraint(equalTo: nameExercise.bottomAnchor, constant: 10),
      descriptionLabel.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor, constant: 10),
      descriptionLabel.trailingAnchor.constraint(equalTo: myScrollView.trailingAnchor, constant: -10),
      descriptionLabel.bottomAnchor.constraint(equalTo: myScrollView.bottomAnchor),
      
      backButton.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor, constant: 10),
      backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
      backButton.widthAnchor.constraint(equalToConstant: 100),
      backButton.heightAnchor.constraint(equalToConstant: 50),
      
      nextButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
      nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
      nextButton.trailingAnchor.constraint(equalTo: myScrollView.trailingAnchor, constant: -10),
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
  
  @objc private func goToNextExcercise() {
    guard currentExerciseIndex < exercise.count - 1 else {
      dismiss(animated: true, completion: nil)
      return
    }
    
    currentExerciseIndex += 1
    
    let exercis = exercise[currentExerciseIndex]
    nameExercise.text = exercis.name
    descriptionLabel.text = exercis.exDescription.technique
    
  
  }
}
