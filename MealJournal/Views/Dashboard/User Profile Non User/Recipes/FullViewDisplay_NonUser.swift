//
//  SwiftUIView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/3/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct FullListOfRecipes_nonUser: View {
    
    
    @EnvironmentObject var mealEntryObj: MealEntrys
    
    @ObservedObject var rm = RecipeLogic()
    @Binding var showAddButton:Bool
    @State var showRecipeModal = false
    @State var allRecipes: [RecipeItem]
    @State var selectedRecipe: RecipeItem?
    @State var MealObject = Meal()
    @State var mealTimingToggle = false
    var userName: String
    @State private var currentPage = 0
    @State var userUID: String
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @Binding var notCurrentUserProfile: Bool
    let blankUser = UserModel(data: [:]) // << passing in blank User Model sicne we don't need in this view
   
    var body: some View {
        if allRecipes.count >= 1 {
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
                .placeholder(Image("defaultRecipeImage-2").resizable())
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
                    RecipeControllerNonUser(name: $0.recipeTitle, prepTime: $0.recipePrepTime, image: $0.recipeImage, ingredients: $0.ingredientItem, directions: $0.directions, recipeID: $0.id, recipeCaloriesMacro: $0.recipeCaloriesMacro, recipeFatMacro: $0.recipeFatMacro, recipeCarbMacro: $0.recipeCarbMacro, recipeProteinMacro: $0.recipeProteinMacro, userName: userName, userUID: userUID, notCurrentUserProfile: $notCurrentUserProfile, userModel: blankUser)
                        
                }
               
            }
    }

}

