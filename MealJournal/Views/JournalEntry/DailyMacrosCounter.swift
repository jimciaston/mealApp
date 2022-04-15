//
//  DailyCaloriesCounter.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/23/22.
//

import SwiftUI

class DailyMacrosCounter: ObservableObject{
    
    var mealEntrys = MealEntrys()
    
    init(){
        self.mealEntrys = MealEntrys()
    }
    
    func getFat() -> String {
        var totalFat = 0
        for index in (0 ..< mealEntrys.mealEntrysBreakfast.count){
            totalFat += mealEntrys.mealEntrysBreakfast[index].fat
        }
        for index in (0 ..< mealEntrys.mealEntrysLunch.count){
            totalFat += mealEntrys.mealEntrysLunch[index].fat
        }
        for index in (0 ..< mealEntrys.mealEntrysDinner.count){
            totalFat += mealEntrys.mealEntrysDinner[index].fat
        }
        
        if(totalFat == 0){
           return "Zero"
        }
        else{
            let totalFatString  = String(totalFat)
            return totalFatString
        }
    }
    
    //grabs proteins from meal entrys and totals
    func getProtein() -> String {
        var totalProtein = 0
        for index in (0 ..< mealEntrys.mealEntrysBreakfast.count){
            totalProtein += mealEntrys.mealEntrysBreakfast[index].protein
        }
        for index in (0 ..< mealEntrys.mealEntrysLunch.count){
            totalProtein += mealEntrys.mealEntrysLunch[index].protein
        }
        for index in (0 ..< mealEntrys.mealEntrysDinner.count){
            totalProtein += mealEntrys.mealEntrysDinner[index].protein
        }
        
        if(totalProtein == 0){
           return "Zero"
        }
        else{
            let totalProteinString  = String(totalProtein)
            return totalProteinString
        }
    }
    
    //grabs carbs from meal entrys and totals
    func getCarbs() -> String {
        var totalCarbs = 0
        
        for index in (0 ..< mealEntrys.mealEntrysBreakfast.count){
            totalCarbs += mealEntrys.mealEntrysBreakfast[index].carbs
        }
        for index in (0 ..< mealEntrys.mealEntrysLunch.count){
            totalCarbs += mealEntrys.mealEntrysLunch[index].carbs
        }
        for index in (0 ..< mealEntrys.mealEntrysDinner.count){
            totalCarbs += mealEntrys.mealEntrysDinner[index].carbs
        }
        
        if(totalCarbs == 0){
           return "Zero"
        }
        else{
            let totalCarbsString  = String(totalCarbs)
            return totalCarbsString
        }
    }
}

/*
 function (mealarray, mealType
 
 
 
 
 
 */
