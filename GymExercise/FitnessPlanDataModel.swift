//
//  FitnessPlanDataModel.swift
//  GymExercise
//
//  Created by Developer on 2023-05-19.


struct FitnessPlan: Decodable {
    let type: String
    let Protein: String
    let Carbohydrates: String
    let Fat: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case Protein
        case Carbohydrates
        case Fat

    }
}


