//
//  UserProfileFullRecipeList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/6/22.
//

import SwiftUI

struct RecipeFullListView_nonUser: View {
    @State var recipes: [RecipeItem]
    @State var showAddButton: Bool // << keep false to not allow users to add recipe to meal journal if not on their profile
    
   
    @State private var isActive = false
    @State private var active: Int? = nil
    @State var triggerRecipeController = false
    @Binding var notCurrentUserProfile: Bool
    var userName: String
    var body: some View {
        ZStack{
            VStack{
                Text("Saved Recipes").bold()
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .font(.title2)
                   
                if(recipes.count > 0){
                    FullListOfRecipes_nonUser(showAddButton: $showAddButton, allRecipes: recipes, userName: userName )
                }
                else{
                    if !notCurrentUserProfile{ // << if user is visiting another users profile
                        // if they are, don't show below
                        VStack{
                            Image(systemName: "plus.rectangle.on.rectangle")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .onTapGesture {
                                    triggerRecipeController = true
                                }
                        }
                        .padding(.top, 40)
                       
                    }
                    else{
                        Text("User has no current recipes")
                            .font(.title3)
                            .padding()
                    }
                }
                
                
            }
            
        }
    }
}

