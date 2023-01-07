//
//  RecipeFullListView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/25/22.
//

import SwiftUI

struct RecipeFullListView: View {
    @State var recipes: [RecipeItem]
    @State var showAddButton: Bool // << keep false to not allow users to add recipe to meal journal if not on their profile
    
    @ObservedObject var rm = RecipeLogic()
    @State private var isActive = false
    @State private var active: Int? = nil
    @State var triggerRecipeController = false
    
    init(recipes: [RecipeItem ], showAddButton: Bool){
        self.recipes = recipes
        self.showAddButton = showAddButton
        
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            VStack{
                Text("Recipes").bold()
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .font(.title2)
                if(recipes.count > 0){
                    FullListOfRecipes(showAddButton: $showAddButton, allRecipes: recipes)
                }
                else{
                    VStack{
                        Image(systemName: "plus.rectangle.on.rectangle")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .onTapGesture {
                                triggerRecipeController = true
                            }
                        Text("Add a Recipe!")
                            .font(.title3)
                            .padding()
                    }
                    .padding(.top, 40)
                    .fullScreenCover(isPresented: $triggerRecipeController){
                            RecipeEditor()
                    }
                    Spacer()
                }
                
                
            }

        }
    }
}
       

//
//struct RecipeFullListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeFullListView()
//    }
//}
