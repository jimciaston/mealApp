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
    
    
    @State var meal: Meal
    @Binding var mealTimingToggle: Bool
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
    @Binding var dismissResultsView: Bool
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment:.leading, spacing: 0){
                HStack{
                    //dismiss selected food view
                    Button(action: {
                        dismiss() //<< go back
                        //reappear row titles
                        
                       
                    })
                    {
                        Image(systemName: "arrowshape.turn.up.backward.fill").resizable()
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
                    .padding(.top, -30)
                Text(mealBrand)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                  
                
                FoodItemInputs(mealUnitSize: .constant(mealUnitSize), mealServingSize: Binding.constant(mealServingSize))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding()
                
                NutrionalPieChartView(values: [
                    Double(mealProtein),
                    Double(mealCarbs),
                    Double(mealFat)
                  ],
                  colors: [Color.PieChart1, Color.PieChart2, Color.PieChart3], names: ["Protein", "Carbohydrates", "Fats"], backgroundColor: .white )
                        .opacity(mealTimingToggle ? 0.0 : 1.0)
            }
            .padding(.leading, 15)
            
        }
        .frame(minWidth: 400, maxHeight: 600)
        //get rid of that stupid space up top
        .navigationTitle("")
        .navigationBarHidden(true)
           
           
    }
       
     
}

//struct FoodItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodItemView(meal: .constant(Meal(id: UUID(), brand: "Jim", mealName: "Steak", calories: 0, quantity: 21, amount: "Jim", protein: 21, carbs: 21, fat: 21)), mealName: "Eggs", mealBrand: "Johns", mealCalories: 0, mealCarbs: 5, mealProtein: 4, mealFat: 4, mealUnitSize: "G", mealServingSize: 10.0)
//    }
//}
