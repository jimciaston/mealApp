//
//  UserModel.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/1/22.
//

import Foundation

struct UserModel {
    var uid, email, name, gender, height, weight, agenda, profilePictureURL: String
    
    init(data: [String: Any]){
        self.uid = data["uid"] as? String ?? "Unavailable"
        self.email = data["email"] as? String ?? "Unavailable"
        self.name = data["name"] as? String ?? "Unavailable"
        self.gender = data["gender"] as? String ?? "Unavailable"
        self.height = data["height"] as? String ?? "Unavailable"
        self.weight = data["weight"] as? String ?? "Unavailable"
        self.agenda = data["agenda"] as? String ?? "Unavailable"
        self.profilePictureURL = data ["profilePicture"] as? String ?? "Unavailable"
    }
}
