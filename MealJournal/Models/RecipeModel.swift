//
//  RecipeModel.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/6/22.
//

import Foundation
import SwiftUI

//class that holds info, saves to firestore
class Recipe: ObservableObject, Identifiable {
    let id = UUID().uuidString
    @Published var recipeImage:      String = ""
    @Published var recipeTitle:      String = ""
    @Published var recipePrepTime:   String = ""
    @Published var ingredients:      [Ingredients] = []
    @Published var directions:       [Directions]  = []
    @Published var isCompleted =     false
    @Published var recipeCaloriesMacro:    Int = 0
    @Published var recipeFatMacro:    Int = 0
    @Published var recipeCarbMacro:    Int = 0
    @Published var recipeProteinMacro:  Int = 0
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
