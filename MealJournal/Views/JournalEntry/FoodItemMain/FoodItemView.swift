//
//  FoodItemView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/3/22.
//

import SwiftUI

struct FoodItemView: View {
    @Binding var meal: Meal
    
    var mealName: String {
        didSet {
               meal.mealName
            }
    }
    var mealBrand: String {
        didSet {
               meal.brand
            }
    }
    var mealCalories: String {
        didSet {
                meal.calories
            }
    }
    var mealCarbs: Int {
        didSet {
            meal.carbs
        }
    }
    var mealProtein: Int {
        didSet {
            meal.protein
        }
    }
    var mealFat: Int {
        didSet {
            meal.fat
        }
    }
 
    var body: some View {
        
        VStack(alignment:.leading){
            Text(String(mealName)) .bold()
                .font(.title2)
                .padding(.top, 50)
                .frame(maxWidth:.infinity)
                .multilineTextAlignment(.center)
            
            Text(mealBrand)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
            
            NutrionalPieChartView(values: [Double(mealFat),Double(mealProtein),Double(mealCarbs)], colors: [Color.blue, Color.green, Color.orange], names: ["Protein", "Carbohydrates", "Fats"], backgroundColor: .white)
            
                Spacer()
            
        }
        .padding(.leading, 15)
        
    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemView(meal: .constant(Meal(id: UUID(), brand: "Jim", mealName: "Steak", calories: "Jim", quantity: 21, amount: "Jim", protein: 21, carbs: 21, fat: 21)), mealName: "Eggs", mealBrand: "Johns", mealCalories: "23", mealCarbs: 5, mealProtein: 4, mealFat: 4)
    }
}
