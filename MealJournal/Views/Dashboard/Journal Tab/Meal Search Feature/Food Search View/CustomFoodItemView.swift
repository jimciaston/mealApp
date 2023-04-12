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
            return "Item name cannot be blank"
        }
        else{
            return ""
        }
    }
    
    var body: some View {
        VStack {
            GeometryReader{ geo in
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.secondary)
                        .frame(width: 60,height: 5)
                        .padding(.top, -25 )
                        .onTapGesture {
                            self.showing.toggle()
                        }
                    TextField(" Item name", text: $foodName)
                        .frame(width:180, height:30)
                        .overlay(
                         RoundedRectangle(cornerRadius: 4)
                             .stroke(Color.black, lineWidth: 1)
                     )
                        .multilineTextAlignment(.center)
                        .cornerRadius(4)
                        .padding(.trailing, 10)
                        .padding(.top, 15)
                        
                    Text(foodNamePrompt)
                        .font(.caption)
                        .foregroundColor(.red)
                    
                    MacroSelectHstack(macroAmount: $fatAmount, macroName: "Fat")
                       // .padding(.leading, geo.size.width / 5)
                        .padding(.top, 25)
                    MacroSelectHstack(macroAmount: $carbAmount, macroName: "Carbs")
                   // .padding(.leading, geo.size.width / 5)
                    MacroSelectHstack(macroAmount: $proteinAmount, macroName: "Protein")
                   // .padding(.leading, geo.size.width / 5)
                        
                    
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
                                    }
                                else{
                                    isFoodNameValid = false
                                }
                        }
                        .frame(width:120, height:40)
                        .background(
                          RoundedRectangle(cornerRadius: 10)
                              .fill(
                                  Color("LightWhite")))
                     
                    .padding(.top, 25)
                    .padding(.bottom, 100)
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            }

        }
        Spacer()
        .frame(height: 100)
       
    }
}

struct CustomFoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        CustomFoodItemView(showing: .constant(true), isViewSearching: .constant(true), userSearch: .constant(true))
    }
}
