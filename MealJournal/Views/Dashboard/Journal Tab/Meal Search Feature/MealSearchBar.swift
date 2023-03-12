//
//  MealSearchBar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/20/22.
//

import SwiftUI

struct MealSearchBar: View {
    @ObservedObject var logic = CustomFoodLogic()
    //TEXTFIELD
    @State var userFoodInput = ""
    @State private var didtextComplete = false
    //if user seached for a meal
    @State private var didUserSearch = false
    //calls search API
    @StateObject private var foodApi = FoodApiSearch()
    //if user is currently searching
   
    @Binding var isUserDoneSearching: Bool
    
    @State var showMoreResults = false
    
    
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(Color("LightWhite"))
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Enter Meal", text: $userFoodInput)
                        .onSubmit {
                            
                            foodApi.searchFood(userItem: userFoodInput, showMoreResults: showMoreResults)
                            didUserSearch = true
                            didtextComplete = true
                            isUserDoneSearching = true
                            
                            foodApi.userSearch = userFoodInput
                            
                            if didtextComplete{
                                foodApi.userSearchResults = [] //emptys list
                                userFoodInput = ""
                        }
                           
                    }
                }
                .foregroundColor(.black)
                .padding(.leading, 13)
            }
            
            .frame(height:40)
            .cornerRadius(15)
            .padding(12)
            //calling food results
            FoodSearchResultsView(userSearch: $didUserSearch,isViewSearching: $isUserDoneSearching)
                .border(.red)
                .environmentObject(foodApi)
        }

    
    }
        
}
