//
//  RecipeLogic.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/23/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
class RecipeLogic: ObservableObject {
    @Published var recipes = [RecipeItem]()
   
    init(){
     grabRecipes()
    }
    
   func grabRecipes(){
       //grab current user
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userRecipes")
            .addSnapshotListener { (snapshot, err) in
                guard let documents = snapshot?.documents else{
                    print("no documents present")
                    return
                }
                self.recipes = documents.map { (querySnapshot) -> RecipeItem in
                    let data = querySnapshot.data()
                    let recipeTitle = data ["recipeTitle"] as? String ?? ""
                    let recipePrepTime = data ["recipePrepTime"] as? String ?? ""
                    let recipeImage = data ["recipeImage"] as? String ?? ""
                    let createdAt = data ["createdAt"] as? String ?? ""
                    let ingredients = data ["ingredientItem"] as? [String] ?? [""]
                    let directions = data ["directions"] as? [String] ?? [""]
                    let recipe = RecipeItem(recipeTitle:recipeTitle , recipePrepTime: recipePrepTime, recipeImage: recipeImage, createdAt: createdAt, directions: directions, ingredientItem: ingredients)
                    return recipe
                }
            }
        }
    }

