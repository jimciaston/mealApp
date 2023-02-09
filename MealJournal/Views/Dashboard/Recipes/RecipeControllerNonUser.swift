//
//  RecipeControllerNonUser.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/24/23.
//

import SwiftUI

import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI

struct RecipeControllerNonUser: View {
    @Environment(\.dismiss) var dismiss // << dismiss view
    @ObservedObject var ema = EditModeActive()
    //displays image picker
    
    @ObservedObject var rm = RecipeLogicNonUser()
    @State var name: String
    @State var prepTime: String
    @State var image: String
    @State var ingredients: [String: String]
    @State var directions: [String]
    @State var recipeID: String
    @State var recipeCaloriesMacro: Int
    @State var recipeFatMacro: Int
    @State var recipeCarbMacro: Int
    @State var recipeProteinMacro: Int
    @State var userName: String

    /*/
     can add if ingredients != ema.updatedINgredients then run the saveRecipes function
     
     */
    
    //Save updatedRecipe picture to firestore
  
    
    var body: some View {
       
            VStack{
                
                VStack{
                  ZStack(alignment: .topLeading) {
                    WebImage(url: URL(string: image))
                      .placeholder(Image("defaultRecipeImage-2").resizable())
                      .resizable()
                      .frame(width:500, height: 250)
                      .aspectRatio(contentMode: .fill)
                      HStack{
                          Button(action: {
                            dismiss()
                          }){
                              Image(systemName: "xmark")
                                  .resizable()
                                  .frame(width: 40, height:40)
                              .foregroundColor(.blue)
                              .font(.title)
                              .padding(.leading, 70)
                              .padding(.top, 60)
                          }
                          HStack{
                              Button(action: {
                                  rm.saveUserRecipe(userName: "Leave for now", recipeImage: image, recipeTitle: name, recipePrepTime: prepTime, recipeCaloriesMacro: recipeCaloriesMacro, recipeFatMacro: recipeFatMacro, recipeCarbMacro: recipeCarbMacro, recipeProteinMacro: recipeProteinMacro, createdAt: Date(), ingredientItem: ingredients, directions: directions)
                                print("Saved Recipe")
                              }){
                                  Image(systemName: "star")
                                      .resizable()
                                      .frame(width: 50, height:50)
                                  .foregroundColor(.yellow)
                                  .font(.title)
                                  .padding(.leading, 240)
                                  .padding(.top, 60)
                              }
                          }
                         
                      }
                  
                  }
                    
                  .edgesIgnoringSafeArea(.all)
                  .frame(width:300, height: 120)
                }
               
                
        //show image picker
               
    
                RecipeDashHeader(recipeName: name, recipePrepTime: prepTime, caloriesPicker: recipeCaloriesMacro ,fatPicker: recipeFatMacro,carbPicker: recipeCarbMacro, proteinPicker: recipeProteinMacro, ema: ema)
                    .padding()
        
                //ingredients or directions selction
        RecipeNavigationModals(ema: ema, currentRecipeID: recipeID, directions: directions, ingredients: ingredients)
            .padding(.top, 70)
    
        //offsets toolbar, if text removed, would interrupt toolbar.
      
            
        //edit recipe button
       
            }
       
    }

}
       
      
    
struct RecipeControllerNonUser_Previews: PreviewProvider {
    static var previews: some View {
        RecipeControllerNonUser(name: "Test Recipe", prepTime: "30 min", image: "", ingredients: [:], directions: [], recipeID: "", recipeCaloriesMacro: 0, recipeFatMacro: 0, recipeCarbMacro: 0, recipeProteinMacro: 0, userName: "leave for nowf")
    }
}
