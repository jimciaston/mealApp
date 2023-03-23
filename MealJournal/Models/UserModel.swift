//
//  UserModel.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/1/22.
//

import Foundation

class UserModel: ObservableObject, Identifiable {
    var id: String = UUID().uuidString
    @Published var name: String
    @Published var userBio: String
    var uid, gender, height, weight, agenda, profilePictureURL, userSocialLink: String
    @Published var exercisePreferences: [String]
    
    init(data: [String: Any]){
        self.uid = data["uid"] as? String ?? "Unavailable"
        self.name = data["name"] as? String ?? "Unavailable"
        self.gender = data["gender"] as? String ?? "Unavailable"
        self.height = data["height"] as? String ?? "Unavailable"
        self.weight = data["weight"] as? String ?? "Unavailable"
        self.userBio = data["userBio"] as? String ?? "No Bio entered"
        self.agenda = data["agenda"] as? String ?? "Unavailable"
        self.profilePictureURL = data ["profilePicture"] as? String ?? "Unavailable"
        self.exercisePreferences = data ["exercisePreferences"] as? [String] ?? ["Unavailable"]
        self.userSocialLink = data ["userSocialLink"] as? String ?? "Instagram link not entered"
    }
}

struct privateUserModel {
    var email: String
    
    init(data: [String: Any]){
        self.email = data["email"] as? String ?? "Unavailable"
    }
}
