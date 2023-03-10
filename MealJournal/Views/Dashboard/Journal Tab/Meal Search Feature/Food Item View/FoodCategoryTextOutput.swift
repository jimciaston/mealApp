//
//  FoodCategoryTextOutput.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/8/23.
//

import Foundation
import SwiftUI

struct FoodCategoryText: View {
    let foodCategory: String
    let gramsMeasurement: Double
    let measurementUnit: String
    let calories: Int
    var body: some View {
        switch true {
            case foodCategory.contains("Pizza"):
                Text("Item")
            
            case foodCategory.contains("Eggs"):
                Text("Egg")
        
        case foodCategory.contains("Breads"):
            Text("Slice")
            
            default:
            //default conversion to ounces
                Text(OuncesConversion(gramsMeasurement: gramsMeasurement, measurementUnit: measurementUnit))
            }
    }
       
}
