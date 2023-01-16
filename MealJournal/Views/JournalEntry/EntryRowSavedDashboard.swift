//
//  EntryRowSavedDashboard.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/12/23.
//

import SwiftUI

struct EntryRowSavedDashboard: View {
    var mealEntry: UserJournalEntry
   
    var body: some View {
       HStack {
                VStack(alignment: .leading){
                    Text(mealEntry.mealName ?? "Default Value")
                        Text("Default Value")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                           
                    }
                Spacer()
            
           Text(String(mealEntry.mealCalories))
            }
    }
}

//struct EntryRowSavedDashboard_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryRowSavedDashboard()
//    }
//}
