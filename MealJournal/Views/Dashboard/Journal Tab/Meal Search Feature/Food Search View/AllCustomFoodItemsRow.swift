//
//  AllCustomFoodItemsRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/28/22.
//

import SwiftUI

struct AllCustomFoodItemsRow: View {
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
//
//struct AllCustomFoodItemsRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCustomFoodItemsRow()
//    }
//}
