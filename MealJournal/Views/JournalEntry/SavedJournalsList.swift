//
//  SavedJournalsList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/11/22.
//

import SwiftUI

struct SavedJournalsList: View {
    var savedJournalIDs: [String]
    var savedJournals: [UserJournalEntry]
    @State var entryID = ""
    @ObservedObject var jm = JournalDashLogic()
 
    var body: some View {
        NavigationView{
            VStack{
                Text("Saved Journals")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                List{
                    ForEach(jm.userJournalsHalf , id: \.id) { entry in
                        ZStack{
                            VStack (alignment: .leading){
                                HStack{
                                    Text(entry.id ?? "Unavailable").bold()
                                    Text("Total Calories: \(entry.totalCalories ?? "Not Available")")
                                .padding(.leading, 15)
                                }
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 5)
                                .padding(.top, 10)
                                    HStack{
                                        Text("Total Carbs: \(entry.totalCarbs ?? "n/a")")
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                        Text("Total Fats: \(entry.totalFat ?? "n/a")")
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                        Text("Total Protein: \(entry.totalProtein ?? "n/a")")
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                    }
                                    .padding(.top, 3)
                                    .padding(.bottom, 10)
                                    .frame(maxWidth: .infinity)
                                }
                                    
                                    .listRowBackground( Color("ListBackgroundColor"))
                                    .background(.white)
                                    .cornerRadius(25)
                                    .shadow(color: Color("LighterGray"), radius: 2, x: 0, y: 8)
                                    .padding(.bottom, 15)
                                    

                            NavigationLink(destination: SavedJournalDashboard(id: entry.id!), label: {
                                    emptyview()
                                })
                               
                                .opacity(0.0)
                                .buttonStyle(PlainButtonStyle())
                                }
                            }
                    
                     .listRowSeparator(.hidden)
                      .listRowBackground( Color("ListBackgroundColor"))
                    
                    }
               
                }
           
            .background( Color("ListBackgroundColor")) // << background for saved Journals Title
            }
           
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
