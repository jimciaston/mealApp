//
//  MealEntrys.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/1/22.
//

import SwiftUI

class MealEntrys: ObservableObject{
    @Published var mealEntrysBreakfast: [Meal] = []
    let mealEntrysLunch: [Meal] = [
       
    ]
    let mealEntrysDinner: [Meal] = []
}
