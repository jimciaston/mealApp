//
//  RecipeListView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/17/22.
//when recipe is clicked assign id to go to page

import SwiftUI
import SDWebImageSwiftUI

struct RecipeListView: View {
    //keep as stateOBJ, if observed object - causes weird issue with loading recipes
    @StateObject var rm = RecipeLogic()
    @State var recipeViewToggle = false
    @EnvironmentObject var emaGlobal: EditModeActive
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack{
            List{
                //prefix = only show 3 recipes at a time
                ForEach(rm.recipes.prefix(3), id: \.id ){ recipe in
                        HStack{
                            WebImage(url: URL(string: recipe.recipeImage))
                                .placeholder(Image("defaultRecipeImage-2").resizable())
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame (width: 70, height:70)
                                    .cornerRadius(15)
                            VStack{
                                ZStack{
                                    Text(recipe.recipeTitle)
                                        .font(.body)
                                    //temp solution until I can center it
                                        .padding(.top, 1)
                                    //as a note, sets empty view to hide list arrow
                                    NavigationLink(destination: {RecipeController(name: recipe.recipeTitle,prepTime: recipe.recipePrepTime, image: recipe.recipeImage,  ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id, recipeFatMacro: recipe.recipeFatMacro, recipeCarbMacro: recipe.recipeCarbMacro, recipeProteinMacro: recipe.recipeProteinMacro)}, label: {
                                        emptyview()
                                        })
                                        .opacity(0.0)
                                        .buttonStyle(PlainButtonStyle())
                                    
                                    HStack{
                                        Text(String(recipe.recipeFatMacro) + "g")
                                            .foregroundColor(.gray)
                                        Text(String(recipe.recipeCarbMacro) + "g")
                                            .foregroundColor(.gray)
                                        Text(String(recipe.recipeProteinMacro) + "g")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.top, 80)
                                    .padding(.bottom, 10)
                                    .frame(height:90)
                                }
                                .padding(.top, -20)
            
                                }
                            .padding(EdgeInsets(top: -5, leading: -25, bottom: 0, trailing: 0))
                            }
                        }
                
                ZStack{
                    NavigationLink(destination:RecipeFullListView()) {
                           emptyview()
                       }
                   
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    
                       HStack {
                           Text("View More")
                               .font(.body)
                               .frame(width:300)
                               .padding(.top, 20)
                       }
                }
            }
           
        }
        .onAppear{
            emaGlobal.editMode = false
        }
    }
}



struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
