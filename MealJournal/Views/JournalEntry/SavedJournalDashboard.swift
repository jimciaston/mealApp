//
//  SavedJournalDashboard.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/11/23.
//
//
import SwiftUI

struct SavedJournalDashboard: View {
    @State var isUserRemovingJournal = false
    @Environment (\.dismiss) var dismiss
    @ObservedObject var jm = JournalDashLogic()
    
    var id: String // << journal id
    
    
    func journalIDToDate(journalID: String) -> String {
        let dateString = journalID
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateInWords = dateFormatter.string(from: date!)
        
        return dateInWords
    }
    
   
    
    
    var body: some View {
        VStack{
//            MacroView(fetchEntryTotals: fetchEntryTotals)
//                .environmentObject(mealEntrys) //references meal entry
//            //fetch calorie totals
//                .onAppear{
//                    fetchEntryTotals.fetchCalorieTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
//                    fetchEntryTotals.fetchProteinTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
//                    fetchEntryTotals.fetchCarbTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
//                    fetchEntryTotals.fetchFatTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
//                }
            //search bar


               
            HStack(spacing: 0){



                // USER FAVORITING ENTRY, Star feature

                Button(action: {
                    print("deleting....")
                    jm.deleteJournalEntry(journalID: id)
                    dismiss()
                }){
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width:25, height: 30)
                        .padding(.leading, 280)
                        .padding(.bottom, 10)
                        .foregroundColor(.red)
                   
                        }
                    }
            Text(journalIDToDate(journalID: id))
                .bold()
            List {
                Section(header: Text("breakfast")
                        ){
                    ForEach(jm.userJournals, id: \.self) { meal in

                            if meal.mealTiming == "breakfast"{
                              EntryRowSavedDashboard(mealEntry: meal)
                            }
                        }
                        .onDelete{ offset in
                           // deleteJournalEntry(at: offset)
                        }
                    //show empty row if no meals match for timing
                    if !jm.userJournals.contains(where: { $0.mealTiming == "breakfast" }) {
                            Text("")
                        }
                    }

                    Section(header: Text("lunch")
                            ){

                            ForEach(jm.userJournals, id: \.self) { meal in

                                if meal.mealTiming == "lunch"{
                                    EntryRowSavedDashboard(mealEntry: meal)

                                }

                            }
                            .onDelete{ offset in
                             //   deleteJournalEntry(at: offset)
                            }
                        //show empty row if no meals match for timing
                        if !jm.userJournals.contains(where: { $0.mealTiming == "lunch" }) {
                                Text("")
                        }
                    }

                    Section(header:Text("Dinner")
                           ){
                        ForEach(jm.userJournals, id: \.self) { meal in
                            if meal.mealTiming == "dinner"{
                                EntryRowSavedDashboard(mealEntry: meal)

                            }


                        }
                        .onDelete{ offset in
                         //   deleteJournalEntry(at: offset)
                        }
                        //show empty row if no meals match for timing
                        if !jm.userJournals.contains(where: { $0.mealTiming == "dinner"}) {
                            Text("")
                        }
                    }

                    Section(header:Text("Snack")
                           ){
                        ForEach(jm.userJournals, id: \.self) { meal in

                            if meal.mealTiming == "snack"{
                                EntryRowSavedDashboard(mealEntry: meal)
                            }
                        }
                        .onDelete{ offset in
                           // deleteJournalEntry(at: offset)
                        }

                        //show empty row if no meals match for timing
                        if !jm.userJournals.contains(where: { $0.mealTiming == "snack"}) {
                            Text("")
                        }
                    }
            }
            .onAppear{
                    jm.grabUserJournals(journalID: id)
            }
        }
    }
}

struct SavedJournalDashboard_Previews: PreviewProvider {
    static var previews: some View {
        SavedJournalDashboard(id: "2")
    }
}
