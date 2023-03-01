//
//  FoodItemInputs.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/11/22.
//

import SwiftUI
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
struct FoodItemInputs: View {
    @Binding var mealUnitSize: String
    @Binding var mealServingSize: Double
    @State var userToggleServings = false
    @State var userToggleNumberServings = false
    @State var sheetOption: SheetMode = .none
    @State var servingSizeSelection = ["1", "0"]
    @State var mealCalories: Int
    @State var mealCarbs: Int
    @State var mealFat: Int
    @State var mealProtein: Int
    
    //convert to Double
    func convertToDouble(_ parts: [String]) -> Double? {
        var decimalValue = 0.0
        for part in parts {
            let subparts = part.components(separatedBy: "/")
            if subparts.count == 1, let value = Double(subparts[0]) {
                decimalValue += value
            } else if subparts.count == 2, let numerator = Double(subparts[0]), let denominator = Double(subparts[1]) {
                decimalValue += numerator / denominator
            } else {
                return nil
            }
        }
        return decimalValue.rounded(toPlaces: 2)
    }
    
    
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
                    Text(OuncesConversion(gramsMeasurement: mealServingSize, measurementUnit: mealUnitSize))
                        .frame(maxWidth: .infinity)
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
                WholeNFractionPicker(isOpen: $userToggleServings, selection: $servingSizeSelection, mealCalories: $mealCalories, mealCarbs: $mealCarbs, mealFat: $mealFat, mealProtein: $mealProtein)
                    .frame(maxWidth: .infinity)
                    .transition(.move(edge: self.userToggleServings ? .bottom : .top))
                    .animation(Animation.easeInOut(duration: 0.40))
                
                    .onChange(of: servingSizeSelection) { newValue in
                      
                        //grab value of serving size
                        let multiPickerValue = newValue
                        //convert to Double to calculate updated Macro
                        if let valueConverted = convertToDouble(multiPickerValue) {
                            mealServingSize = valueConverted
                            print("New meal serving size: \(mealServingSize)")
                            print("value converted: \(valueConverted)")
                         
                        } else {
                            print("Invalid string")
                        }
                        
                    }
            }
//            if userToggleNumberServings {
//                ServingUnitPicker()
//                    .transition(.move(edge: self.userToggleNumberServings ? .bottom : .top))
//                    .animation(Animation.easeInOut(duration: 0.40))
//            }
        }






       
        
    }
}

//struct FoodItemInputs_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodItemInputs(mealUnitSize: .constant( "hello "), mealServingSize: Binding.constant(0.00), mealCalories: 90)
//    }
//}
