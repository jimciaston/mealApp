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
    @Published var savedRecipesNonUser = [SavedRecipeItem]()
    @Environment (\.dismiss) var dismiss
   

    
  //  delete recipe functionality
    func deleteRecipe(selectedRecipeID: String){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("savedUserRecipesNonUser")
            .whereField("recipeID", isEqualTo: selectedRecipeID)
            .getDocuments(){ snapshot, err in
                if let err = err{
                    print(err.localizedDescription)
                }
                else{
                    for doc in snapshot!.documents {
                            FirebaseManager.shared.firestore
                                .collection("users")
                                .document(uid)
                                .collection("savedUserRecipesNonUser")
                                .document(doc.documentID).delete() { err in
                                    if let err = err {
                                            print("Error removing document: \(err)")
                                        } else {
                                         //   self.dismiss()
                                            print("Document successfully removed!")
                                        }
                                    }
                                }
                            }
                        }
                    }
    
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
    //saving non user recipe
    func saveUserRecipe(userName: String, recipeImage: String, recipeTitle: String,recipePrepTime: String,recipeCaloriesMacro: Int, recipeFatMacro: Int, recipeCarbMacro: Int, recipeProteinMacro: Int, createdAt: Date?, ingredientItem: [String: String], directions: [String], recipeID: String, userUID: String){
      
        //saves from object in RecipeModel to arrays
        var ingredientArr:[String:String] = [:]
        var directionArr: [String] = []
        
        //goes through both ingredients and directions
      
        //sets up firebase w/ recipe as subcollection
        let newRecipeInfo: [String: Any] = [
                    "recipeID": recipeID,
                    "userName": userName,
                    "recipeImage": recipeImage,
                    "recipeTitle": recipeTitle,
                    "recipePrepTime": recipePrepTime,
                    "recipeCaloriesMacro": recipeCaloriesMacro,
                    "recipeFatMacro": recipeFatMacro,
                    "recipeCarbMacro": recipeCarbMacro,
                    "recipeProteinMacro": recipeProteinMacro,
                    "createdAt": Date.now,
                    "ingredientItem": ingredientItem,
                    "directions": directions,
                    "userUID": userUID
                ]
       
            
//grab current user
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
//updates data in firebase
        do {
            try
                FirebaseManager.shared.firestore
                .collection("users")
                .document(uid)
                .collection("savedUserRecipesNonUser")
                .document(recipeID)
                .setData(newRecipeInfo, merge:true)
            }
            catch let error {
                print("Error writing recipe to Firestore: \(error)")
            }
    }
    
  
    
    
    
    func grabSavedUserRecipes(){
       //grab current user
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("savedUserRecipesNonUser")
            .addSnapshotListener { (snapshot, err) in
                guard let documents = snapshot?.documents else{
                    print("no documents present")
                    return
                }
                
                self.savedRecipesNonUser = documents.map { (querySnapshot) -> SavedRecipeItem in
                    let data = querySnapshot.data()
                    let userName = data ["userName"] as? String ?? ""
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
                    let userUID = data ["userUID"] as? String ?? ""
                    let recipe = SavedRecipeItem(id: recipeID, userName: userName, recipeTitle:recipeTitle , recipePrepTime: recipePrepTime, recipeImage: recipeImage, createdAt: createdAt, recipeCaloriesMacro: recipeCaloriesMacro, recipeFatMacro: recipeFatMacro, recipeCarbMacro:recipeCarbMacro, recipeProteinMacro: recipeProteinMacro, directions: directions, ingredientItem: ingredients, userUID: userUID)
                    
                    return recipe
                    
                }
            }
        }
    
    
    
}
