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
                .onTapGesture {
                    print(mealEntry.timeToLive)
                }
                Spacer()
            
            Text(String(mealEntry.mealCalories ?? 0))
            }
        
        .deleteDisabled(!isDeletable)
          }
        }
