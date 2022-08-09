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
    @Environment (\.dismiss) var dismiss
    init(){
     grabRecipes()
    }
    
    //delete recipe functionality
    func deleteRecipe(selectedRecipeID: String){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userRecipes")
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
                                .collection("userRecipes")
                                .document(doc.documentID).delete() { err in
                                    if let err = err {
                                            print("Error removing document: \(err)")
                                        } else {
                                            self.dismiss()
                                            print("Document successfully removed!")
                                        }
                                    }
                                }
                            }
                        }
                    }
    
    //save recipes when edited
    func saveRecipeIngredients(ingredientList: [String: String], currentRecipe: String){
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
                                .updateData(["ingredientItem" : ingredientList])
                                    
                            print("Updated Recipe")
                        }
                    }
                }
            }
    
    func saveRecipeDirections(directions: [String], currentRecipe: String){
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
                                .updateData(["directions" : directions])
                                    
                            print("Updated Direction Recipe")
                        }
                    }
                }
            }
    
    
    //fetch recipes
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
                    let ingredients = data ["ingredientItem"] as? [String: String] ?? ["": ""]
                    let directions = data ["directions"] as? [String] ?? [""]
                    let recipeID = data ["recipeID"] as? String ?? ""
                    let recipeFatMacro = data ["recipeFatMacro"] as? Int ?? 0
                    let recipeCarbMacro = data ["recipeCarbMacro"] as? Int ?? 0
                    let recipeProteinMacro = data ["recipeProteinMacro"] as? Int ?? 0
                    let recipe = RecipeItem(id: recipeID, recipeTitle:recipeTitle , recipePrepTime: recipePrepTime, recipeImage: recipeImage, createdAt: createdAt, recipeFatMacro: recipeFatMacro, recipeCarbMacro:recipeCarbMacro, recipeProteinMacro: recipeProteinMacro, directions: directions, ingredientItem: ingredients)
                    
                    return recipe
                    
                }
            }
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

