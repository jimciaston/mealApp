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
                        print("test")
                            FirebaseManager.shared.firestore
                                .collection("users")
                                .document(uid)
                                .collection("userRecipes")
                                .document(doc.documentID).delete() { err in
                                    if let err = err {
                                            print("Error removing document: \(err)")
                                        } else {
                                            print("Document successfully removed!")
                                        }
                                }
                        
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
                    let recipe = RecipeItem(id: recipeID, recipeTitle:recipeTitle , recipePrepTime: recipePrepTime, recipeImage: recipeImage, createdAt: createdAt, directions: directions, ingredientItem: ingredients)
                    return recipe
                }
            }
        }
    }

