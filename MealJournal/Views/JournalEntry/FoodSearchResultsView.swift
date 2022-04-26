//
//  FoodSearch.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/22/22.
//

import SwiftUI

struct FoodSearchResultsView: View {
    @EnvironmentObject private var foodApi: FoodApiSearch
    
    @State var MealObject = Meal()
    
    @State private var chooseMealTiming = false
    @State private var sheetMode: SheetMode = .none
    //textfield input
    @State private var searchResultsItem = ""
    //if toggled, will display, binded to search bar
    @Binding var userSearch: Bool
    //when false, api results will not display
    @Binding var isViewSearching:Bool //sending to searchbar
    @State var mealTimingToggle = false //Tells whether mealtiming list is open or closed, binded to meal timing selector view
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
                            HStack{
                                VStack (alignment:.leading){
                                    Text(meal.mealName ?? "default")
                                        .font(.title3)
                                    HStack{
                                        Text(meal.brand ?? "Brand Unavailable")
                                            .font(.caption)
                                           // .offset(y:8)
                                        Text(meal.calories!  + ", cals ")
                                            .font(.caption)
                                          //  .offset(y:8)
                                       
                                            
                                            
                                           
                                        }
                                    .border(.red)
                                 
                                  
                                    }
                                .padding(.leading, -40)
                               
                              
                                .foregroundColor(.black)
                                
                            Button(action: {
                                switch sheetMode {
                                    case .none:
                                        sheetMode = .mealTimingSelection
                                    case .mealTimingSelection:
                                        sheetMode = .none
                                case .quarter:
                                    sheetMode = .mealTimingSelection
                                }
                                //communicates with mealtimingselectionview
                                MealObject = meal
                                mealTimingToggle = true
                            }){
                                Image(systemName: "plus.app")
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                                   // .offset(x: 70)
                                   // .frame(width:100)
                                    .padding(.leading, 100)
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
            
            FlexibleSheet(sheetMode: $sheetMode) {
                MealTimingSelectorView(meal: $MealObject, isViewSearching: $isViewSearching, userSearch: $userSearch, mealTimingToggle: $mealTimingToggle)
                }
                .frame(width:400, height:200)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            }
        }
    }

   

//struct FoodSearch_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodSearchResultsView(userSearch: Binding.constant(true), isViewSearching: Binding.constant(true))
//    }
//}
//

