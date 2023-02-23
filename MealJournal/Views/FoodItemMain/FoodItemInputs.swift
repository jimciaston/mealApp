//
//  FoodItemInputs.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/11/22.
//

import SwiftUI

struct FoodItemInputs: View {
    @Binding var mealUnitSize: String
    @Binding var mealServingSize: Double
    @State var userToggleServings = false
    @State var userToggleNumberServings = false
    @State var sheetOption: SheetMode = .none
    @State var servingSizeSelection = ["1", "0"]
    var body: some View {
        
        VStack {
            HStack{
                Text("Serving Size: ")
                    .frame(maxWidth:.infinity)
                    .offset(x: 22)
                Button(action: {
                    switch sheetOption{
                        case.none:
                            sheetOption = .quarter
                        case .quarter:
                            sheetOption = .none
                        case .mealTimingSelection:
                            sheetOption = .quarter
                    }
                    userToggleNumberServings.toggle()
                }){
                    Text(OuncesConversion(gramsMeasurement: mealServingSize, measurementUnit: mealUnitSize)) .frame(maxWidth: .infinity)
                        .padding(.trailing, 50)
                        .padding(.leading, -25)
                }
            }
           





            HStack {
                Text("Serving Size Unit: ")
                    .frame(maxWidth:.infinity)
                   // .padding(.trailing, 25)
                    .multilineTextAlignment(.trailing)
                  
                Button(action: {
                    switch sheetOption{
                    case.none:
                        sheetOption = .quarter
                    case .quarter:
                        sheetOption = .none
                    case .mealTimingSelection:
                        sheetOption = .quarter
                    }
                    userToggleServings.toggle()
                }){
                    Text(servingSizeSelection.joined(separator: " ' "))
                    .padding(.trailing, 50)
                    .padding(.leading, -25)
                }
            }
            .padding(.top, 1)
            if userToggleServings {
                WholeNFractionPicker(isOpen: $userToggleServings, selection: $servingSizeSelection)
                    .frame(maxWidth: .infinity)
                    .transition(.move(edge: self.userToggleServings ? .bottom : .top))
                    .animation(Animation.easeInOut(duration: 0.40))
            }
            if userToggleNumberServings {
                ServingUnitPicker()
                    .transition(.move(edge: self.userToggleNumberServings ? .bottom : .top))
                    .animation(Animation.easeInOut(duration: 0.40))
            }
        }






       
        
    }
}

struct FoodItemInputs_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemInputs(mealUnitSize: .constant( "hello "), mealServingSize: Binding.constant(0.00))
    }
}
