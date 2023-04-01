//
//  EntryList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/7/22.
//

import SwiftUI

struct EntryList: View {
    @Environment(\.managedObjectContext) var managedObjContext
    
    @FetchRequest var existingJournalEntrys: FetchedResults <JournalEntry>
    @ObservedObject var fetchEntryTotals: FetchEntryTotals
    @State var dayOfWeek: String = ""
    @State var permDay: String = ""
    //Setting all macros to 0 at beginning of app launch
    @State var totalCals = 0
    @State var totalProtein = 0
    @State var totalCarbs = 0
    @State var totalFat = 0
    @Binding var isDeletable: Bool
    @Binding var isExistingJournalEntrysEmpty: Bool
 
    
    
    init(dayOfWeek : String, fetchEntryTotals: FetchEntryTotals, isDeletable: Binding<Bool>, isExistingJournalEntrysEmpty: Binding<Bool>){
        _existingJournalEntrys = FetchRequest <JournalEntry> (sortDescriptors: [], predicate: NSPredicate(format: "dayOfWeekCreated BEGINSWITH %@" , dayOfWeek))
        
       self.fetchEntryTotals = fetchEntryTotals
        self._isDeletable = isDeletable
        self._isExistingJournalEntrysEmpty = isExistingJournalEntrysEmpty
       
    }
    
    //grab total Calories
    func fetchCalorieTotals() {
        fetchEntryTotals.totalCalories = 0
        for entry in existingJournalEntrys {
            totalCals += Int(entry.mealCalories!)
        }
        fetchEntryTotals.totalCalories = totalCals
    }
    func fetchProteinTotals() {
        fetchEntryTotals.totalProtein = 0
        for entry in existingJournalEntrys {
            totalProtein += Int(entry.mealProtein!)
        }
        fetchEntryTotals.totalProtein = totalProtein
    }
    func fetchCarbTotals() {
        fetchEntryTotals.totalCarbs = 0
        for entry in existingJournalEntrys {
            totalCarbs += Int(entry.mealCarbs!)
        }
        fetchEntryTotals.totalCarbs = totalCarbs
    }
    func fetchFatTotals() {
        fetchEntryTotals.totalFat = 0
        for entry in existingJournalEntrys {
            totalFat += Int(entry.mealFat!)
        }
        fetchEntryTotals.totalFat = totalFat
    }
    var body: some View {
        
        List {
            Section(header: Text("breakfast")
                    ){
                    ForEach(existingJournalEntrys, id: \.self) { meal in
                        
                        if meal.mealTiming == "breakfast"{
                            EntryRow(mealEntry: meal, isDeletable: $isDeletable)
                                .onTapGesture {
                                    print(isDeletable)
                                }
                        }
                    }
                    .onDelete{ offset in
                        deleteJournalEntry(at: offset)
                    }
                //show empty row if no meals match for timing
                if !existingJournalEntrys.contains(where: { $0.mealTiming == "breakfast" }) {
                        Text("")
                    }
                }
               
                Section(header: Text("lunch")
                        ){
                    
                        ForEach(existingJournalEntrys, id: \.self) { meal in
                           
                            if meal.mealTiming == "lunch"{
                                EntryRow(mealEntry: meal, isDeletable: $isDeletable)
                                   
                            }
                           
                        }
                        .onDelete{ offset in
                            deleteJournalEntry(at: offset)
                        }
                    //show empty row if no meals match for timing
                    if !existingJournalEntrys.contains(where: { $0.mealTiming == "lunch" }) {
                            Text("")
                    }
                }
                
                Section(header:Text("Dinner")
                       ){
                    ForEach(existingJournalEntrys, id: \.self) { meal in
                        if meal.mealTiming == "dinner"{
                            EntryRow(mealEntry: meal, isDeletable: $isDeletable)
                              
                        }
                            
                            
                    }
                    .onDelete{ offset in
                        deleteJournalEntry(at: offset)
                    }
                    //show empty row if no meals match for timing
                    if !existingJournalEntrys.contains(where: { $0.mealTiming == "dinner"}) {
                        Text("")
                    }
                }
                
                Section(header:Text("Snack")
                       ){
                    ForEach(existingJournalEntrys, id: \.self) { meal in
                    
                        if meal.mealTiming == "snack"{
                            EntryRow(mealEntry: meal, isDeletable: $isDeletable)
                        }
                    }
                    .onDelete{ offset in
                        deleteJournalEntry(at: offset)
                    }
                    
                    //show empty row if no meals match for timing
                    if !existingJournalEntrys.contains(where: { $0.mealTiming == "snack"}) {
                        Text("")
                    }
                }
        }
        
        .onAppear{
            //fetch macros
            fetchCalorieTotals()
            fetchProteinTotals()
            fetchCarbTotals()
            fetchFatTotals()
            
           //disable delete if not current day
           
        }
       
        .listStyle(GroupedListStyle())
        .background(Color("ListBackgroundColor")) // do not change, background acts funky without this.
        .foregroundColor(.black)
    }
    //delete core data entry object of Journal Entry
    func deleteJournalEntry(at offsets: IndexSet) {
        for index in offsets {
            let entry = existingJournalEntrys[index]
            
            //subtract out entryTotals from daily macros
            fetchEntryTotals.totalCalories -= Int(entry.mealCalories!)
            fetchEntryTotals.totalCarbs -= Int(entry.mealCarbs!)
            fetchEntryTotals.totalProtein -= Int(entry.mealProtein!)
            fetchEntryTotals.totalFat -= Int(entry.mealFat!)
            
            //delete from core data
            managedObjContext.delete(entry)
           
        }
        try? self.managedObjContext.save()
       
    }
    
    func Sectionheader(secHead: String) -> String {
        return secHead
    }
}

//struct EntryList_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryList(dayOfWeek: "Wednesday")
//    }
//}
