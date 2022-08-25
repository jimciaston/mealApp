//
//  MacroView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/27/22.
//

import SwiftUI
import Foundation

struct MacroView: View {
    @EnvironmentObject var mealEntryObj: MealEntrys
    
    var dailyMacrosCounter = DailyMacrosCounter()
    
  
    var body: some View {
        let dailyA = Double(dailyMacrosCounter.getCarbTotals(
            breakfast: mealEntryObj,
            lunch: mealEntryObj,
            dinner: mealEntryObj))
        VStack{
            Text("Daily Macros")
                .font(.title2)
            
            HStack{
                VStack{
                   Text(dailyMacrosCounter.getCarbTotals(
                    breakfast: mealEntryObj,
                    lunch: mealEntryObj,
                    dinner: mealEntryObj)
                        )
                    Text("Carbs")
                        .padding(-5)
                   
                }
                .padding(30)
                
                VStack{
                    Text(dailyMacrosCounter.getFatTotals(
                            breakfast: mealEntryObj,
                            lunch: mealEntryObj,
                            dinner: mealEntryObj)
                        )
                         Text("Fat")
                        .padding(-5)
                }
                .padding(30)
                VStack{
                   Text(dailyMacrosCounter.getProteinTotals(
                    breakfast: mealEntryObj,
                    lunch: mealEntryObj,
                    dinner: mealEntryObj))
                       Text("Protein")
                        .padding(-5)
                }
                .padding(30)
            }
            .padding(.top, -15)
        }
        .foregroundColor(.black)
    }
}

struct MacroView_Previews: PreviewProvider {
    static var previews: some View {
        MacroView()
    }
}
