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
    
    @State var mealTimingToggle = false
    @State var meal: Meal
    @State private var sheetMode: SheetMode = .none
    //@State var MealObject = Meal()
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
     @State var mealCalories: Int {
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
    // or measurement ie. ounces, grams, etc
    var mealUnitSize: String {
        didSet {
            meal.servingSizeUnit
        }
    }
   
    @State var mealServingSize: Double {
        didSet{
            meal.servingSize
        }
    }
    @State var originalMealServingSize: Double { //<< don't touch, using for calculation of updated values
        didSet{
            meal.servingSize
        }
    }
    @Binding var dismissResultsView: Bool
    var foodCategory: String
    var body: some View {
        VStack{
                VStack(alignment:.leading, spacing: 0){
                    HStack{
                        //dismiss selected food view
                        Button(action: {
                           dismissResultsView = true
                           dismiss() //<< go back
                            //reappear row titles
                        })
                        {
                            Image("downloadB").resizable()
                                .frame(width: 40, height: 40)
                                .multilineTextAlignment(.leading)
                                .font(.body)
                                .padding(.leading, 25)
                        }
                        Spacer()
                           
                        //add recipe
                        Button(action: {
                            let updatedServingSize = mealServingSize / originalMealServingSize
                            meal = Meal(id: UUID(), brand: meal.brand, mealName: mealName, calories:  Int(Double(mealCalories) * mealServingSize), quantity: 1, amount: "g", protein: Int(Double(mealProtein) * mealServingSize), carbs: Int(Double(mealCarbs) * mealServingSize), fat: Int(Double(mealFat) * mealServingSize), servingSize: mealServingSize, servingSizeUnit: mealUnitSize)
                            
                            
                            
                            switch sheetMode {
                                case .none:
                                    sheetMode = .mealTimingSelection
                                withAnimation(.linear(duration: 0.25)) {
                                    mealTimingToggle = true //meal timing list comes to view
                                }
                               
                                case .mealTimingSelection:
                                    sheetMode = .none
                                mealTimingToggle = false //list leaves view
                            case .quarter:
                                sheetMode = .none
                            }
                           
                        
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
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                       
                    Text(mealBrand)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                      
                    
                    FoodItemInputs(mealUnitSize: .constant(mealUnitSize), mealServingSize: $mealServingSize, mealCalories: mealCalories, mealCarbs: mealCarbs, mealFat: mealFat, mealProtein: mealProtein, originalMealServingSize: originalMealServingSize, foodCategory: foodCategory)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding()
                    /*
                     -- Meal serving size automatically set to 1.0 on appear
                     -- when we update picker, we multiply each value of pie chart
                     
                     
                     */
                    NutrionalPieChartView(values: [
                        Double(mealProtein)  * mealServingSize,
                        Double(mealCarbs) * mealServingSize,
                        Double(mealFat) * mealServingSize
                      ],
                          colors: [Color.PieChart1, Color.PieChart2, Color.PieChart3], names: ["Protein", "Carbohydrates", "Fats"], backgroundColor: .white )
                            .opacity(mealTimingToggle ? 0.0 : 1.0)
                       
                 
                }
           //sometimes when loading serving size can be wonky, sets to one for easier calculations
                .onAppear{
                    mealServingSize = 1
                }
                
            
            .frame(minWidth: 400, maxHeight: .infinity)
            //get rid of that stupid space up top
            .navigationTitle("")
            .navigationBarHidden(true)
         

        }
        .blur(radius: mealTimingToggle ? 0.8 : 0 )
        ZStack {
            FlexibleSheet(sheetMode: $sheetMode) {
                MealTimingSelectorView(meal: $meal, isViewSearching: $isViewSearching, userSearch: $userSearch, mealTimingToggle: $mealTimingToggle, extendedViewOpen: $extendedViewOpen, mealSelected: $mealSelected)
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .padding(.top, -8) // moves snackbar info up in view
            .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
           
            // other views here
        }
    }
       
     
}

//struct FoodItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodItemView(meal: .constant(Meal(id: UUID(), brand: "Jim", mealName: "Steak", calories: 0, quantity: 21, amount: "Jim", protein: 21, carbs: 21, fat: 21)), mealName: "Eggs", mealBrand: "Johns", mealCalories: 0, mealCarbs: 5, mealProtein: 4, mealFat: 4, mealUnitSize: "G", mealServingSize: 10.0)
//    }
//}
