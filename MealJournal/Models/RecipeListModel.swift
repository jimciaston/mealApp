//
//  foodArray.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/16/22.
//
import SwiftUI

struct RecipeListModel {
    var image: String
    var name: String
    var id = UUID()
}
struct RecipeList{
    
    static let recipes = [
    RecipeListModel(image: "ExampleRecipePicture", name: "Fried Chicken", id: UUID()),
    RecipeListModel(image: "examplePicture2", name: "Big ole Donuts", id: UUID()),
    RecipeListModel(image: "examplePicture2", name: "Tuna Sandwich", id: UUID()),
    RecipeListModel(image: "examplePicture2", name: "Ham & Swiss", id: UUID()),
    ]
}
