//
//  RecipeFull.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/9/23.
// recipe tabbar

import SwiftUI

struct RecipeFullListView_MainTab: View {
    @Environment(\.colorScheme) var colorScheme
    var recipes: [SavedRecipeItem]
    @State var showAddButton: Bool // << keep false to not allow users to add recipe to meal journal if not on their profile
    
    @State private var isActive = false
    @State private var active: Int? = nil
    @State var triggerRecipeController = false
    @Binding var notCurrentUserProfile: Bool
    @Binding var navigatingFromProfileCards: Bool
    var body: some View {
        ZStack{
            VStack{
                Text("Saved Recipes").bold()
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .font(.title2)
                   
                if(recipes.count > 0){
                    FullViewDisplay_MainTab(showAddButton: $showAddButton, allRecipes: recipes )
                }
                
                else{
                    if navigatingFromProfileCards{
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
            .foregroundColor(colorScheme == .dark ? .white : Color("darkModeBackground"))
        }
    }
}

//struct RecipeFull_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeFull()
//    }
//}
