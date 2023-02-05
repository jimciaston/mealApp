//
//  RecipeLogicNonUser.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/17/23.
//

import Foundation
import SwiftUI

class RecipeLogicNonUser: ObservableObject {
    @Published var recipesNonUser = [RecipeItem]()
    
    @Environment (\.dismiss) var dismiss
   
    
    //delete recipe functionality
//    func deleteRecipe(selectedRecipeID: String){
//        FirebaseManager.shared.firestore
//            .collection("users")
//            .document(self.uidNonUser)
//            .collection("userRecipes")
//            .whereField("recipeID", isEqualTo: selectedRecipeID)
//            .getDocuments(){ snapshot, err in
//                if let err = err{
//                    print(err.localizedDescription)
//                }
//                else{
//                    for doc in snapshot!.documents {
//                            FirebaseManager.shared.firestore
//                                .collection("users")
//                                .document(self.uidNonUser)
//                                .collection("userRecipes")
//                                .document(doc.documentID).delete() { err in
//                                    if let err = err {
//                                            print("Error removing document: \(err)")
//                                        } else {
//                                            self.dismiss()
//                                            print("Document successfully removed!")
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
    
    //fetch recipes
    func grabRecipes(userUID: String) -> Int{
       //grab current user
        if userUID == ""{
            return 0
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(userUID)
            .collection("userRecipes")
            .addSnapshotListener { (snapshot, err) in
                guard let documents = snapshot?.documents else{
                    print("no documents present")
                    return
                }

                self.recipesNonUser = documents.map { (querySnapshot) -> RecipeItem in
                    let data = querySnapshot.data()
                    let recipeTitle = data ["recipeTitle"] as? String ?? ""
                    let recipePrepTime = data ["recipePrepTime"] as? String ?? ""
                    let recipeImage = data ["recipeImage"] as? String ?? ""
                    let createdAt = data ["createdAt"] as? String ?? ""
                    let ingredients = data ["ingredientItem"] as? [String: String] ?? ["": ""]
                    let directions = data ["directions"] as? [String] ?? [""]
                    let recipeID = data ["recipeID"] as? String ?? ""
                    let recipeCaloriesMacro = data ["recipeCaloriesMacro"] as? Int ?? 0
                    let recipeFatMacro = data ["recipeFatMacro"] as? Int ?? 0
                    let recipeCarbMacro = data ["recipeCarbMacro"] as? Int ?? 0
                    let recipeProteinMacro = data ["recipeProteinMacro"] as? Int ?? 0
                    let recipe = RecipeItem(id: recipeID, recipeTitle:recipeTitle , recipePrepTime: recipePrepTime, recipeImage: recipeImage, createdAt: createdAt, recipeCaloriesMacro: recipeCaloriesMacro, recipeFatMacro: recipeFatMacro, recipeCarbMacro:recipeCarbMacro, recipeProteinMacro: recipeProteinMacro, directions: directions, ingredientItem: ingredients)

                    return recipe

                }
            }
        return recipesNonUser.count
        }
    
    //save recipeTitle, Cook Time and recipe macros
    
}
