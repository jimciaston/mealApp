//
//  testA.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/28/22.
//    bRbzV0uKJyenEtd1GMgJJNh4BzGWtDvDZVOy8cqG

import SwiftUI

struct testA: View {
    //Textfield
    @State var userFoodInput = ""
    @State private var didUserSearch = false
    //will store api var of foodName
    @StateObject private var foodApi = FoodApiSearch()
    //send to food results view
    @State private var  foodName = ""
    var body: some View {
            VStack{
                TextField("enter first name", text: $userFoodInput)
                    .onSubmit {
                        didUserSearch = true
                        foodApi.searchFood(userItem: userFoodInput)

                    }
               
                
//                FoodSearchResultsView(userSearch: $didUserSearch)
//                    .environmentObject(foodApi)
        }
    }
}
struct testA_Previews: PreviewProvider {
    static var previews: some View {
        testA()
    }
}
