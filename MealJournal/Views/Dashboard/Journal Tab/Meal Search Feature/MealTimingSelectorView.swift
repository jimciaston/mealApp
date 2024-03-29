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
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var mealEntryObj: MealEntrys
    @StateObject var userJournalHelper = UserJournalHelper()
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @Binding var meal: Meal
    @Binding var isViewSearching: Bool
    @Binding var userSearch: Bool
    @Binding var mealTimingToggle: Bool
    @Binding var extendedViewOpen: Bool
    @Binding var mealSelected: Bool
    @ObservedObject var dashboardRouter = DashboardRouter()
    init(meal: Binding<Meal>, isViewSearching: Binding<Bool>, userSearch: Binding<Bool>, mealTimingToggle: Binding<Bool>, extendedViewOpen: Binding<Bool>, mealSelected: Binding<Bool>){
        ///commented the view color out for now, as it was having a weird effect on the journalEntryMain list. 
        UITableView.appearance().backgroundColor = UIColor(Color("LightWhite"))
        self._meal = meal
        self._isViewSearching = isViewSearching
        self._userSearch = userSearch
        self._mealTimingToggle = mealTimingToggle
        self._extendedViewOpen = extendedViewOpen
        self._mealSelected = mealSelected
    }
    
    var body: some View {
        if mealTimingToggle{
            VStack{
                HStack{
                    Button(action: {
                        mealTimingToggle = false
                        mealSelected = false
                    }){
                        Image(systemName: "x.square")
                          
                                .font(.title3)
                                .frame(width:20)
                                .padding(.leading, 50)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    
                    Text("Meal Timing")
                        .padding(.leading, -100)
                        .listRowSeparator(.hidden)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                   
                }
                .padding(.bottom, 30)
                .padding(.top, 20)
                .background(Color.white)
                
                //breakfast, lunch, dinner selectors
                List {
                    Button(action: {
                        //save journal entry
                        UserJournalHelper().saveJournalEntry(
                            entryBrand: meal.brand ?? "Generic",
                            entryName: meal.mealName ?? "Default",
                            mealTiming: "breakfast",
                            dayOfWeekCreated: weekdayAsString(date: CalendarHelper().currentDay),
                            context: managedObjContext,
                            entryCalories: Int16(meal.calories ?? 0),
                            entryProtein: Int16(meal.protein ?? 0 ),
                            entryFat: Int16(meal.fat ?? 0),
                            entryCarbs: Int16(meal.carbs ?? 0), totalCalories: "testing")
                        
                        isViewSearching = false
                        userSearch = false
                        mealEntryObj.mealEntrysBreakfast.append(meal)
                        mealTimingToggle = false
                        mealSelected = true //user selected a meal
                      
                        if(extendedViewOpen){
                            mealSelected = true
                            dismiss()
                        }
                      
                    }){
                        Text("Breakfast")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    Button(action: {
                        
                        UserJournalHelper().saveJournalEntry(
                            entryBrand: meal.brand ?? "Generic",
                            entryName: meal.mealName ?? "Default",
                            mealTiming: "lunch",
                            dayOfWeekCreated: weekdayAsString(date: CalendarHelper().currentDay),
                            context: managedObjContext,
                            entryCalories: Int16(meal.calories ?? 0),
                            entryProtein: Int16(meal.protein ?? 0 ),
                            entryFat: Int16(meal.fat ?? 0),
                            entryCarbs: Int16(meal.carbs ?? 0), totalCalories: "testing")
                        isViewSearching = false
                        userSearch = false
                        mealEntryObj.mealEntrysLunch.append(meal)
                        mealTimingToggle = false
                        mealSelected = true //user selected a meal
                      
                        if(extendedViewOpen){
                            mealSelected = true
                            dismiss()
                        }
                    }){
                        Text("Lunch")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                        .listRowSeparator(.automatic)
                    
                    Button(action: {
                        
                        UserJournalHelper().saveJournalEntry(
                            entryBrand: meal.brand ?? "Generic",
                            entryName: meal.mealName ?? "Default",
                            mealTiming: "dinner",
                            dayOfWeekCreated: weekdayAsString(date: CalendarHelper().currentDay),
                            context: managedObjContext,
                            entryCalories: Int16(meal.calories ?? 0),
                            entryProtein: Int16(meal.protein ?? 0 ),
                            entryFat: Int16(meal.fat ?? 0),
                            entryCarbs: Int16(meal.carbs ?? 0), totalCalories: "testing")
                        
                        isViewSearching = false
                        userSearch = false
                        mealEntryObj.mealEntrysDinner.append(meal)
                        mealTimingToggle = false
                        mealSelected = true //user selected a meal
                        
                        if(extendedViewOpen){
                            mealSelected = true
                            dismiss()
                        }
                    }){
                        Text("Dinner")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    Button(action: {
                        
                        UserJournalHelper().saveJournalEntry(
                            entryBrand: meal.brand ?? "Generic",
                            entryName: meal.mealName ?? "Default",
                            mealTiming: "snack",
                            dayOfWeekCreated: weekdayAsString(date: CalendarHelper().currentDay),
                            context: managedObjContext,
                            entryCalories: Int16(meal.calories ?? 0),
                            entryProtein: Int16(meal.protein ?? 0 ),
                            entryFat: Int16(meal.fat ?? 0),
                            entryCarbs: Int16(meal.carbs ?? 0), totalCalories: "testing")
                        
                        isViewSearching = false
                        userSearch = false
                        mealEntryObj.mealEntrysSnack.append(meal)
                        mealTimingToggle = false
                        mealSelected = true //user selected a meal
                        
                        if(extendedViewOpen){
                            mealSelected = true
                            dismiss()
                        }
                      
                    }){
                        Text("Snack")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                        .listRowSeparator(.automatic)
                }
                .padding(.top, -25)
                .frame(maxWidth: .infinity)
            }
          
            .frame(height:660)
            .padding(.top, -80)
            .background(Color("ButtonTwo"))
        }
           
    }
       
}
struct MealTimingSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        MealTimingSelectorView(meal: .constant(Meal(id: UUID(), brand: "Jim", mealName: "Jim", calories: 0, quantity: 21, amount: "Jim", protein: 21, carbs: 21, fat: 21)), isViewSearching: .constant(true), userSearch: .constant(true), mealTimingToggle: .constant(true), extendedViewOpen: .constant(true), mealSelected: .constant(true))
}
}
