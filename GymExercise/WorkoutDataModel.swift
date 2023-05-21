//
//  WorkoutDataModel.swift
//  GymExercise
//
//  Created by Developer on 2023-05-20.
//

import Foundation

struct Workout {
    let name: String
    let imageName: String
    let videoUrl: URL
    let reps: Int
    let count: Int
    let time: Int // in seconds
    let weight: Int // in pounds
}

