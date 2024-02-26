//
//  ExerciseController.swift
//  WorkoutTest
//
//  Created by Roman Verba on 07.02.2024.
//
import SnapKit
import UIKit

class ExerciseController: UIViewController {
  
  private var timerView: TimerView?
  private var secondRemaining = 10
  private  var timer: Timer?
  private var currentExerciseIndex = 0
  
  private var nextButtonBottom: Constraint?
  private var backButtonBottom: Constraint?
  
  var exercises: [Exercise] = [] {
    didSet {
      nameExercise.text = exercises.first?.name
      descriptionLabel.text = exercises.first?.exDescription.technique
    }
  }
  
  private lazy var myScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
  private let myImage: UIImageView = {
    var myImage = UIImageView()
    myImage.backgroundColor = .white
    myImage.image = UIImage(named: "1")
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
    description.textColor = .darkGray
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
    view.addSubview(backButton)
    view.addSubview(nextButton)
    myScrollView.addSubview(myImage)
    myScrollView.addSubview(nameExercise)
    myScrollView.addSubview(descriptionLabel)
    
    myScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 250, right: 0)
    
    myScrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    myImage.snp.makeConstraints {
      $0.top.equalTo(myScrollView.snp.top).offset(10)
      $0.leading.equalTo(myScrollView.frameLayoutGuide).offset(10)
      $0.trailing.equalTo(myScrollView.frameLayoutGuide).offset(-10)
      $0.height.equalTo(350)
    }
    
    nameExercise.snp.makeConstraints {
      $0.top.equalTo(myImage.snp.bottom).offset(10)
      $0.leading.equalTo(myScrollView.frameLayoutGuide).offset(10)
      $0.trailing.equalTo(myScrollView.frameLayoutGuide).offset(-10)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(nameExercise.snp.bottom).offset(10)
      $0.leading.equalTo(myScrollView.frameLayoutGuide).offset(10)
      $0.trailing.equalTo(myScrollView.frameLayoutGuide).offset(-10)
      $0.bottom.equalTo(myScrollView.snp.bottom)
    }
    
    nextButton.snp.makeConstraints {
      $0.leading.equalTo(backButton.snp.trailing).offset(10)
      nextButtonBottom = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(100).constraint
      $0.trailing.equalToSuperview().offset(-10)
      $0.height.equalTo(50)
    }
    
    backButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(10)
      backButtonBottom = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(100).constraint
      $0.width.equalTo(100)
      $0.height.equalTo(50)
    }
  }
  
  // MARK: - setupTimerView
  
  private func setupTimerView() {
    timerView = TimerView()
    guard let timerView = timerView else { return }
    
    view.addSubview(timerView)
    timerView.nameLabel.text = exercises.first?.name
    timerView.timerLabel.text = "\(secondRemaining)"
    
    timerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  // MARK: - startTimer
  
  private func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
  }
  
  @objc private func updateTimer() {
    secondRemaining -= 1
    timerView?.timerLabel.text = "\(secondRemaining)"
    
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
    UIView.animate(withDuration: 1, animations: {
      
      self.nextButtonBottom?.update(offset: -10)
      self.backButtonBottom?.update(offset: -10)
      self.view.layoutIfNeeded()
      self.timerView?.alpha = 0
    }, completion: { finished in
      if finished {
        self.timerView?.removeFromSuperview()
        self.timerView = nil
      }
    })
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
    
    guard currentExerciseIndex < exercises.count - 1 else {
      dismiss(animated: true, completion: nil)
      return
    }
    
    currentExerciseIndex += 1
    
    let exercise = exercises[currentExerciseIndex]
    
    UIView.transition(with: myScrollView, duration: 0.4, options: .transitionCrossDissolve, animations: {
      
      self.nameExercise.text = exercise.name
      self.descriptionLabel.text = exercise.exDescription.technique
      self.myScrollView.setContentOffset(.zero, animated: false)
      
    }, completion: nil)
  }
}

