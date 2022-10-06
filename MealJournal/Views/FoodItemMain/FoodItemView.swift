//
//  FoodItemView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/3/22.
//

import SwiftUI

struct FoodItemView: View {
    @Environment (\.dismiss) var dismiss
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
    var mealCalories: Int {
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
   
    var mealServingSize: Double {
        didSet{
            meal.servingSize
        }
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading, spacing: 0){
                HStack{
                    //dismiss selected food view
                    Button(action: {
                        dismiss() //<< go back
                    })
                    {
                        Image(systemName: "xmark").resizable()
                            .frame(width: 20, height: 20)
                            .multilineTextAlignment(.leading)
                            .font(.body)
                    }
                    Spacer()
                    //add recipe
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
                    .onAppear{
                        print(OuncesConversion(gramsMeasurement: mealServingSize, measurementUnit: mealUnitSize))
                        print("total servings" + mealUnitSize)
                        print("meal calories" + String(mealCalories))
                        print("meal protein" + String(mealProtein))
                        print("meal carbs" + String(mealCarbs))
                        print("meal fat" + String(mealFat))
                        print("meal serving size" + String(mealServingSize))
                    }
                
                FoodItemInputs(mealUnitSize: .constant(mealUnitSize), mealServingSize: Binding.constant(mealServingSize))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding()
                
                NutrionalPieChartView(values: [
                    Double(mealProtein),
                    Double(mealCarbs),
                    Double(mealFat)
                  ],
                  colors: [Color.blue, Color.green, Color.orange], names: ["Protein", "Carbohydrates", "Fats"], backgroundColor: .white )
                        .opacity(mealTimingToggle ? 0.0 : 1.0)
            }
            .padding(.leading, 15)
        }
        //get rid of that stupid space up top
        .navigationTitle("")
        .navigationBarHidden(true)
       
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
        FoodItemView(meal: .constant(Meal(id: UUID(), brand: "Jim", mealName: "Steak", calories: 0, quantity: 21, amount: "Jim", protein: 21, carbs: 21, fat: 21)), mealName: "Eggs", mealBrand: "Johns", mealCalories: 0, mealCarbs: 5, mealProtein: 4, mealFat: 4, mealUnitSize: "G", mealServingSize: 10.0)
    }
}
