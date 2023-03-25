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
        VStack (alignment: .leading){
            //macro pickers for recipe
            
            //ios16 new update shows arrows in pickers, hides it with ZStack here
            HStack{
                Text("Estimated Calories: ")
                    .font(.body)
                TextField("", text: $recipeCalories)
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                    .frame(width: 78, height: 20)
                    .border(.gray)
                   
            }
            .padding(.leading, 15)
            .padding(.bottom, 25)
            MacroSelectHstack(macroAmount: $recipeClass.recipeFatMacro, macroName: "Fat")
                .padding(.leading, 15)
            MacroSelectHstack(macroAmount: $recipeClass.recipeCarbMacro, macroName: "Carbs")
                .padding(.leading, 15)
            MacroSelectHstack(macroAmount: $recipeClass.recipeProteinMacro, macroName: "Protein")
                .padding(.leading, 15)
        }
       
    }
       
}
struct RecipeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorView(recipeClass: Recipe(), showSuccessMessage: .constant(false))
    }
}
