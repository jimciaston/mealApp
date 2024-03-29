//
//  FoodSearch.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/22/22.
//

import SwiftUI
import SwiftUIX



struct FoodSearchResultsView: View {
    @EnvironmentObject var mealEntryObj: MealEntrys
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var foodApi: FoodApiSearch
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // IPad Nano sizing
    @State var MealObject = Meal()
    @State var isResultsShowing = true
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
    @State var addCustomFoodToggle = false
    @State var listCounter = 0 //keeps track of list on appear
    @State var resultsDisplayed = 5 //bursts of results added to the screen
    @ObservedObject var dashboardRouter = DashboardRouter()
    @State var mealSelected = false
   
    @State var dismissResultsView = true
   
    @State var isCustomItemsShowing = false
  
    @Environment (\.dismiss) var dismiss // remove
    
    let networkConnectivity = NetworkConnectivity() // check network
    
    @ViewBuilder
    var body: some View {
      
            if userSearch { // << if user searche food on searchbar
                if networkConnectivity.reachable{
                    GeometryReader { geo in
                        VStack{
                            if dismissResultsView{
                                HStack{
                                    Button(foodApi.isFoodSearchLoading ? "Searching..." : "Results"){
                                        foodApi.customFoodSearch = false // << not custom searching
                                        isResultsShowing = true
                                        isCustomItemsShowing = false
                                         
                                    }
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                    .padding(10)
                                    .background(isResultsShowing ? Color.gray : Color.almostClear)
                                        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                                    
                                    
                                    //Text(foodApi.isFoodSearchLoading ? "Searching..." : "Results")
                                    
                                    Button("Custom Items"){
                                        foodApi.customFoodSearch = true // << custom searching
                                        isResultsShowing = false
                                        isCustomItemsShowing = true
                                    }
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding(10)
                                    .background( !isResultsShowing ? Color.gray : Color.almostClear)
                                        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                                
                            }
                        }

                           
                            //if api loading
                            if(foodApi.isFoodSearchLoading){
                                ActivityIndicator() // << show progress bar
                                //every new search, reset the food results per page
                                    .onAppear{
                                        resultsDisplayed = 5
                                        if isViewSearching{
                                            resultsDisplayed = 5
                                            listCounter = 0
                                        }
                                        //api loads all ,then only displays 5 at a time
                                        if mealSelected {
                                            resultsDisplayed = 5
                                        }
                                        mealSelected = false
                                    }
                            }
                           
                                
                            //if user has completed searching for a food
                            
                            if isViewSearching{
                                if isResultsShowing{
                                    //if network time out
                                    if foodApi.isFoodSearchTimedOut {
                                        Text("Can't connect to server, please try again in a few minutes")
                                            .padding(.all, 50)
                                    }
                                   
                                        NavigationView{
                                                FoodResultsEntryRow(mealTimingToggle: $mealTimingToggle, resultsDisplayed: $resultsDisplayed, isViewSearching: $isViewSearching, userSearch: $userSearch, MealObject: $MealObject, sheetMode: $sheetMode, dismissResultsView: $dismissResultsView)
                                                        .environmentObject(foodApi)
                                        }
                                        .navigationViewStyle(StackNavigationViewStyle())
                                     if(mealTimingToggle){
                                         FlexibleSheet(sheetMode: $sheetMode) {
                                             MealTimingSelectorView(meal: $MealObject, isViewSearching: $isViewSearching, userSearch: $userSearch, mealTimingToggle: $mealTimingToggle, extendedViewOpen: $extendedViewOpen, mealSelected: $mealSelected)
                                                
                                             }
                                         .padding(.top, -150)
                                         ///when adjusting frame height for sheet, must adjust heights on flexible sheet and meal timing selector view or will display weird
                                         .frame(height:240)
                                         .padding(.top,horizontalSizeClass == .regular ? -650 : -1 ) // << moves snackbar info up in view
                                         .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                                         }
                                }
                                else{
                                    CustomItemsList(isViewSearching: $isViewSearching, userSearch: $userSearch, hideTitleRows: $dismissResultsView)
                                }
                            }
                                
                    }
                        .frame(height: geo.size.height + 50) // manually bring view down to go past tabbar
                    }
                }
                else{
                    VStack{
                        Text("Must be connected to the internet")
                            .font(.title3)
                            .padding(.bottom, 2)
                        Text("Please try again in a few minutes..")
                            .font(.title3)
                        Image("NoInternetSymbol")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding(.top, 15)
                    }
                    .frame(maxHeight: .infinity)
                }
                   
            }
        
     
   
    }

}




struct FoodSearch_Previews: PreviewProvider {
    static var previews: some View {
        FoodSearchResultsView(userSearch: Binding.constant(true), isViewSearching: Binding.constant(true))
    }
}


