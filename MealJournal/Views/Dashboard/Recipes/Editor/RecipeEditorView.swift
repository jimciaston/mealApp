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
    @State private var recipeTime = "Cook Time"
    @State private var pickerTime: String = ""
    //calls macro pickers
    @State var caloriesPicker: Int = 0
    @State var fatPicker: Int = 0
    @State var carbPicker: Int = 0
    @State var proteinPicker: Int = 0
    @Binding var showSuccessMessage: Bool
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
    var resetPickerTime: (() -> Void)?
    var body: some View {
        VStack{
            TextField("Recipe Title", text: $recipeClass.recipeTitle)
               
                .foregroundColor(Color.black)
                .font(.title3)
                .multilineTextAlignment(.center)
            //macro selectors
            HStack{
                //macro pickers for recipe
                Picker(selection: $recipeClass.recipeCaloriesMacro, label: Text("")) {
                   ForEach(calorieCounter(), id: \.self) {
                       Text(String($0) + " Calories")
                          
                   }
                   
                  
                  
                }
                .accentColor(.gray)
                
                Picker(selection: $recipeClass.recipeFatMacro, label: Text("")) {
                   ForEach(pickerGramCounter(), id: \.self) {
                       Text(String($0) + "g Fat")
                          
                   }
                 
                
                  
                }
                .accentColor(.gray)
                
                Picker(selection: $recipeClass.recipeCarbMacro, label: Text("")) {
                   ForEach(pickerGramCounter(), id: \.self) {
                       Text(String($0) + "g Carbs")
                   }
                  
                }
                .accentColor(.gray)
                
                Picker(selection: $recipeClass.recipeProteinMacro, label: Text("")) {
                    //calls func that counts to 200
                   ForEach(pickerGramCounter(), id: \.self) {
                       Text(String($0) + "g Protein")
                   }
                   
                }
                .accentColor(.gray)
            }
            HStack(spacing: 0){
                ZStack{
                    Image(systemName:("clock"))
                        .padding(.leading, 150)
                        .foregroundColor(Color("completeGreen"))
                    Picker(selection: $recipeClass.recipePrepTime, label: Text("")) {
                       ForEach(cookingTime, id: \.self) {
                           Text($0)
                       }
                    }
                    
                   
                    .accentColor(.gray)
                }
                .multilineTextAlignment(.center)
            }
        }
       
    }
       
}
//
//struct RecipeEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEditorView()
//    }
//}
