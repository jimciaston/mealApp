//
//  UserModelFirestore.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/14/23.
//

import Foundation

class UserModelFirestore: Identifiable {
    let username: String
    let userID: String
    let userBio: String
    let profileImage: String
    let recipeInfo: [RecipeItem?]

    init(username: String, userID: String, userBio: String, profileImage: String, recipeInfo: [RecipeItem?]) {
        
        self.username = username
    
        self.userID = userID
        self.userBio = userBio
        self.profileImage = profileImage
        self.recipeInfo = recipeInfo
    }
}
