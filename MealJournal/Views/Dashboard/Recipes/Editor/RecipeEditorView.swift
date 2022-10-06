//
//  EditorIngredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import SwiftUI

struct RecipeEditorView: View {
    @EnvironmentObject var recipeClass: Recipe
    @State private var recipeTitle = ""
    @State private var recipeTime = "Cook Time"
    @State private var pickerTime: String = ""
    //calls macro pickers
    @State var caloriesPicker: Int = 0
    @State var fatPicker: Int = 0
    @State var carbPicker: Int = 0
    @State var proteinPicker: Int = 0
    
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
    
    var body: some View {
        VStack{
            TextField("Recipe Title", text: $recipeTitle)
                .onChange(of: recipeTitle, perform: { _ in
                    recipeClass.recipeTitle = recipeTitle
                })
                .foregroundColor(Color.black)
                .font(.title3)
                .multilineTextAlignment(.center)
            //macro selectors
            HStack{
                //macro pickers for recipe
                Picker(selection: $caloriesPicker, label: Text("")) {
                   ForEach(calorieCounter(), id: \.self) {
                       Text(String($0) + " Calories")
                          
                   }
                   .onChange(of: caloriesPicker, perform: { _ in
                       recipeClass.recipeCaloriesMacro = caloriesPicker
                   })
                  
                  
                }
                .accentColor(.gray)
                
                Picker(selection: $fatPicker, label: Text("")) {
                   ForEach(pickerGramCounter(), id: \.self) {
                       Text(String($0) + "g Fat")
                          
                   }
                 
                   .onChange(of: fatPicker, perform: { _ in
                       recipeClass.recipeFatMacro = fatPicker
                   })
                  
                  
                }
                .accentColor(.gray)
                
                Picker(selection: $carbPicker, label: Text("")) {
                   ForEach(pickerGramCounter(), id: \.self) {
                       Text(String($0) + "g Carbs")
                   }
                   .onChange(of: carbPicker, perform: { _ in
                       recipeClass.recipeCarbMacro = carbPicker
                   })
                }
                .accentColor(.gray)
                
                Picker(selection: $proteinPicker, label: Text("")) {
                    //calls func that counts to 200
                   ForEach(pickerGramCounter(), id: \.self) {
                       Text(String($0) + "g Protein")
                   }
                   .onChange(of: proteinPicker, perform: { _ in
                       recipeClass.recipeProteinMacro = proteinPicker
                   })
                }
                .accentColor(.gray)
            }
            HStack(spacing: 0){
                ZStack{
                    Image(systemName:("clock"))
                        .padding(.leading, 150)
                        .foregroundColor(Color("completeGreen"))
                    Picker(selection: $pickerTime, label: Text("Gender")) {
                       ForEach(cookingTime, id: \.self) {
                           Text($0)
                       }
                    }
                    .onChange(of: pickerTime, perform: { _ in
                        recipeClass.recipePrepTime = pickerTime
                    })
                    .accentColor(.gray)
                }
                .multilineTextAlignment(.center)
            }
        }
    }
       
}

struct RecipeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorView()
    }
}
