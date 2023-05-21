//
//  UserFitnessDataModel.swift
//  GymExercise
//
//  Created by Developer on 2023-05-20.
//

struct UserFitness: Decodable {
    let _id: String
    let userName: String
    let type:String
    
    enum CodingKeys: String, CodingKey {
        case _id
        case userName
        case type
    }
}

