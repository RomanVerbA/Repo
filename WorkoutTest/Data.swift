//
//  Data.swift
//  WorkoutTest
//
//  Created by Roman Verba on 20.01.2024.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable, Hashable {
  var programs: [Program]
}

// MARK: - Program
struct Program: Codable, Hashable {
  let difficulty: Int
  let name, descriptionText, programType: String
  let days: [Day]
}

// MARK: - Day
struct Day: Codable, Hashable {
  let weekDayNum: Int
  let exercises: [Exercise]
}

// MARK: - Exercise
struct Exercise: Codable, Hashable{
  let countingNumber: Int
  let imageName, name: String
  let exDescription: ExDescription
  let setOfMuscle: [SetOfMuscle]
  let sets: [Set]
}

// MARK: - ExDescription
struct ExDescription: Codable, Hashable {
  let gifImageName: String
  let musclesWorked: [String]
  let primaryType, technique: String
  let youtubeURL: String
}

// MARK: - SetOfMuscle
struct SetOfMuscle: Codable, Hashable{
  let nameOfMuscleSet: String
}

// MARK: - Set
struct Set: Codable, Hashable {
  let countingNumber, numberOfReps: Int
}

