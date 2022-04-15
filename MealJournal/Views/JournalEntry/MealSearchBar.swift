//
//  MealSearchBar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/20/22.
//

import SwiftUI

struct MealSearchBar: View {
    //TEXTFIELD
    @State var userFoodInput = ""
    //if text completed
    @State private var didtextComplete = false
    //if user seached for a meal
    @State private var didUserSearch = false
    //calls search API
    @StateObject private var foodApi = FoodApiSearch()
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(Color("LightWhite"))
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Search Food", text: $userFoodInput)
                        .onSubmit {
                            foodApi.searchFood(userItem: userFoodInput)
                            didUserSearch = true
                            if didUserSearch{
                                userFoodInput = ""
                            }
                        }
                    //Text(foodApi.foodDescription)
                }
                .foregroundColor(.black)
                .padding(.leading, 13)
                
               
            }
            
            .frame(height:40)
            .cornerRadius(15)
            .padding(12)
        }
        FoodSearchResultsView(userSearch: $didUserSearch, textComplete: $didtextComplete)
            .environmentObject(foodApi)
    }
    
}
