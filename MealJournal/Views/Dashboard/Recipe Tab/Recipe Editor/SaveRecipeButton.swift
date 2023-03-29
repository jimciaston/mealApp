//
//  SaveRecipeButton.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/6/22.
//

import SwiftUI
import Firebase

extension AnyTransition {
    static var sideSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .top))}
}
struct SaveRecipeButton: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showSuccessMessage: Bool
    //stores recipe
    @ObservedObject var recipeClass: Recipe
  
    @State var isNewRecipeValid = false
    static var newRecipeCreated = false
 
    @Binding var dismissSaveRecipeSheet: Bool
    func saveRecipe (){
        let recipeIDCreator = UUID().uuidString
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
                    "recipeID": recipeIDCreator,
                    "recipeImage": recipeClass.recipeImage,
                    "recipeTitle": recipeClass.recipeTitle,
                    "recipePrepTime": recipeClass.recipePrepTime,
                    "recipeCaloriesMacro": recipeClass.recipeCaloriesMacro,
                    "recipeFatMacro": recipeClass.recipeFatMacro,
                    "recipeCarbMacro": recipeClass.recipeCarbMacro,
                    "recipeProteinMacro": recipeClass.recipeProteinMacro,
                    "createdAt": Date.now,
                    "ingredientItem": ingredientArr,
                    "directions": directionArr
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
                .document(uid).collection("userRecipes")
                .document(recipeClass.id)
                .setData(newRecipeInfo, merge:true)
            
            recipeClass.recipeTitle = ""
            recipeClass.recipePrepTime = "5 Mins"
            recipeClass.recipeFatMacro = 0
            recipeClass.recipeCarbMacro = 0
            recipeClass.recipeProteinMacro = 0
            recipeClass.recipeCaloriesMacro = 0
            recipeClass.ingredients = []
            recipeClass.directions = [] 
            }
            catch let error {
                print("Error writing recipe to Firestore: \(error)")
            }
    }
  
    var body: some View {
        Button(action: {
            //action
        }){
            HStack{
//                Image(systemName: "pencil").resizable()
//                    .frame(width:40, height:40)
//                    .foregroundColor(.white)
//
                Button(action: {
                    //rules to save recipe
                    if (recipeClass.recipeTitle != ""
                        &&
                        recipeClass.ingredients.isEmpty == false &&
                        recipeClass.directions.isEmpty == false
                    ){
                        isNewRecipeValid = true
                        saveRecipe()
                        showSuccessMessage = true
                        dismissSaveRecipeSheet = true
                        dismissSaveRecipeSheet = false
                     
                      
                    }
                    else{
                        showSuccessMessage = false
                        isNewRecipeValid = false
                    }
                 
                }){
                    Text("Save Recipe")
                        .font(.title)
                        .frame(width:200, height: 80)
                        .foregroundColor(.white)
                        .padding(.top, -25)
                }
            }
            
            .padding(EdgeInsets(top: 12, leading: 100, bottom: 12, trailing: 100))
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(
                        Color("UserProfileCard1")))
            
        }
        .transition(.sideSlide)
        .animation(.easeInOut(duration: 0.25))
        
    }
    
     
}

//struct SaveRecipeButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveRecipeButton()
//    }
//}
