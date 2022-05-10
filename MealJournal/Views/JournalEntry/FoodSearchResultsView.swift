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
    @State var extendedViewOpen = false
    @State private var chooseMealTiming = false
    @State private var sheetMode: SheetMode = .none
    //textfield input
    @State private var searchResultsItem = ""
    //if toggled, will display, binded to search bar
    @Binding var userSearch: Bool
    //when false, api results will not display
    @Binding var isViewSearching:Bool //sending to searchbar
    @State var mealTimingToggle = false //Tells whether mealtiming list is open or closed, binded to meal timing selector view
    @State var isListFull = false //checks if all api results are shown
    
    @State var listCounter = 0 //keeps track of list on appear
    @State var resultsDisplayed = 5 //bursts of results added to the screen
    @Environment(\.dismiss) var dismiss
    @State var mealSelected = false //not used, just there for meal selector
    
    @State var testRun = false //update name later
    
    
    var body: some View {
        if userSearch{
            VStack{
                HStack{
                    Text(isViewSearching ? "Results" : "Searching..")
                    Button(action: {
                        userSearch = false
                        isViewSearching = false
                    }){
                      Image(systemName: "xmark")
                            
                    }
                    .foregroundColor(.black)
                }
               
                Spacer()
                
               
                
              //  delays showing api call
                    .onAppear {
                        testRun = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.isViewSearching = true
                            testRun = true
                               }
                        if mealSelected {
                            resultsDisplayed = 5
                        }
                        mealSelected = false
                           }
                //if user has completed searching for a food
                
                if isViewSearching{
                    List{
                        ForEach(foodApi.userSearchResults.prefix(resultsDisplayed)) { meal in
                            ZStack{
                                HStack{
                                    VStack (alignment:.leading){
                                        Text(meal.mealName ?? "default")
                                            .font(.body)
                                        HStack{
                                            Text(meal.brand ?? "Generic")
                                                .font(.caption)
                                                .frame(width:70)
                                               // .offset(y:8)
                                            Text(", " + meal.calories!  + "cals ")
                                                .font(.caption)
                                            }
                                        }
                                    .frame(width: 300)
                                    .offset(x: -50)
                                    .foregroundColor(.black)
                                  
                                Button(action: {
                                    switch sheetMode {
                                        case .none:
                                            sheetMode = .mealTimingSelection
                                        mealTimingToggle = true //meal timing list comes to view
                                        case .mealTimingSelection:
                                            sheetMode = .none
                                        mealTimingToggle = false //list leaves view
                                    case .quarter:
                                        sheetMode = .none
                                    }
                                    
                                    //communicates with mealtimingselectionview
                                    MealObject = meal
                                }){
                                    Image(systemName: "plus.app")
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)
                                       .padding(.trailing, 25)
                                }
                                    
                                .onAppear(){
                                    listCounter += 1
                                }
                                    //allows button to be separely clicked //in view
                                .buttonStyle(BorderlessButtonStyle())
                                    
                        }
                                
                                //HIDES STUPID STUPID LIST ARROWS
                                NavigationLink(destination: FoodItemView(
                                    meal:.constant(meal),
                                    mealName: meal.mealName ?? "Default",
                                    mealBrand: meal.brand ?? "Generic",
                                    mealCalories: meal.calories ?? "Default",
                                    mealCarbs: meal.carbs ?? 0,
                                    mealProtein: meal.protein ?? 0,
                                    mealFat: meal.fat ?? 0
                                ) 
                                             
                                ){
                                    emptyview()
                                }
                                .opacity(0)//hides emptyview
                               
                    }
                        .frame(width:220, height:40) //width of background
                        .padding([.leading, .trailing], 60)
                        .padding([.top, .bottom], 10)
                        .background(RoundedRectangle(
                            cornerRadius:20).fill(Color("LightWhite")))
                        .foregroundColor(.black)
                        .opacity(mealTimingToggle ? 0.3 : 1)
                        }
                        //load more results
                        
                        if(!isListFull){
                            if testRun{
                                Button(isListFull ? "" : "View More"){
                                    if (foodApi.userSearchResults.count > listCounter){
                                        resultsDisplayed += 5
                                    }
                                    else{
                                        isListFull = true
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding([.top, .bottom], 15)
                                .multilineTextAlignment(.center)
                            }
                            }
                            
                       
                    }
                    
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                        
                }
              
        }
                
    }
            if(mealTimingToggle){
                FlexibleSheet(sheetMode: $sheetMode) {
                    MealTimingSelectorView(meal: $MealObject, isViewSearching: $isViewSearching, userSearch: $userSearch, mealTimingToggle: $mealTimingToggle, extendedViewOpen: $extendedViewOpen, mealSelected: $mealSelected)
                    }
                ///when adjusting frame height for sheet, must adjust heights on flexible sheet and meal timing selector view or will display weird
                .frame(height:240)
                .animation(.easeInOut)
                }
            }
        }
    

   

struct FoodSearch_Previews: PreviewProvider {
    static var previews: some View {
        FoodSearchResultsView(userSearch: Binding.constant(true), isViewSearching: Binding.constant(true))
    }
}


