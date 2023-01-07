//
//  EntryRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/16/22.
//

import SwiftUI


//Struct that holds a entry row for each meal.

struct EntryRow: View {
  //  var meal: Meal
    var mealEntry: JournalEntry
    @Binding var isDeletable: Bool
    var body: some View {
        //   let mealCalories = meal.calories ?? 0
       // let mealCaloriesString = String(mealCalories)
        
        HStack{
                VStack(alignment: .leading){
                    Text(mealEntry.entryName ?? "Default Value")
                        Text("Default Value")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                           
                    }
                Spacer()
            
            Text(String(mealEntry.mealCalories!))
            }
        
        .deleteDisabled(!isDeletable)
          }
        }
