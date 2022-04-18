//
//  MealEntrys.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/1/22.
//

import SwiftUI

public class MealEntrys: ObservableObject{
    var mealEntrysBreakfast: [Meal] = [
        Meal(id: UUID(), brand: "Liquid Death", mealName: "Fish", calories: "250", quantity: 4, amount: "34", protein: 25, carbs: 8, fat: 33),
        Meal(id: UUID(), brand: "ABC Foods", mealName: "Eggs", calories: "250", quantity: 4, amount: "34", protein: 0, carbs: 8, fat: 33),
    ]
    let mealEntrysLunch: [Meal] = [
        Meal(id: UUID(), brand: "blah blah Selena Gomez", mealName: "Eggs", calories: "50", quantity: 4, amount: "34", protein: 0, carbs: 8, fat: 33),
    ]
    let mealEntrysDinner: [Meal] = []
}
