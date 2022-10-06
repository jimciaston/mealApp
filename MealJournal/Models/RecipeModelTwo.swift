//
//  RecipeModelTwo.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/23/22.
//

import Foundation
import FirebaseFirestore

struct RecipeItem: Identifiable, Hashable{
    let id: String
    var recipeTitle, recipePrepTime, recipeImage, createdAt: String
    var recipeCaloriesMacro, recipeFatMacro, recipeCarbMacro, recipeProteinMacro: Int
    var directions: [String]
    var ingredientItem: [String: String]
}

struct RecipeModel{
    var recipes: [RecipeItem]
}
