//
//  MacroViewSavedJournals.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/16/23.
//

import SwiftUI

struct MacroViewSavedJournals: View {
    
    var totalCalories: String
    var totalProtein: String
    var totalCarbs: String
    var totalFat: String
    
    var dailyMacrosCounter = DailyMacrosCounter()
    
    
    var body: some View {
        VStack{
            Text("Daily Macros")
                .font(.title2)
            
            HStack{
                VStack{
                    Text(String(totalCalories))
                    Text("Cals")
                        .padding(-5)
                   
                }
                .padding(20)
                VStack{
                    Text(String(totalCarbs))
                       Text("Carbs")
                        .padding(-5)
                }
                .padding(20)
               
                
                VStack{
                    Text(String(totalFat))
                         Text("Fat")
                        .padding(-5)
                }
                .padding(20)
                VStack{
                    Text(String(totalProtein))
                    Text("Protein")
                        .padding(-5)
                   
                }
                .padding(20)
            }
            .padding(.top, -15)
        }
        .foregroundColor(.black)
    }
}

//
//struct MacroViewSavedJournals_Previews: PreviewProvider {
//    static var previews: some View {
//        MacroViewSavedJournals()
//    }
//}
