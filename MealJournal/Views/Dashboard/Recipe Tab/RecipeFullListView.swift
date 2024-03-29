//
//  RecipeFullListView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/25/22.
//

import SwiftUI

struct RecipeFullListView: View {
    var recipes: [RecipeItem]
    @State var showAddButton: Bool // << keep false to not allow users to add recipe to meal journal if not on their profile
   
    @State private var isActive = false
    @State private var active: Int? = nil
    @State var triggerRecipeController = false
    @Binding var notCurrentUserProfile: Bool
    @Binding var navigatingFromProfileCards: Bool
    @State var addRecipe = false
    var body: some View {
        ZStack{
            VStack{
                Text(recipes.count != 0 ? "Saved Recipes" : "").bold()
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .font(.title2)
                   
                if(recipes.count > 0){
                    FullListOfRecipes(showAddButton: $showAddButton, allRecipes: recipes)
                }
                else{
                    if navigatingFromProfileCards{
                        Image(systemName: "plus.rectangle.on.rectangle")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .onTapGesture {
                                addRecipe = true
                            }
                        Text("Add a Recipe!")
                            .font(.title3)
                            .padding()
                            
                            .fullScreenCover(isPresented: $addRecipe){
                                RecipeEditor()
                            }
                    }
                        
                    else{
                        VStack {
                            Spacer()
                            Text("You have yet to save a user recipe")
                                .font(.title3)
                            Spacer()
                        }
                    }
                 
                   
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
