//
//  SaveCustomFoodItem.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/27/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class SaveCustomFoodItem: ObservableObject {
   // @Published var recipes = [RecipeItem]()
    @State var saveSuccess = false
    //save recipes when edited
    func saveFoodItem(foodName: String,calories: Int ,protein: Int, fat: Int, carbs: Int, foodItemID: UUID){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userCustomFoodItems")
            .document(foodItemID.uuidString)
            .setData([
                "foodName" : foodName,
                "calories" : calories,
                "protein": protein,
                "fat" : fat,
                "carbs": carbs
        ], merge: true)
      
       
    }
    
    
    //save recipeTitle, Cook Time and recipe macros
func saveDashHeaders(recipeTitle: String, recipePrepTime: String, recipeFatMacro: Int, recipeCarbMacro: Int, recipeProteinMacro: Int, currentRecipe: String){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userRecipes")
            .whereField("recipeID", isEqualTo: currentRecipe)
            .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            FirebaseManager.shared.firestore
                                .collection("users")
                                .document(uid)
                                .collection("userRecipes")
                                .document(document.documentID)
                                .updateData([
                                    "recipeTitle" : recipeTitle,
                                    "recipePrepTime": recipePrepTime,
                                    "recipeFatMacro" : recipeFatMacro,
                                    "recipeCarbMacro": recipeCarbMacro,
                                    "recipeProteinMacro": recipeProteinMacro ]
                                )
                                    
                            print("Updated macros Recipe")
                        }
                    }
                }
            }
    //update image to database
    func updateRecipeImage(recipeImage: String, currentRecipe: String){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userRecipes")
            .whereField("recipeID", isEqualTo: currentRecipe)
            .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            FirebaseManager.shared.firestore
                                .collection("users")
                                .document(uid)
                                .collection("userRecipes")
                                .document(document.documentID)
                                .updateData(["recipeImage": recipeImage ])
                            print("Updated Image for Recipe")
                        }
                    }
                }
            }
        }
