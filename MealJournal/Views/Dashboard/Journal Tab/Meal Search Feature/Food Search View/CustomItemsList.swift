//
//  CustomItemsList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/28/22.
//

import SwiftUI
import SwiftUIX
import FirebaseFirestore
import Firebase
struct CustomItemsList: View {
    @EnvironmentObject var mealEntryObj: MealEntrys
    @StateObject private var foodApi = FoodApiSearch()
    @ObservedObject var logic = CustomFoodLogic()
    @State var mealTimingToggle = false
    @State var sheetMode: SheetMode = .none // << communicates with mealtimings
    @State var MealObject = Meal()
    @Binding var isViewSearching: Bool
    @Binding var userSearch: Bool
    @State var resultsShowing = 5
    @State var addCustomFoodToggle = false
    @Binding var hideTitleRows: Bool
    @State var showDeleteItemView = false
    var screensize = UIScreen.main.bounds.height
    var body: some View {
        VStack{
            List{
                ForEach (logic.customFoodItems.prefix(resultsShowing), id: \.self ) { item in
                    CustomItemListRow(mealTimingToggle: $mealTimingToggle,sheetMode: $sheetMode, MealObject: $MealObject, isViewSearching: $isViewSearching, userSearch: $userSearch, resultsShowing: $resultsShowing, showDeleteItemView: $showDeleteItemView, item: .constant(item), mealName: item.mealName ?? "Invalid Name", customMealID: item.id, dismissResultsView: $hideTitleRows)
                }
           
                
                Button(action: {
                    resultsShowing += 5
                }){
                    //return nothing if no custom items for user
                    if logic.customFoodItems.count > 0{
                             Text("Add Custom Food Item")
                            .foregroundColor(.white)
                                 .frame(maxWidth: .infinity, alignment: .center)
                                 .onTapGesture{
                                     withAnimation(.linear(duration: 0.25)){
                                         addCustomFoodToggle.toggle()
                                     } 
                                 }
                             
                             .frame(maxWidth: .infinity, alignment: .leading)
                             .padding([.top, .bottom], 15)
                             .background(RoundedRectangle(
                                 cornerRadius:20).fill(Color("UserProfileCard2")))
                             .foregroundColor(.black)
                           //  .opacity(mealTimingToggle ? 0.3 : 1)
                         
                        
                        Text("View More")
                            .padding(.top, 10)
                    }
                    else{
                        VStack{
                            Text("Currently no custom food items")
                                .font(.title2)
                            
                            Button(action: {
                                addCustomFoodToggle.toggle()
                            }){
                                Image(systemName:"plus")
                                    .resizable()
                                    .frame(width:30, height: 30)
                            }
                        }
                       
                    }
                    
                }
              
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 15)
                .multilineTextAlignment(.center)
                
                
                Button(action: {
                    isViewSearching = false
                    userSearch = false
                }){
                    if logic.customFoodItems.count > 0{
                        Text("Cancel Search")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                }
               
                .foregroundColor(.red)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .padding(.top, -10)
                .listRowSeparator(.hidden)
            
                //using windowOverlay from swiftUIX to hide TabBar
                .windowOverlay(isKeyAndVisible: self.$addCustomFoodToggle, {
                    GeometryReader { geometry in {
                        BottomSheetView(
                            isOpen: self.$addCustomFoodToggle,
                            maxHeight: screensize - 400, minHeight: 200
                        ) {
                            CustomFoodItemView(showing: $addCustomFoodToggle, isViewSearching: $isViewSearching, userSearch: $userSearch)
                                .environmentObject(mealEntryObj)
                                .animation(.easeInOut)
                                .background(Color("LightWhite"))
                                .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))

                        }
                        .padding(.bottom, -75)
                        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                    }().edgesIgnoringSafeArea(.all)
                           
                    }
                })
           
           
        }
            
      
        
        }
        .opacity(!showDeleteItemView ? 1 : 0.4)
        .opacity(!mealTimingToggle ? 1 : 0.4)
        .opacity(!addCustomFoodToggle ? 1 : 0.4)
        if(mealTimingToggle){
            FlexibleSheet(sheetMode: $sheetMode) {
                MealTimingSelectorView(meal: $MealObject, isViewSearching: $isViewSearching, userSearch: $userSearch, mealTimingToggle: $mealTimingToggle, extendedViewOpen: .constant(false), mealSelected: .constant(true))
                }
            ///when adjusting frame height for sheet, must adjust heights on flexible sheet and meal timing selector view or will display weird
            .frame(height:240)
            .animation(.easeInOut)
            }
    }
}

//struct CustomItemsList_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomItemsList()
//    }
//}
