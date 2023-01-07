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
    @ObservedObject var fetchEntryTotals:  FetchEntryTotals
    var dailyMacrosCounter = DailyMacrosCounter()
    
    
    var body: some View {
       
        VStack{
            Text("Daily Macros")
                .font(.title2)
            
            HStack{
                VStack{
                    Text(String(fetchEntryTotals.totalCalories))
                    Text("Cals")
                        .padding(-5)
                   
                }
                .padding(20)
                VStack{
                   Text(String(fetchEntryTotals.totalProtein))
                       Text("Protein")
                        .padding(-5)
                }
                .padding(20)
               
                
                VStack{
                    Text(String(fetchEntryTotals.totalFat))
                         Text("Fat")
                        .padding(-5)
                }
                .padding(20)
                VStack{
                   Text(String(fetchEntryTotals.totalCarbs))
                    Text("Carbs")
                        .padding(-5)
                   
                }
                .padding(20)
            }
            .padding(.top, -15)
        }
        .foregroundColor(.black)
//        .onAppear{
//            fetchEntryTotals.totalCalories
//            fetchEntryTotals.totalProtein
//            fetchEntryTotals.totalFat
//            fetchEntryTotals.totalCarbs
//        }
    }
}

//struct MacroView_Previews: PreviewProvider {
//    static var previews: some View {
//        MacroView()
//    }
//}
