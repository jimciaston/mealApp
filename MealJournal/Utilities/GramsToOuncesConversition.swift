//
//  GramsToOuncesConversition.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/15/22.
//

import Foundation


/*
 take gram amount etc 28g
 see how long it takes to get to 4 oz ( if meat food category )
 times protein, fat, carb amounts
 
 
 */

//convert macros in accordance to serving size
//food api only gives at 100 gram does, not serving size (so stupid)

func convertMacros(macro: Double, servingSize: Double, unitSizing: String?) -> Double{
    /*
     noting food api is tricky with their calculations
     If dividing by 100, we are converting because api returned calories as grams (odd)
     */
    
    
    let servingSizePercentage: Double // << will hold calories
    //if generic brand, just return total calories
    if unitSizing == nil {
        servingSizePercentage = servingSize // << returning calories
    } else {
        // if we have to calculate from api
        servingSizePercentage = servingSize / 100 // << divide by default grams value
    }
    let macroConversion = macro * servingSizePercentage
    let macroConverted = round(macroConversion)
    return macroConverted
}

func OuncesConversion(gramsMeasurement: Double, measurementUnit: String) -> String{
    if measurementUnit == "g"{ // << only run conversion for gram serving units
        var gramsConversion = gramsMeasurement / 28.35
        let gramConverted = Int(Double(round(gramsConversion))) // << remove zeros in double
        return String(gramConverted)
        
    }
    //convert milligrams
    if measurementUnit == "ml"{
        var millConversion = gramsMeasurement / 29.574
        let millConverted = Int(Double(round(millConversion)))
        return String(millConverted)
    }
    
    else{
        print("Not a gram unit size")
        return "n/a"
    }
}
