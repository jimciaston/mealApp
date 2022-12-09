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
   
    @State var dayOfWeek: String = ""
    
  
    
    init(dayOfWeek : String){
        _existingJournalEntrys = FetchRequest <JournalEntry> (sortDescriptors: [], predicate: NSPredicate(format: "dayOfWeekCreated BEGINSWITH %@" , dayOfWeek))
        
    }
    
    
    var body: some View {
        List {
            if existingJournalEntrys.isEmpty{
                Section(header: Text(Sectionheader(secHead: "Breakfast"))
                            .foregroundColor(.black))
                {
                  Text("")
                }
                Section(header: Text(Sectionheader(secHead: "Lunch"))
                            .foregroundColor(.black))
                {
                  Text("")
                }
                Section(header: Text(Sectionheader(secHead: "Dinner"))
                            .foregroundColor(.black))
                {
                  Text("")
                }
            }
            else{
                Section(header: Text(Sectionheader(secHead: "Breakfast"))
                            .foregroundColor(.black))
                {
                    
                    ForEach(existingJournalEntrys, id: \.self ) { meal in
                        if meal.mealTiming == "breakfast"{
                            EntryRow(mealEntry: meal)
                        }
                        else{
                            Text("")
                        }
                    }
                    .onDelete{ offset in
                        deleteJournalEntry(at: offset)
                    }
                }
                
                Section(header: Text("lunch")
                        ){
                    
                        ForEach(existingJournalEntrys, id: \.self) { meal in
                           
                            if meal.mealTiming == "lunch"{
                                EntryRow(mealEntry: meal)
                            }
                            else{
                                Text("")
                            }
                                
                        }
                        .onDelete{ offset in
                            deleteJournalEntry(at: offset)
                        }
                }
                Section(header:Text("Dinner")
                       ){
                   
                    ForEach(existingJournalEntrys, id: \.self) { meal in
                    
                        if meal.mealTiming == "dinner"{
                            EntryRow(mealEntry: meal)
                        }
                        else{
                            Text("")
                        }
                            
                    }
                    .onDelete{ offset in
                        deleteJournalEntry(at: offset)
                    }
                }
            }
        }
            .listStyle(GroupedListStyle())
            .foregroundColor(.black)
    }
    //delete core data entry object of Journal Entry
    func deleteJournalEntry(at offsets: IndexSet) {
        for index in offsets {
            let entry = existingJournalEntrys[index]
            managedObjContext.delete(entry)
        }
        try? self.managedObjContext.save()
    }
    
    func Sectionheader(secHead: String) -> String {
        return secHead
    }
}

struct EntryList_Previews: PreviewProvider {
    static var previews: some View {
        EntryList(dayOfWeek: "Wednesday")
    }
}
