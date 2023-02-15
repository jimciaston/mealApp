//
//  FullViewDisplay_MainTab.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/9/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct FullViewDisplay_MainTab: View {
    
    @EnvironmentObject var mealEntryObj: MealEntrys
    @ObservedObject var rm = RecipeLogic()
    @Binding var showAddButton:Bool
    @State var showRecipeModal = false
    @State var allRecipes: [SavedRecipeItem]
    @State var selectedRecipe: SavedRecipeItem?
    @State var MealObject = Meal()
    @State var mealTimingToggle = false
   
    @State private var currentPage = 0
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        if allRecipes.count >= 1 {
            // << Fatal error, index out of range if removed
            
            TabView {
                   ForEach(Array(allRecipes.chunked(into: 6)), id: \.self) { recipesChunk in
                       LazyVGrid(columns: columns) {
                          ForEach(recipesChunk, id: \.id) { recipe in
                             
                              self.item(image: recipe.recipeImage, title: recipe.recipeTitle, ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id, recipeCaloriesMacro: recipe.recipeCaloriesMacro, recipeFatMacro: recipe.recipeFatMacro, recipeCarbMacro: recipe.recipeCarbMacro, recipeProteinMacro: recipe.recipeProteinMacro, prepTime: recipe.recipePrepTime)
                                 
                              .onTapGesture {
                                selectedRecipe = recipe
                            }
                          }
                       }.frame(maxHeight: .infinity, alignment: .top)                   }
               }
          
               
           .tabViewStyle(.page)
           .gesture(
               DragGesture()
                  .onEnded { value in
                      if value.translation.width < 0 {
                          self.currentPage = min(self.currentPage + 1, rm.recipes.count / 4)
                  } else if value.translation.width > 0 {
                      self.currentPage = max(self.currentPage - 1, 0)
                  }
              }
            )
        }
        else{
            Text("No Recipes Saved")
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }


    
//individual item
    func item(image: String, title: String, ingredients: [String: String], directions: [String], recipeID: String, recipeCaloriesMacro: Int ,recipeFatMacro: Int, recipeCarbMacro: Int, recipeProteinMacro: Int, prepTime: String) -> some View {
        
        VStack{
            WebImage(url: URL(string: image))
                .placeholder(Image("recipeImageNew").resizable())
                .resizable()
                .frame (width: 150, height:130)
                .cornerRadius(15)
            
            ZStack{
                HStack{
                    Text(title).bold()
                        .padding(.leading, 20)
                    Spacer()
                }
            }
                .frame(width:150)
                .padding(.bottom,  2)
                //macros
                HStack{
                    Text(String(recipeCaloriesMacro) + " Calories")
                         Spacer()
                
                }
                
                .padding(.leading, 20)
                .frame(width:150)

                .sheet(item: $selectedRecipe){
                    RecipeControllerNonUser(name: $0.recipeTitle, prepTime: $0.recipePrepTime, image: $0.recipeImage, ingredients: $0.ingredientItem, directions: $0.directions, recipeID: $0.id, recipeCaloriesMacro: $0.recipeCaloriesMacro, recipeFatMacro: $0.recipeFatMacro, recipeCarbMacro: $0.recipeCarbMacro, recipeProteinMacro: $0.recipeProteinMacro, userName: "Leave as is for now")
                        
                }
               
            }
    }

}

//struct FullViewDisplay_MainTab_Previews: PreviewProvider {
//    static var previews: some View {
//        FullViewDisplay_MainTab()
//    }
//}
