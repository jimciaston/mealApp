//
//  EntryRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/16/22.
//

import SwiftUI


//Struct that holds a entry row for each meal.

struct EntryRow: View {
    var meal: Meal
   
    var body: some View {
        let mealCalories = meal.calories ?? 0
        let mealCaloriesString = String(mealCalories)
        
        HStack{
                VStack(alignment: .leading){
                    Text(meal.mealName ?? "Default Value")
                        Text(meal.brand ?? "Default Value")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                           
                    }
                    Spacer()
                    Text(mealCaloriesString)
                }
            }
        }
