//
//  FoodSearch.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/22/22.
//

import SwiftUI

struct FoodSearchResultsView: View {
    @EnvironmentObject private var foodApi: FoodApiSearch
    @EnvironmentObject var mealEntryObj: MealEntrys
    
    //textfield input
    @State private var searchResultsItem = ""
    //if toggled, will display, binded to search bar
    @Binding var userSearch: Bool
    
    //when false, api results will not display
    @Binding var isViewSearching:Bool //sending to searchboar
    
    var body: some View {
        if userSearch{
            VStack{
                Text(isViewSearching ? "Results" : "Searching..")
                Spacer()
              //  delays showing api call
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            self.isViewSearching = true
                               }
                           }
                //if user has completed searching for a food
                if isViewSearching{
                    List(foodApi.userSearchResults){meal in
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(meal.mealName)
                                        .padding(.leading,-50)
                                    HStack(alignment: .firstTextBaseline, spacing: 0){
                                        Text(meal.calories + " cals, ")
                                            .font(.caption)
                                            .offset(y:8)
                                        Text(meal.brand)
                                            .font(.caption)
                                            .offset(y:8)
                                            .frame(maxWidth:80)
                                        }
                                    .padding(.leading,-50)
                                    }
                                .padding(.leading,5)
                                .foregroundColor(.black)
                            Button(action: {
                                print(meal.calories)
                                userSearch = false
                                isViewSearching = false //is user actively searching, communicates with journalEntryMain
                                //push meal to meal entry break fast
                                mealEntryObj.mealEntrysBreakfast.append(meal)
                            }){
                                Image(systemName: "plus.app")
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                                   // .offset(x: 70)
                                   // .frame(width:100)
                                    .padding(.leading, 100)
                            }
                        }
                    }
                    .frame(width:220, height:40) //width of background
                    .padding([.leading, .trailing], 60)
                    .padding([.top, .bottom], 10)
                    .background(RoundedRectangle(
                        cornerRadius:20).fill(Color("LightWhite")))
                    .foregroundColor(.black)
                        
                    }
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                }
            }
        }
    }
}
   

//struct FoodSearch_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodSearchResultsView(userSearch: Binding.constant(true), isViewSearching: Binding.constant(true))
//    }
//}


