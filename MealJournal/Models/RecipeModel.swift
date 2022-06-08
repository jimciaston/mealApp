//
//  RecipeModel.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/6/22.
//

import Foundation
import SwiftUI


class Recipe {
    var RecipeTitle: String
    var RecipePrepTime: String
    var ingredient: [Ingredients] = []
    var directions: [Directions] = []
   
    init(RecipeTitle: String, RecipePrepTime: String){
        self.RecipeTitle = RecipeTitle
        self.RecipePrepTime = RecipePrepTime
    }
}

class Ingredients: Identifiable {
    var sizing: String
    var description: String
   
    init(sizing: String, description: String){
        self.sizing = sizing
        self.description = description
    }
}

class Directions: Identifiable{
    var description: String
    
    init (description: String){
        self.description = description
    }
}
