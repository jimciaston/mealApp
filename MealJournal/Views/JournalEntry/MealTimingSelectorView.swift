//
//  ListViewMealTiming.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/22/22.
//

import SwiftUI
///TODO make full width
///create character limit on brands when they appear in journal entry.
///more details on jouranlEntry where they see full meal stats
struct MealTimingSelectorView: View {
    @EnvironmentObject var mealEntryObj: MealEntrys
    @Binding var meal: Meal
    @Binding var isViewSearching: Bool
    @Binding var userSearch: Bool
    @Binding var mealTimingToggle: Bool
    init(meal: Binding<Meal>, isViewSearching: Binding<Bool>, userSearch: Binding<Bool>, mealTimingToggle: Binding<Bool>){
        ///commented the view color out for now, as it was having a weird effect on the journalEntryMain list. 
       // UITableView.appearance().backgroundColor = .clear
        self._meal = meal
        self._isViewSearching = isViewSearching
        self._userSearch = userSearch
        self._mealTimingToggle = mealTimingToggle
    }
    
    var body: some View {
        if mealTimingToggle{
            List {
                Button(action: {
                    isViewSearching = false
                    userSearch = false
                    mealEntryObj.mealEntrysBreakfast.append(meal)
                    mealTimingToggle = false
                  
                }){
                    Text("Breakfast")
                }
                
                Button(action: {
                    isViewSearching = false
                    userSearch = false
                    mealEntryObj.mealEntrysLunch.append(meal)
                    mealTimingToggle = false
                }){
                    Text("Lunch")
                }
                    .listRowSeparator(.automatic)
                Button(action: {
                    isViewSearching = false
                    userSearch = false
                    mealEntryObj.mealEntrysDinner.append(meal)
                    mealTimingToggle = false
                }){
                    Text("Dinner")
                }
                    .listRowSeparator(.automatic)
            }
            .animation(.easeIn(duration:0.25))
            .frame(maxWidth: .infinity)
        }
    }
}
//struct MealTimingSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealTimingSelectorView()
//    }
//}
