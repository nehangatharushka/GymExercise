//
//  UserData.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-16.
//

struct UserData: Codable {
    let userName: String
    let fullName: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case userName
        case fullName
        case email
    }
}

