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
        let mealCalories = meal.calories
        let mealCaloriesString = String(mealCalories ?? "Default Value")
        
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
