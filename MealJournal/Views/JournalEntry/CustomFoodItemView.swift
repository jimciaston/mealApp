//
//  CustomFoodItemView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/22/22.
//

import SwiftUI

struct CustomFoodItemView: View {
    @EnvironmentObject var mealEntryObj: MealEntrys
    @State private var isFoodNameValid = true
    @State var foodName = ""
    @State var caloriesAmount = 100 // << set a little higher since calories will usually be more
    @State var proteinAmount = 1
    @State var carbAmount = 1
    @State var fatAmount = 1
    @Binding var showing: Bool
    @Binding var isViewSearching: Bool // << ties to preview view
    @Binding var userSearch: Bool // << ties to preview view
    @State private var timer: Timer?
    @State private var mealTimingSelection = mealTimingOptions.breakfast
    @ObservedObject var saveItem = SaveCustomFoodItem()
    
    enum mealTimingOptions: String, CaseIterable, Identifiable {
        case breakfast
        case lunch
        case dinner
        
        var id: String { self.rawValue }
    }
    var foodNamePrompt: String {
        if !isFoodNameValid {
            return "Please enter food name"
        }
        else{
            return ""
        }
    }
    
    var body: some View {
            VStack{
                //make sure to add alert if no name has been entered
                Text("Enter Food Name")
                TextField("", text: $foodName)
                   // .multilineTextAlignment(.center)
                    .border(.white)
                    .padding(.trailing, 10)
                    .frame(width:100, height:10)
                Text(foodNamePrompt)
                    .font(.caption)
                    .foregroundColor(.red)
                CustomFoodHStacks(macroAmount: $caloriesAmount, macroName: "Calories")
                CustomFoodHStacks(macroAmount: $proteinAmount , macroName: "Protein")
                CustomFoodHStacks(macroAmount: $carbAmount, macroName: "Carbohydrates")
                CustomFoodHStacks(macroAmount: $fatAmount, macroName: "Fat")
                
                // breakfast, lunch or dinner
//                Picker("Meal Selection", selection: $mealTimingSelection){
//                    ForEach(mealTimingOptions.allCases){ selection in
//                        Text(selection.rawValue.capitalized)
//                            .tag(selection)
//                    }
//                }
                
              //  .pickerStyle(SegmentedPickerStyle())
                //BUTTON NOT WORKING BELOW
               
                   Text("Add Item")
                    .onTapGesture{
                        let foodItemID = UUID()
                        
                        if foodName != "" {
                          
                            saveItem.saveFoodItem(foodName: foodName, calories: caloriesAmount, protein: proteinAmount, fat: fatAmount, carbs: carbAmount)
                            showing = false
                          /*
                          KEEPING below code hidden for now. Don't think user should be able to add meal from this view, as what if they just want to add item without appending
                           
                           
                           */
                            //create meal to add
//                            let meal = Meal(id: foodItemID, brand: "Custom", mealName: foodName, calories: caloriesAmount, quantity: 1, amount: "g", protein: proteinAmount, carbs: carbAmount, fat: fatAmount, servingSize: 1.0, servingSizeUnit: "1tsb")
//                            //attach to meal timing selection
//
//                            switch self.mealTimingSelection {
//                                case .breakfast:  mealEntryObj.mealEntrysBreakfast.append(meal)
//                                case .lunch: mealEntryObj.mealEntrysLunch.append(meal)
//                                case .dinner: mealEntryObj.mealEntrysDinner.append(meal)
//                                    }
                                }
                            else{
                                isFoodNameValid = false
                            }
                        
                    }
                    .frame(width:200, height:30)
                    .background(
                      RoundedRectangle(cornerRadius: 20)
                          .fill(
                              Color.blue))
                 
                .padding(.top, 15)
                
              
                    }
            
                }
            }

//struct CustomFoodItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomFoodItemView()
//    }
//}
