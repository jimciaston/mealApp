//
//  RecipeFullListView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/25/22.
//

import SwiftUI

struct RecipeFullListView: View {
    @Environment(\.dismiss) var dismiss
    @State var listofRecipes: [RecipeListModel] = RecipeList.recipes
    @State private var active = false
  
    
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            VStack{
                Text("Recipes")
                    //.padding(.bottom, -20)
                    //.padding(.top, 40)
                    .font(.title2)
               
                List{
                    ForEach(listofRecipes, id: \.id){ recipe in
                        RecipeFullListRow(recipe: recipe, recipeName: recipe.name)
                    }
                }
              
            }//end of VStack
        }
        
    }

}
       


struct RecipeFullListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFullListView()
    }
}
