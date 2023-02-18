//
//  SavedJournalListNonUser.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/18/23.
//

import Foundation
import SwiftUI

struct SavedJournalsListNonUser: View {
    var savedJournalIDs: [String]
    @State var savedJournals: [UserJournalEntryHalf]
    var userUID: String
  
    @ObservedObject var jm = JournalDashLogicNonUser()
 
    var body: some View {
        NavigationView{
            VStack{
                Text("Saved Journals")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                List{
                    ForEach(savedJournals , id: \.id) { entry in
                        ZStack{
                            VStack (alignment: .leading){
                                HStack{
                                    Text(formatJournalID(journalID: entry.id) ?? "Unavailable").bold()
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
                                    

                            NavigationLink(destination: SavedJournalDashboard_NonUser(jm: jm, id: entry.id!, totalCalories: entry.totalCalories ?? "n/a", totalCarbs: entry.totalCarbs ?? "n/a", totalFat: entry.totalFat ?? "n/a", totalProtein: entry.totalProtein ?? "n/a", userUID: userUID), label: {
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
    func formatJournalID(journalID: String?) -> String {
            guard let journalID = journalID else { return "Unavailable" }
        //slice up journal ID to have hyphens ex: 05-01-2022
            return journalID.prefix(2) + "-" + journalID.suffix(6).prefix(2) + "-" + journalID.suffix(4)
        }
    }
