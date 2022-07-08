//
//  RecipeFullListRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeFullListRow: View {
    var recipe: RecipeItem
    var recipeName: String
    @State var showRecipeOptions = false
    @Binding var active: Int?
    let index: Int
  
    var body: some View {
                HStack{
                    WebImage(url: URL(string: recipe.recipeImage))
                        .placeholder(Image("defaultRecipeImage-2").resizable())
                        .resizable()
                        .frame (width: 70, height:70)
                        .cornerRadius(15)
                    ZStack{
                        Text(recipe.recipeTitle)
                            .font(.body)
                        //temp solution until I can center it
                            .padding(.top, 1)
                        //as a note, sets empty view to hide list arrow
                        NavigationLink(destination: {RecipeController(name: recipe.recipeTitle, prepTime: recipe.recipePrepTime, image: recipe.recipeImage, ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id)}, label: {
                                emptyview()
                            })
                           
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                        
                        Text("10g 25g 88g")
                            .foregroundColor(.gray)
                            .padding(.top, 80)
                            .padding(.bottom, 10)
                            .padding(.trailing, 10)
                            .frame(height:90)
                       
                        //if index is active
                        if index == active{
                                ReditorPopUp()
                                    .onTapGesture {
                                        active = nil
                                    }
                                    .padding(.top, 20)
                                    .padding(.leading, 15)
                                }
                            
                        }
                            .padding(.top, -10)
                            .padding(5)
     
                    Button(action: {
                        //action
                    }){
                        Image(systemName: "slider.horizontal.3")
                            .padding(.top, 10)
                            .foregroundColor(.black)
                        
                            .onTapGesture{
                                active = index
                              
                            }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                   
            }
    }
}

//struct RecipeFullListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeFullListRow()
//    }
//}
