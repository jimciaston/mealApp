//
//  RecipeFullListRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeFullListRow: View {
    //others will be ema
    @EnvironmentObject var emaGlobal: EditModeActive
   
    //standard recipe item
    var recipe: RecipeItem
    
    @ObservedObject var ema = EditModeActive()
    var recipeName: String
    @State var showRecipeOptions = false
    @Binding var active: Int?
    let index: Int
    
    
    var body: some View {
        
        VStack{
            WebImage(url: URL(string: recipe.recipeImage))
                .placeholder(Image("defaultRecipeImage-2").resizable())
                .resizable()
                .frame (width: 130, height:150)
                .cornerRadius(15)
            
            ZStack{
                HStack{
                    Text(recipe.recipeTitle).bold()
                    Spacer()
                    
                    NavigationLink(destination: {RecipeController(name: recipe.recipeTitle,prepTime: recipe.recipePrepTime, image: recipe.recipeImage,  ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id, recipeCaloriesMacro: recipe.recipeCaloriesMacro, recipeFatMacro: recipe.recipeFatMacro, recipeCarbMacro: recipe.recipeCarbMacro, recipeProteinMacro: recipe.recipeProteinMacro)}, label: {
                        emptyview()
                        })
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                    
                }
            }
                .frame(width:130)
                .padding(.bottom, 2)
                
                HStack{
                    Text(String(recipe.recipeCaloriesMacro) + " calories")
                        .foregroundColor(.gray)
                    Text(String(recipe.recipeFatMacro) + "g")
                        .foregroundColor(.gray)
                    Text(String(recipe.recipeCarbMacro) + "g")
                        .foregroundColor(.gray)
                    Text(String(recipe.recipeProteinMacro) + "g")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .frame(width:130)
            }
            .onAppear{
                emaGlobal.editMode = false
            }
            
        }
                
               
    }

//
//struct RecipeFullListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeFullListRow(recipe: RecipeItem(id: "Test", recipeTitle: "Test", recipePrepTime: "Test", recipeImage: "Test", createdAt: "Test", recipeFatMacro: 0, recipeCarbMacro: 0, recipeProteinMacro: 0, directions: ["Test"], ingredientItem: ["Test":"Test"]), recipeName: "Test", active: Int , index: 9)
//    }
//}
