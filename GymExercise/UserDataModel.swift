//
//  UserData.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-16.
//

struct UserData: Codable {
    let _id:String
    let days:String?
    let time:String?
    let userName: String
    let fullName: String
    let email: String
    let password: String?
    let height:String?
    let weight:String?
    let age:String?
    let fitnessGoal:String?
    let __v: Int
    
    enum CodingKeys: String, CodingKey {
        case _id
        case userName
        case fullName
        case email
        case password
        case height
        case weight
        case age
        case fitnessGoal
        case days
        case time
        case __v
    }
}

