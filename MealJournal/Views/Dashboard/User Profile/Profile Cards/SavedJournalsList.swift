//
//  SavedJournalsList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/11/22.
//

import SwiftUI

struct SavedJournalsList: View {
    @Environment (\.colorScheme) var colorScheme
    @ObservedObject var jm = JournalDashLogic()
    var savedJournalIDs: [String]
    var savedJournals: [UserJournalEntry]
    
    var body: some View {
        
        if jm.userJournalsHalf.isEmpty{
            Text("No Journals Saved Yet")
        }
        else{
            NavigationView{
                VStack{
                    Text("Saved Journals")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .padding(.top, 25)
                    List{
                        ForEach(jm.userJournalsHalf , id: \.id) { entry in
                            ZStack{
                                VStack (alignment: .leading){
                                    HStack{
                                        Text(formatJournalID(journalID: entry.id) ?? "Unavailable")
                                            .bold()
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                        Text("Total Calories: \(entry.totalCalories ?? "Not Available")")
                                    .padding(.leading, 15)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    }
                                  
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 5)
                                    .padding(.top, 10)
                                        HStack{
                                            Text("Total Carbs: \(entry.totalCarbs ?? "n/a")")
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                                .font(.caption)
                                            Text("Total Fats: \(entry.totalFat ?? "n/a")")
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                                .font(.caption)
                                            Text("Total Protein: \(entry.totalProtein ?? "n/a")")
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                                .font(.caption)
                                        }
                                        .padding(.top, 3)
                                        .padding(.bottom, 10)
                                        .frame(maxWidth: .infinity)
                                    }
                                       
                                .background(colorScheme == .dark ? .gray : .white) // << main list background
                                        .cornerRadius(10)
                                      
                                        .padding(.bottom, 15)
                                        

                                NavigationLink(destination: SavedJournalDashboard(id: entry.id!, totalCalories: entry.totalCalories ?? "n/a", totalCarbs: entry.totalCarbs ?? "n/a", totalFat: entry.totalFat ?? "n/a", totalProtein: entry.totalProtein ?? "n/a"), label: {
                                        emptyview()
                                    })
                                   
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())
                                    }
                                }
                        .shadow(color: Color("LighterGray"), radius: 2, x: 0, y: 5)
                         .listRowSeparator(.hidden)
                         .listRowBackground(colorScheme == .dark ? .clear : Color("ListBackgroundColor")) // go back to dark t
                        
                        }
                   
                    }
               
              //  .background( Color("ListBackgroundColor")) // << background for saved Journals Title
                }
            }
        }
    
    //format journal id to date format
    func formatJournalID(journalID: String?) -> String {
            guard let journalID = journalID else { return "Unavailable" }
        //slice up journal ID to have hyphens ex: 05-01-2022
            return journalID.prefix(2) + "-" + journalID.suffix(6).prefix(2) + "-" + journalID.suffix(4)
        }
    }
       


struct SavedJournalsList_Previews: PreviewProvider {
    static var previews: some View {
        SavedJournalsList(savedJournalIDs: ["010201"], savedJournals: [UserJournalEntry(id: "1", mealName: "Bill", mealFat: 2, mealCarbs: 2, mealProtein: 2, mealCalories: 2, MealServing: 2, mealSaved: true, mealTiming: "3", dayOfWeek: "3", dateCreated: "2"),
                                                                       
       UserJournalEntry(id: "1", mealName: "Bill", mealFat: 2, mealCarbs: 2, mealProtein: 2, mealCalories: 2, MealServing: 2, mealSaved: true, mealTiming: "3", dayOfWeek: "3", dateCreated: "2"),
                                                                      
       UserJournalEntry(id: "1", mealName: "Bill", mealFat: 2, mealCarbs: 2, mealProtein: 2, mealCalories: 2, MealServing: 2, mealSaved: true, mealTiming: "3", dayOfWeek: "3", dateCreated: "2")
                                                                                                                                        ]
        )
    }
}
