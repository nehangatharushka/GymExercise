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
    // Include other properties as per the JSON response
    
    enum CodingKeys: String, CodingKey {
        case userName
        case fullName
        case email
        // Map other keys to properties if necessary
    }
}

