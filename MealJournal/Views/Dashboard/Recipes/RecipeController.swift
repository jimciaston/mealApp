//
//  RecipeView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/15/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeController: View {
    @StateObject var rm = RecipeLogic()
    @ObservedObject var ema = EditModeActive()
   
    @State var name: String
    @State var prepTime: String
    @State var image: String
    @State var ingredients: [String: String]
    @State var directions: [String]
    @State var recipeID: String

    /*/
     can add if ingredients != ema.updatedINgredients then run the saveRecipes function
     
     */
    var body: some View {
                VStack{
                    WebImage(url: URL(string: image))
                        .placeholder(Image("defaultRecipeImage-2").resizable())
                        .resizable()
                        .frame(width:500, height: 250)
                        .aspectRatio(contentMode: .fill)
                    }
                .frame(width:300, height: 80)

        RecipeDashHeader(recipeName: name, recipePrepTime: prepTime, ema: ema)
                    .padding()
        
                //ingredients or directions selction
        RecipeNavigationModals(ema: ema, currentRecipeID: recipeID, directions: directions, ingredients: ingredients)
            .padding(.top, 50)
        
        //edit recipe button
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        ema.editMode.toggle()
                        //if user is saving when complete is on the button
                        if !ema.editMode {
                            if ema.isIngredientsActive{
                                rm.saveRecipeIngredients(ingredientList: ema.updatedIngredients, currentRecipe: recipeID)
                            }
                            else{
                                rm.saveRecipeDirections(directions: ema.updatedDirections, currentRecipe: recipeID)
                            }
                        }
                    }){
                        HStack{
                            Image(systemName: !ema.editMode ? "pencil.circle" : "")
                                    .foregroundColor(.black)
                            Text(!ema.editMode ? "Edit" : "Complete")
                                .foregroundColor(.black)
                            }
                       
                    }
                   

                }
            }
      }
    }
  
                
                
         
      
       



//struct RecipeController_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeController(name: .constant(true), image: .constant(true))
//    }
//}

