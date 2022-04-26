//
//  DailyCaloriesCounter.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/23/22.
//

import SwiftUI

struct DailyMacrosCounter{
  
    func getFatTotals(breakfast: MealEntrys, lunch: MealEntrys, dinner: MealEntrys) -> String {
        var totalFats = 0
            for index in (0 ..< breakfast.mealEntrysBreakfast.count){
                totalFats += breakfast.mealEntrysBreakfast[index].fat ?? 0
                }
            for index in (0 ..< lunch.mealEntrysLunch.count){
                totalFats += breakfast.mealEntrysLunch[index].fat ?? 0
                }
            for index in (0 ..< dinner.mealEntrysDinner.count){
                totalFats += breakfast.mealEntrysDinner[index].fat ?? 0
                }
                
            return String(totalFats)
        
        }
    
}
//    func getFat() -> String {
//        var totalFats = 0
//
//        for index in (0 ..< mealEntrys.mealEntrysBreakfast.count){
//           print(mealEntrys.mealEntrysBreakfast[index] ?? "zero")
//       // nutrionalFats = totalFats
//        }
//
//        ///LUNCH
//        for index in (0 ..< mealEntrys.mealEntrysLunch.count){
//            totalFats += mealEntrys.mealEntrysLunch[index].fat ?? 2
//        }
//        for index in (0 ..< mealEntrys.mealEntrysDinner.count){
//            totalFats += mealEntrys.mealEntrysDinner[index].fat ?? 2
//        }
//
//        if(totalFats == 0){
//
//            return "Zero"
//        }
//        else{
//            let totalFatsString  = String(totalFats)
//
//            return totalFatsString
//        }
//    }
//
//    //grabs proteins from meal entrys and totals
//    func getProtein() -> String {
//        var totalProtein = 0
//        for index in (0 ..< mealEntrys.mealEntrysBreakfast.count){
//            totalProtein += mealEntrys.mealEntrysBreakfast[index].protein ?? 2
//        }
//        for index in (0 ..< mealEntrys.mealEntrysLunch.count){
//            totalProtein += mealEntrys.mealEntrysLunch[index].protein ?? 2
//        }
//        for index in (0 ..< mealEntrys.mealEntrysDinner.count){
//            totalProtein += mealEntrys.mealEntrysDinner[index].protein ?? 2
//        }
//
//        if(totalProtein == 0){
//           return "Zero"
//        }
//        else{
//            let totalProteinString  = String(totalProtein)
//            return totalProteinString
//        }
//    }
//
//    //grabs carbs from meal entrys and totals
//    func getCarbs() -> String {
//        var totalCarbs = 0
//
//        for index in (0 ..< mealEntrys.mealEntrysBreakfast.count){
//            totalCarbs += mealEntrys.mealEntrysBreakfast[index].carbs ?? 2
//        }
//        for index in (0 ..< mealEntrys.mealEntrysLunch.count){
//            totalCarbs += mealEntrys.mealEntrysLunch[index].carbs ?? 2
//        }
//        for index in (0 ..< mealEntrys.mealEntrysDinner.count){
//            totalCarbs += mealEntrys.mealEntrysDinner[index].carbs ?? 2
//        }
//
//        if(totalCarbs == 0){
//           return "Zero"
//        }
//        else{
//            let totalCarbsString  = String(totalCarbs)
//            return totalCarbsString
//        }
//    }
//}

/*
 function (mealarray, mealType
 
 
 
 
 
 */
