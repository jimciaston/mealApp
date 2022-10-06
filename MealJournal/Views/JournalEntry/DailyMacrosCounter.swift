//
//  DailyCaloriesCounter.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/23/22.
//

import SwiftUI

struct DailyMacrosCounter{
  
    func getCalorieTotals(breakfast: MealEntrys, lunch: MealEntrys, dinner: MealEntrys) -> String{
        var totalCals = 0
            for index in (0 ..< breakfast.mealEntrysBreakfast.count){
                totalCals += breakfast.mealEntrysBreakfast[index].calories ?? 0
                }
            for index in (0 ..< lunch.mealEntrysLunch.count){
                totalCals += lunch.mealEntrysLunch[index].calories ?? 0
                }
            for index in (0 ..< dinner.mealEntrysDinner.count){
                totalCals += dinner.mealEntrysDinner[index].calories ?? 0
                }
            return String(totalCals)
    }
    
    
    func getFatTotals(breakfast: MealEntrys, lunch: MealEntrys, dinner: MealEntrys) -> String {
        var totalFats = 0
            for index in (0 ..< breakfast.mealEntrysBreakfast.count){
                totalFats += breakfast.mealEntrysBreakfast[index].fat ?? 0
                }
            for index in (0 ..< lunch.mealEntrysLunch.count){
                totalFats += lunch.mealEntrysLunch[index].fat ?? 0
                }
            for index in (0 ..< dinner.mealEntrysDinner.count){
                totalFats += dinner.mealEntrysDinner[index].fat ?? 0
                }
            return String(totalFats)
        }
    func getProteinTotals(breakfast: MealEntrys, lunch: MealEntrys, dinner: MealEntrys) -> String {
        var totalProtein = 0
            for index in (0 ..< breakfast.mealEntrysBreakfast.count){
                totalProtein += breakfast.mealEntrysBreakfast[index].protein ?? 0
                }
            for index in (0 ..< lunch.mealEntrysLunch.count){
                totalProtein += lunch.mealEntrysLunch[index].protein ?? 0
                }
            for index in (0 ..< dinner.mealEntrysDinner.count){
                totalProtein += dinner.mealEntrysDinner[index].protein ?? 0
                }
            return String(totalProtein)
        }
    func getCarbTotals(breakfast: MealEntrys, lunch: MealEntrys, dinner: MealEntrys) -> String {
        var totalCarbs = 0
            for index in (0 ..< breakfast.mealEntrysBreakfast.count){
                totalCarbs += breakfast.mealEntrysBreakfast[index].carbs ?? 0
                }
            for index in (0 ..< lunch.mealEntrysLunch.count){
                totalCarbs += breakfast.mealEntrysLunch[index].carbs ?? 0
                }
            for index in (0 ..< dinner.mealEntrysDinner.count){
                totalCarbs += breakfast.mealEntrysDinner[index].carbs ?? 0
                }
            return String(totalCarbs)
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
