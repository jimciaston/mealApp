//
//  RecipeFullListView.swift
//  MealJournal
//FULL LIST VIEW
//  Created by Jim Ciaston on 3/25/22.
//

import SwiftUI

struct RecipeFullListView: View {
    
    @ObservedObject var rm = RecipeLogic()
    @State private var isActive = false
    @State private var active: Int? = nil
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        let recipeList = rm.recipes.enumerated().map({ $0 })
        ZStack{
            VStack{
                Text("All Recipes")
                    .font(.title2)
               
                List{
                    ForEach(recipeList, id: \.element.recipeTitle){ index, recipe in
                        HStack{
                            RecipeFullListRow(recipe: recipe, recipeName: recipe.recipeTitle, active: $active, index: index)
                       
                            }
                        }
                    }
                }

            }
        }
    }
       


struct RecipeFullListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFullListView()
    }
}
