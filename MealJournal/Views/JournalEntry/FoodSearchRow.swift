//
//  FoodSearch.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/22/22.
//

import SwiftUI

struct FoodSearchResultsView: View {
    //calls API
    @EnvironmentObject private var foodApi: FoodApiSearch
    //textfield input
    @State private var searchResultsItem = ""
    //if toggled, will display, binded to search bar
    @Binding var userSearch: Bool
    //var holds if textfield typing is complete by user
    @Binding var textComplete: Bool
    //triggers select breakfast, lunch, dinner optins
    
    //when false, api results will not display
    @State private var isViewSearching = false
    
    var body: some View {
        if userSearch{
            VStack{
                Text(isViewSearching ? "Best Match" : "Searching..")
                Spacer()
                
                //delays showing api call
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                   self.isViewSearching = true
                               }
                           }
                //if user has completed searching for a food
                if isViewSearching{
                    List{
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(foodApi.userSearchResults[1].mealName)
                                    Text(foodApi.userSearchResults[1].calories + " cal")
                                        .font(.caption)
                                        .offset(y:8)
                                    }
                                        .foregroundColor(.black)
                                
                                Spacer()
                                Text(foodApi.userSearchResults[1].brand)
                            }
                        
                        .frame(width:200, height:40) //width of background
                        .padding([.leading, .trailing], 60)
                        .padding([.top, .bottom], 10)
                        .background(RoundedRectangle(
                            cornerRadius:20).fill(Color("LightWhite")))
                        .foregroundColor(.black)
                        Spacer()
                            
                            //add food button
                            Button("Add Food"){
                               userSearch = false
                                textComplete.toggle()
                            }
                           Spacer()
                                .padding(.top, -80)
                        }
                    }
                    .frame(height:800)
                }
            }
        }
    }
}
   
//
//struct FoodSearch_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodSearchResultsView(userSearch: Binding.constant(true))
//    }
//}

//delete variables (ie. foodname) to preview
