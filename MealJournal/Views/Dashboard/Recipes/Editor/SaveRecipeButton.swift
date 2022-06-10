//
//  SaveRecipeButton.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/6/22.
//

import SwiftUI
import Firebase




struct SaveRecipeButton: View {
    
    @EnvironmentObject var recipeClass: Recipe
   
    func saveRecipe (){
        //saves from object in RecipeModel to arrays
        var ingredientArr:[String:String] = [:]
        var directionArr: [String] = []
        
        //goes through both ingredients and directions
        for item in recipeClass.ingredients {
            ingredientArr[item.sizing] = item.description
        }
        for item in recipeClass.directions {
            directionArr.append(item.description)
        }
        //sets up firebase w/ recipe as subcollection
        let newRecipeInfo: [String: Any] = [
            "userRecipes": [
                "recipe": [
                    "recipeTitle": recipeClass.recipeTitle,
                    "recipePrepTime": recipeClass.recipePrepTime,
                    "createdAt": Date.now,
                    "ingredientItem": ingredientArr,
                    "directions": directionArr
                    ]
                ]
            ]

//grab current user
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
//updates data in firebase
        do {
            try FirebaseManager.shared.firestore.collection("users").document(uid).updateData(newRecipeInfo)
            print("successfully save to database")
        } catch let error {
            print("Error writing recipe to Firestore: \(error)")
        }
    }
    
    var body: some View {
        Button(action: {
            
        }){
            HStack{
                Image(systemName: "pencil").resizable()
                    .frame(width:40, height:40)
                    .foregroundColor(.white)
                Button(action: {
                    saveRecipe()
                   
                }){
                    Text("Save Recipe")
                        .font(.title)
                        .frame(width:200)
                        .foregroundColor(.white)
                }
                
                    
            }
            .padding(EdgeInsets(top: 12, leading: 100, bottom: 12, trailing: 100))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        Color("completeGreen")))
            
        }
    }
}

//struct SaveRecipeButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveRecipeButton()
//    }
//}
