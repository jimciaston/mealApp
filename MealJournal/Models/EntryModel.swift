//
//  Entrys.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/15/22.
//

import SwiftUI

//Struc that holds meal information - will update with api shortly

struct Meal: Identifiable, Hashable{
    var id = UUID()
    var brand: String?
    var mealName: String?
    var calories: Int?
    var quantity: Int?
    var amount: String?
    var protein:  Int?
    var carbs: Int?
    var fat: Int?
    var servingSize: Double?
    var servingSizeUnit: String?
}
