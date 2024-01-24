//
//  Data.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
  let programs: [Program]
}

// MARK: - Program
struct Program: Codable {
  let difficulty: Int
  let name, descriptionText, programType: String
  let days: [Day]
}

// MARK: - Day
struct Day: Codable {
  let weekDayNum: Int
  let exercises: [Exercise]
}

// MARK: - Exercise
struct Exercise: Codable {
  let countingNumber: Int
  let imageName, name: String
  let exDescription: ExDescription
  let setOfMuscle: [SetOfMuscle]
  let sets: [Set]
}

// MARK: - ExDescription
struct ExDescription: Codable {
  let gifImageName: String
  let musclesWorked: [String]
  let primaryType, technique: String
  let youtubeURL: String
}

// MARK: - SetOfMuscle
struct SetOfMuscle: Codable {
  let nameOfMuscleSet: String
}

// MARK: - Set
struct Set: Codable {
  let countingNumber, numberOfReps: Int
}
