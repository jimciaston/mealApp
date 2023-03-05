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
    var totalCalories: String
    var totalCarbs: String
    var totalFat: String
    var totalProtein: String
    //Adding hyphens to date, ex: 01-14-2022
    func journalIDToDate(journalID: String) -> String {
        
        
        let dateString = journalID
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            let dateInWords = dateFormatter.string(from: date)
            return dateInWords
        } else {
            // Handle the case where date is nil
            return "Invalid date"
        }
    }
    
    var body: some View {
        VStack{
            
            Button(action: {
                print("deleting....")
                jm.deleteJournalEntry(journalID: id)
                dismiss()
            }){
                Image(systemName: "trash")
                    .resizable()
                    .frame(width:20, height: 25)
                    .padding(.leading, 280)
                    .foregroundColor(.red)
                    }

           MacroViewSavedJournals(totalCalories: totalCalories, totalProtein: totalProtein, totalCarbs: totalCarbs, totalFat: totalFat)
                .padding(.bottom, 10)
           //date of creation (ie. 01-18-2023)
            Text(journalIDToDate(journalID: id))
                .bold()
                .padding(.bottom, 5)
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
        SavedJournalDashboard(id: "2", totalCalories: "2", totalCarbs: "2", totalFat: "2", totalProtein: "2")
    }
}
