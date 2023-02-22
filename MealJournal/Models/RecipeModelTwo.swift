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
//saved from another user
struct SavedRecipeItem: Identifiable, Hashable{
    let id: String
    let userName: String // userName of user who created recipe
    var recipeTitle, recipePrepTime, recipeImage, createdAt: String
    var recipeCaloriesMacro, recipeFatMacro, recipeCarbMacro, recipeProteinMacro: Int
    var directions: [String]
    var ingredientItem: [String: String]
    var userUID: String
}

struct RecipeModel{
    var recipes: [RecipeItem]
}
