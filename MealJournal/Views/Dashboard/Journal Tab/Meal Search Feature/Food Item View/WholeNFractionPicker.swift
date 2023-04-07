//
//  Test.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/2/22.
//

import SwiftUI

struct MultiPicker: View  {
    let data: [ (String, [String]) ]
    @Binding var selection: [String]
    @Binding var isOpen: Bool // << toggle select size button
    @Binding var mealCalories: Int
    @Binding var mealCarbs: Int
    @Binding var mealFat: Int
    @Binding var mealProtein: Int
    
    func convertMacrosForSaving(
        mealCalories: Binding<Int>,
        mealCarbs: Binding<Int>,
        mealFat: Binding<Int>,
        mealProtein: Binding<Int>) {
            
        let caloriesConverted = convertToDouble(selection) ?? 0.0 * Double(mealCalories.wrappedValue)
        let roundedValue_calories = caloriesConverted.rounded(toPlaces: 2)
        mealCalories.wrappedValue = Int(roundedValue_calories)
      
        let carbsConverted = convertToDouble(selection) ?? 0.0 * Double(mealCarbs.wrappedValue)
        let roundedValue_carbs = carbsConverted.rounded(toPlaces: 2)
        mealCarbs.wrappedValue = Int(roundedValue_carbs)
        
        let fatConverted = convertToDouble(selection) ?? 0.0 * Double(mealFat.wrappedValue)
        let roundedValue_fat = fatConverted.rounded(toPlaces: 2)
        mealFat.wrappedValue = Int(roundedValue_fat)
        
        let proteinConverted = convertToDouble(selection) ?? 0.0 * Double(mealProtein.wrappedValue)
        let roundedValue_protein = proteinConverted.rounded(toPlaces: 2)
        mealProtein.wrappedValue = Int(roundedValue_protein)
           
    }

    
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
        GeometryReader { geometry in
            VStack{
                HStack {
                    ForEach(0..<self.data.count) { column in
                        Picker(self.data[column].0, selection: self.$selection[column]) {
                            ForEach(0..<self.data[column].1.count) { row in
                                Text(verbatim: self.data[column].1[row])
                                    .font(.title3)
                                    .tag(self.data[column].1[row])
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .clipped()
                    }
                }
               .padding(.top, -45)
              
                Spacer()
                
                //buttons for no or select a serving size
                HStack{
                  
                    Button(action: {
                        isOpen = false
                        convertMacrosForSaving(mealCalories: $mealCalories, mealCarbs: $mealCarbs, mealFat: $mealFat, mealProtein: $mealProtein)
                    }){
                        Text("Select Size")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    
                    .background(.green)
                }
                .padding(.top, 50)
                
            }
        }
    }
}

struct WholeNFractionPicker: View {
    @Binding var isOpen: Bool
    @Binding var selection: [String]
    @Binding var mealCalories: Int
    @Binding var mealCarbs: Int
    @Binding var mealFat: Int
    @Binding var mealProtein: Int
    
    @State var data: [(String, [String])] = [
        ("Whole Number", Array(1...100).map { "\($0)" }),
        ("Fractional Number", ["", "1/8", "1/4" , "1/3" , "3/8" , "1/2" , "5/8" , "2/3" , "3/4" , "7/8"]),
        ]
    
    var body: some View {
        VStack {
            MultiPicker(data: data, selection: $selection, isOpen: $isOpen, mealCalories: $mealCalories, mealCarbs: $mealCarbs, mealFat: $mealFat, mealProtein: $mealProtein )
                .frame(height: 300)
          
              }
        .background(Color("ListBackgroundColor"))

        }
    }

struct Test_Previews: PreviewProvider {
    @State static var selection = ["", ""]
    @State static var mealCalories = 0
    @State static var mealCarbs = 0
    @State static var mealFat = 0
    @State static var mealProtein = 0

    static var previews: some View {
        WholeNFractionPicker(isOpen: .constant(true), selection: $selection, mealCalories: $mealCalories, mealCarbs: $mealCarbs, mealFat: $mealFat, mealProtein: $mealProtein)
    }
}
