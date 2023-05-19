//
//  FitnessPlanDataModel.swift
//  GymExercise
//
//  Created by Developer on 2023-05-19.


struct FitnessPlan: Decodable {
    let type: String
    let des: String
    let nutrition: String
    let exercise: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case des
        case nutrition
        case exercise

    }
}


