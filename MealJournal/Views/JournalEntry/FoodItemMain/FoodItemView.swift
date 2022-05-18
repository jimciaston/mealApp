//
//  FoodItemView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/3/22.
//

import SwiftUI

struct FoodItemView: View {
    
    @EnvironmentObject var mealEntryObj: MealEntrys
    @StateObject var mealEntrys = MealEntrys()
    
    
    @Binding var meal: Meal
    @State private var mealTimingToggle = false
    @State private var sheetMode: SheetMode = .none
    @State var MealObject = Meal()
    @State var userSearch = false
    //when false, api results will not display
    @State var isViewSearching = false//sending to searchbar
    @State var extendedViewOpen = true
    @State var mealSelected = false
    
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
    var mealUnitSize: String {
        didSet {
            meal.servingSizeUnit
        }
        
    }
   
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading, spacing: 0){
                HStack{
                    Spacer()
                    Button(action: {
                        switch sheetMode {
                            case .none:
                                sheetMode = .mealTimingSelection
                            mealTimingToggle = true //meal timing list comes to view
                            case .mealTimingSelection:
                                sheetMode = .none
                            mealTimingToggle = false //list leaves view
                        case .quarter:
                            sheetMode = .none
                        }
                        MealObject = meal
                    }, label: {
                      Image(systemName: "checkmark").resizable()
                          .frame(width: 20, height: 20)
                          .multilineTextAlignment(.leading)
                          .font(.body)
                    })
                        .foregroundColor(.black)
                        .padding()
                }
                
                Text(String(mealName)) .bold()
                    .font(.title2)
                    .frame(maxWidth:.infinity)
                    .multilineTextAlignment(.center)
                
                Text(mealBrand)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                
                
                FoodItemInputs(mealUnitSize: .constant(mealUnitSize))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding()
                
                NutrionalPieChartView(values: [Double(mealFat),Double(mealProtein),Double(mealCarbs)], colors: [Color.blue, Color.green, Color.orange], names: ["Protein", "Carbohydrates", "Fats"], backgroundColor: .white)
                    .opacity(mealTimingToggle ? 0.0 : 1.0)
                   
                    Spacer()
                
            }
            .padding(.leading, 15)
        }
        
       
        if(mealTimingToggle){
            FlexibleSheet(sheetMode: $sheetMode) {
                MealTimingSelectorView(meal: $MealObject, isViewSearching: $isViewSearching, userSearch: $userSearch, mealTimingToggle: $mealTimingToggle, extendedViewOpen: $extendedViewOpen, mealSelected: $mealSelected)
                }
            
            ///when adjusting frame height for sheet, must adjust heights on flexible sheet and meal timing selector view or will display weird
            .frame(height:240)
            .foregroundColor(.black)
            //.animation(.easeInOut)
            }
           
    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemView(meal: .constant(Meal(id: UUID(), brand: "Jim", mealName: "Steak", calories: "Jim", quantity: 21, amount: "Jim", protein: 21, carbs: 21, fat: 21)), mealName: "Eggs", mealBrand: "Johns", mealCalories: "23", mealCarbs: 5, mealProtein: 4, mealFat: 4, mealUnitSize: "G")
    }
}
