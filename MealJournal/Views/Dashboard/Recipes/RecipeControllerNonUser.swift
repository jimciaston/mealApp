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
                  ZStack(alignment: .top) {
                    WebImage(url: URL(string: image))
                      .placeholder(Image("recipeImageNew").resizable())
                      // .border(.red)
                      .clipShape(RoundedRectangle(cornerRadius: 10.0))
                      
                      .frame(width:330, height: 200)
                      .padding(.top, 65)
                      .aspectRatio(contentMode: .fill)
                     
                  
                  }
                    
                  .edgesIgnoringSafeArea(.all)
                  .frame(width:300, height: 120)
                }
               
                
        //show image picker
               
    
                RecipeDashHeader(recipeName: name, recipePrepTime: prepTime, caloriesPicker: recipeCaloriesMacro ,fatPicker: recipeFatMacro,carbPicker: recipeCarbMacro, proteinPicker: recipeProteinMacro, ema: ema)
                    .padding()
                    .padding(.top, 15)
                    .shadow(color: Color("LightWhite"), radius: 5, x: 10, y: 10)
                    .cornerRadius(25)
        
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
        RecipeControllerNonUser(name: "Jumbalaya", prepTime: "30 min", image: "", ingredients: [:], directions: [], recipeID: "", recipeCaloriesMacro: 220, recipeFatMacro: 12, recipeCarbMacro: 40, recipeProteinMacro: 20, userName: "leave for nowf")
    }
}
