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
    
    var body: some View {
        switch true {
            case foodCategory.contains("Pizza"):
                Text("1 slice")
            
            case foodCategory.contains("Eggs"):
                Text("1 egg")
        
            default:
            //default conversion to ounces 
                Text(OuncesConversion(gramsMeasurement: gramsMeasurement, measurementUnit: measurementUnit))
            }
    }
}
