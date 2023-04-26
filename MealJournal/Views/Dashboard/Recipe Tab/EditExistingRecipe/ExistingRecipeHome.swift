//
//  ExistingRecipeHome.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/24/23.
//

import SwiftUI

struct ExistingRecipeHome: View {
    @ObservedObject var ema: EditModeActive
    //@State var recipeTitle = ""
  
    @State private var recipeCalories = ""
    //calls macro pickers
    @State var caloriesPicker: Int = 0
    @State var fatPicker: Int = 0
    @State var carbPicker: Int = 0
    @State var proteinPicker: Int = 0
  
    @State private var timer: Timer?
    @State var isLongPressing = false
    
    var resetPickerTime: (() -> Void)?
   @State var fatSelectorActivated = false
    @Binding var totalCalories: Int
    
    
    var body: some View {
        VStack (alignment: .center){
            if ema.editMode{
                MacroSelectHstack(macroAmount: $ema.recipeFatMacro  , macroName: "Fat")
                    .padding(.leading, -25)
                MacroSelectHstack(macroAmount: $ema.recipeCarbMacro, macroName: "Carbs")
                    .padding(.leading, -25)
                MacroSelectHstack(macroAmount: $ema.recipeProteinMacro, macroName: "Protein")
                    .padding(.leading, -25)
                
                HStack {
                    Text("Estimated Calories: ")
                        .font(.body)
                        .foregroundColor(.primary)
                    TextField("\(totalCalories)", text: $recipeCalories)
                        .keyboardType(.numberPad)
                        .foregroundColor(.primary)
                        .font(.body)
                        .padding(4)
                        .frame(width: 60, height: 20)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .padding(.leading, 15)
                .padding(.top, 35)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25)
            }
            else{
                VStack{
                    Text("Total Fat: \(ema.recipeFatMacro)")
                        .frame(width: 200, alignment: .leading)
                        .padding(.trailing, 25)
                        .padding(.bottom, 10)
                    Text("Total Carbohydrates: \(ema.recipeCarbMacro)")
                        .frame(width: 200, alignment: .leading)
                        .padding(.trailing, 25)
                        .padding(.bottom, 10)
                    Text("Total Protein: \(ema.recipeProteinMacro)")
                        .frame(width: 200, alignment: .leading)
                        .padding(.trailing, 25)
                        .padding(.bottom, 10)
                    Text("Estimated Calories: \(ema.recipeCaloriesMacro)")
                        .frame(width: 200, alignment: .leading)
                        .padding(.trailing, 25)
                    Spacer()
                }
                .frame(maxHeight: .infinity)
              
                
            }
        }
        
    }
}

//struct ExistingRecipeHome_Previews: PreviewProvider {
//    static var previews: some View {
//        ExistingRecipeHome()
//    }
//}
