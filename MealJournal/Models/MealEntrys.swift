//
//  MealEntrys.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/1/22.
//

import SwiftUI

class MealEntrys: ObservableObject{
    static let shared = MealEntrys()
    @Published var mealEntrysBreakfast: [Meal] = []
    @Published var mealEntrysLunch: [Meal] = []
    @Published var mealEntrysDinner: [Meal] = []
    
}
