//
//  RecipeListView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/17/22.
//when recipe is clicked assign id to go to page

import SwiftUI

struct RecipeListView: View {
    @State var listofRecipes: [RecipeListModel] = RecipeList.recipes
    @State var recipeViewToggle = false
  
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack{
            List{
                ForEach(listofRecipes, id: \.id){ recipe in
                        HStack{
                            Image(recipe.image)
                                .resizable()
                               .frame (width: 70, height:70)
                                .cornerRadius(15)
                            VStack{
                                ZStack{
                                    Text(recipe.name)
                                        .font(.body)
                                    //temp solution until I can center it
                                        .padding(.top, 1)
                                    //as a note, sets empty view to hide list arrow
                                    NavigationLink(destination: {RecipeController(name: recipe.name, image: recipe.image)}, label: {
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
                                }
                                .padding(.top, -20)
            
                                }
                            .padding(EdgeInsets(top: -5, leading: -25, bottom: 0, trailing: 0))
                            }
                        }
                
                .onAppear {
                    //sets recipe to only show 3 recipes
                    if listofRecipes.count > 3 {
                        listofRecipes = listofRecipes.dropLast(listofRecipes.count - 3)
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
           
        }//
    
    }
}



struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
