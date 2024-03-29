//
//  FoodResultsEntryRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/21/22.
//

import SwiftUI

struct FoodResultsEntryRow: View {
    @EnvironmentObject var foodApi: FoodApiSearch
    @Environment(\.colorScheme) var colorScheme
    @State var isResultsShowing = true
    @Binding var mealTimingToggle: Bool //Tells whether mealtiming list is open or closed, binded to meal timing selector view
    @Binding var resultsDisplayed: Int //bursts of 5 results added to the screen
    @State var listCounter = 0 //keeps track of list on appear
    @State var addCustomFoodToggle = false
    @State var extendedViewOpen = false
    @State var mealSelected = false
    @Binding var isViewSearching:Bool //sending to searchbar
    @Binding var userSearch: Bool
    @Binding var MealObject: Meal
  
    @Binding var sheetMode: SheetMode
    @Binding var dismissResultsView: Bool
    var body: some View {
        VStack{
            List{
                ForEach(foodApi.userSearchResults.prefix(resultsDisplayed)) { meal in
                    ZStack{
                        HStack{
                            VStack(alignment:.leading){
                                Text(((meal.mealName ?? "default").count > 23) ?
                                     ((meal.mealName ?? "default").prefix(23) + "...") :
                                     (meal.mealName ?? "default"))
                                    .bold()
                                    .font(.body)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                   
                                HStack{
                                    Text(meal.brand ?? "BrandName Unavailable")
                                        .font(.caption)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                    Text(" " + String(meal.calories ?? 0) + " calories")
                                        .font(.caption)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading) // <<aligns to left of frame
                                 
                                }
                           
                            .padding(.leading, 15)
                           
                           /// .frame(width:300)
                           // .padding(.leading, -50)
                            
                            .foregroundColor(.black)
                          
                        Button(action: {
                            switch sheetMode {
                                case .none:
                                    sheetMode = .mealTimingSelection
                                withAnimation(.linear(duration: 0.25)) {
                                    mealTimingToggle = true //meal timing list comes to view
                                }
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
                                .foregroundColor(Color("ButtonTwo"))
                                .padding(.trailing, 30) // <<moves plus
                        }
                            
                        .onAppear(){
                            listCounter += 1
                        }
                            //allows button to be separely clicked //in view
                        .buttonStyle(BorderlessButtonStyle())
                            
                }
                        
                        NavigationLink(destination: FoodItemView(
                            meal: meal,
                            mealName: meal.mealName ?? "Default",
                            mealBrand: meal.brand ?? "Generic",
                            mealCalories: meal.calories ?? 0,
                           
                            mealCarbs: meal.carbs ?? 0,
                            mealProtein: meal.protein ?? 0,
                            mealFat: meal.fat ?? 0,
                            mealUnitSize: meal.servingSizeUnit ?? "Default",
                            mealServingSize: meal.servingSize ?? 0,
                            originalMealServingSize: meal.servingSize ?? 0,
                            dismissResultsView: $dismissResultsView,
                            foodCategory: meal.foodCategory ?? "n/a"
                        )
                            .onAppear{
                                dismissResultsView = false
                            }
                            
                        ){
                            emptyview()
                            
                        }
                        .navigationBarHidden(true)
                        .opacity(0)//hides emptyview
                   
            }
              
             //   .padding([.leading, .trailing], 60)
                .padding([.top, .bottom], 10)
                .background(RoundedRectangle(
                    cornerRadius:20).fill(Color("LightWhite")))
                .foregroundColor(.black)
                .opacity(mealTimingToggle ? 0.3 : 1)
                
                }
             
                    Button(action: {
                        foodApi.foodResultsDisplayed = 0
                        resultsDisplayed += 5
                    }){
                        Text("View More")
                        
                    }
                    .opacity(foodApi.isFoodSearchLoading ? 0.0 : 1 )
                    .frame(maxWidth: .infinity)
                    .padding([.top, .bottom], 15)
                    .multilineTextAlignment(.center)
                HStack{
                  
                    Button(action: {
                        resultsDisplayed = 5
                        isViewSearching = false
                        userSearch = false
                    }){
                      
                        Text("Cancel Search")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .opacity(foodApi.isFoodSearchLoading ? 0.0 : 1 )
                   
                    .foregroundColor(.red)
                    .font(.caption)
                   
                    .padding(.top, -10)
                    .padding(.bottom, 20)
                   
                   
                }
                .listRowSeparator(.hidden)
                
                //view more results toggle
               
            }
      
           
            .listStyle(.plain)
            .listRowSeparator(.hidden)
        }
    }
    
}

//struct FoodResultsEntryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodResultsEntryRow()
//    }
//}
