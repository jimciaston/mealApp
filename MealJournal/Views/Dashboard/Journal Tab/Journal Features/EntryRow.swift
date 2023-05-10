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
    @Environment(\.colorScheme) var colorScheme
    var mealEntry: JournalEntry
    @Binding var isDeletable: Bool
    var body: some View {
        //   let mealCalories = meal.calories ?? 0
       // let mealCaloriesString = String(mealCalories)
        
        HStack{
                VStack(alignment: .leading){
                    Text(mealEntry.entryName ?? "Default Value")
                      
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("Default Value")
                            .font(.subheadline)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                           
                    }
                Spacer()
            
            Text(String(mealEntry.mealCalories ?? 0))
                .foregroundColor(colorScheme == .dark ? .white : .black)
            }
        
        .deleteDisabled(!isDeletable)
          }
        }
