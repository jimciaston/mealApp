//
//  SavedJournalDashboard_NonUser.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/4/23.
//

import SwiftUI

struct SavedJournalDashboard_NonUser: View {
    @State var isUserRemovingJournal = false
    @Environment (\.dismiss) var dismiss
    @ObservedObject var jm: JournalDashLogicNonUser
    
    var id: String // << journal id
    var totalCalories: String
    var totalCarbs: String
    var totalFat: String
    var totalProtein: String
    var userUID: String
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

           MacroViewSavedJournals(totalCalories: totalCalories, totalProtein: totalProtein, totalCarbs: totalCarbs, totalFat: totalFat)
                .padding(.bottom, 10)
           //date of creation (ie. 01-18-2023)
            Text(journalIDToDate(journalID: id))
                .bold()
                .padding(.bottom, 5)
            List {
                Section(header: Text("breakfast")
                        ){
                    ForEach(jm.userJournalsNonUser, id: \.self) { meal in

                            if meal.mealTiming == "breakfast"{
                              EntryRowSavedDashboard(mealEntry: meal)
                            }
                        }
                      
                    //show empty row if no meals match for timing
                    if !jm.userJournalsNonUser.contains(where: { $0.mealTiming == "breakfast" }) {
                            Text("")
                        }
                    }

                    Section(header: Text("lunch")
                            ){

                            ForEach(jm.userJournalsNonUser, id: \.self) { meal in

                                if meal.mealTiming == "lunch"{
                                    EntryRowSavedDashboard(mealEntry: meal)

                                }

                            }
                            .onDelete{ offset in
                             //   deleteJournalEntry(at: offset)
                            }
                        //show empty row if no meals match for timing
                        if !jm.userJournalsNonUser.contains(where: { $0.mealTiming == "lunch" }) {
                                Text("")
                        }
                    }

                    Section(header:Text("Dinner")
                           ){
                        ForEach(jm.userJournalsNonUser, id: \.self) { meal in
                            if meal.mealTiming == "dinner"{
                                EntryRowSavedDashboard(mealEntry: meal)

                            }


                        }
                       
                        //show empty row if no meals match for timing
                        if !jm.userJournalsNonUser.contains(where: { $0.mealTiming == "dinner"}) {
                            Text("")
                        }
                    }

                    Section(header:Text("Snack")
                           ){
                        ForEach(jm.userJournalsNonUser, id: \.self) { meal in

                            if meal.mealTiming == "snack"{
                                EntryRowSavedDashboard(mealEntry: meal)
                            }
                        }
                       

                        //show empty row if no meals match for timing
                        if !jm.userJournalsNonUser.contains(where: { $0.mealTiming == "snack"}) {
                            Text("")
                        }
                    }
            }
            .onAppear{
                jm.grabUserJournals(journalID: id, userID: userUID) // << grab user recipes
            }
        }
       
    }
}

//struct SavedJournalDashboard_NonUser_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedJournalDashboard_NonUser()
//    }
//}
