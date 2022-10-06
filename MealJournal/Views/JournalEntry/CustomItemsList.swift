//
//  CustomItemsList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/28/22.
//

import SwiftUI

struct CustomItemsList: View {
    @StateObject private var foodApi = FoodApiSearch()
    @ObservedObject var logic = CustomFoodLogic()
    @State var mealTimingToggle = false
    @State var sheetMode: SheetMode = .none // << communicates with mealtimings
    @State var MealObject = Meal()
    @Binding var isViewSearching: Bool
    @Binding var userSearch: Bool
    @State var resultsShowing = 5
    
    var body: some View {
        VStack{
            List{
                ForEach (logic.customFoodItems.prefix(resultsShowing), id: \.self ) { item in
                    CustomItemListRow(mealTimingToggle: $mealTimingToggle,sheetMode: $sheetMode, MealObject: $MealObject, isViewSearching: $isViewSearching, userSearch: $userSearch, resultsShowing: $resultsShowing, item: .constant(item), mealName: item.mealName ?? "Invalid Name")
                }
                Button(action: {
                    resultsShowing += 5
                }){
                    Text("View More")
                    
                }
              
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 15)
                .multilineTextAlignment(.center)
                
                Button(action: {
                    isViewSearching = false
                    userSearch = false
                }){
                    Text("Cancel Search")
                }
               
                .foregroundColor(.red)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .padding(.top, -10)
                .listRowSeparator(.hidden)
            
                
           
        }
       
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
}

//struct CustomItemsList_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomItemsList()
//    }
//}
