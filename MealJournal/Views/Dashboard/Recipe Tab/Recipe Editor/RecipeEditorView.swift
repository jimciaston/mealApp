//
//  EditorIngredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import SwiftUI

struct RecipeEditorView: View {
    @ObservedObject var recipeClass: Recipe
    //@State var recipeTitle = ""
  
    @State private var recipeCalories = ""
    //calls macro pickers
    @State var caloriesPicker: Int = 0
    @State var fatPicker: Int = 0
    @State var carbPicker: Int = 0
    @State var proteinPicker: Int = 0
    @Binding var showSuccessMessage: Bool
    @State private var timer: Timer?
    @State var isLongPressing = false
    
    var resetPickerTime: (() -> Void)?
   @State var fatSelectorActivated = false
   
    
    
    var body: some View {
        VStack (alignment: .center){
            //macro pickers for recipe
            
            //ios16 new update shows arrows in pickers, hides it with ZStack here
           
            MacroSelectHstack(macroAmount: $recipeClass.recipeFatMacro, macroName: "Fat")
            MacroSelectHstack(macroAmount: $recipeClass.recipeCarbMacro, macroName: "Carbs")
            MacroSelectHstack(macroAmount: $recipeClass.recipeProteinMacro, macroName: "Protein")
            
            HStack {
                Text("Estimated Calories: ")
                    .font(.body)
                    .foregroundColor(.primary)
                TextField("0", text: $recipeCalories)
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
            //.padding(.horizontal, 16)
        }
    }
       
}
struct RecipeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorView(recipeClass: Recipe(), showSuccessMessage: .constant(false))
    }
}
