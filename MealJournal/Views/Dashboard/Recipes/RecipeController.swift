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
    
    
    @State var name: String
    @State var prepTime: String
    @State var image: String
    @State var recipeEdit = true
    @State var ingredients: [String: String]
    @State var directions: [String]
    @State var recipeID: String
    
    @State var editRecipeMode = false
    
    var body: some View {
                VStack{
                    WebImage(url: URL(string: image))
                        .placeholder(Image("defaultRecipeImage-2").resizable())
                        .resizable()
                        .frame(width:500, height: 250)
                        .aspectRatio(contentMode: .fill)
                    }
                .frame(width:300, height: 80)

        RecipeDashHeader(recipeName: name, recipePrepTime: prepTime,editingRecipe: $editRecipeMode)
                    .padding()
        
                //ingredients or directions selction
        RecipeNavigationModals( editRecipeMode: $editRecipeMode, directions: directions, ingredients: ingredients)
            .padding(.top, 50)
        
        //edit recipe button
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        editRecipeMode.toggle()
                    }){
                        HStack{
                            Image(systemName: !editRecipeMode ? "pencil.circle" : "")
                                    .foregroundColor(.black)
                            Text(!editRecipeMode ? "Edit" : "Complete")
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

