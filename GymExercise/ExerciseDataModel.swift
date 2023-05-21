//
//  ExerciseDataModel.swift
//  GymExercise
//
//  Created by Developer on 2023-05-20.
//

struct Exercise: Codable {
    let _id:String
    let userName:String?
    let name: String
    let image: String
    let url:String?
    let time:String?
    let reps:String?
    let set:String?
    let weight:String?
    let type:String?
    let date:String?
    let completed:String?
    
    enum CodingKeys: String, CodingKey {
        case _id
        case userName
        case name
        case image
        case url
        case time
        case reps
        case set
        case weight
        case type
        case date
        case completed
    }
}
