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
            
            //macro pickers for recipe
            
            //ios16 new update shows arrows in pickers, hides it with ZStack here
            ZStack {
               // Custom picker label
                Text("\(recipeClass.recipeCaloriesMacro) Calories")
                   .font(.title)
                   .foregroundColor(.black)
               // Invisible picker
                Picker(selection: $recipeClass.recipeCaloriesMacro, label: Text("")) {
                   ForEach(calorieCounter(), id: \.self) {
                       Text(String($0) + " Calories")
                          
                   }
                }
                .opacity(0.025) // << show picker
                .accentColor(.gray)
                .pickerStyle(.menu)
            }
   
         
            //macro selectors
            HStack{
                ZStack {
                   // Custom picker label
                    Text("\(recipeClass.recipeFatMacro)g Fat")
                       .font(.title)
                       .foregroundColor(.black)
                   // Invisible picker
                    Picker(selection: $recipeClass.recipeFatMacro, label: Text("")) {
                       ForEach(calorieCounter(), id: \.self) {
                           Text(String($0) + "g Fat")
                              
                       }
                    }
                    .opacity(0.025) // << show picker
                    .accentColor(.gray)
                    .pickerStyle(.menu)
                }
                
                ZStack {
                   // Custom picker label
                    Text("\(recipeClass.recipeCarbMacro)g Carbs")
                       .font(.title)
                       .foregroundColor(.black)
                   // Invisible picker
                    Picker(selection: $recipeClass.recipeCarbMacro, label: Text("")) {
                       ForEach(calorieCounter(), id: \.self) {
                           Text(String($0) + "g Carbs")
                              
                       }
                    }
                    .opacity(0.025) // << show picker
                    .accentColor(.gray)
                    .pickerStyle(.menu)
                }
             
                ZStack {
                   // Custom picker label
                    Text("\(recipeClass.recipeProteinMacro)g Protein")
                       .font(.title)
                       .foregroundColor(.black)
                   // Invisible picker
                    Picker(selection: $recipeClass.recipeProteinMacro, label: Text("")) {
                       ForEach(calorieCounter(), id: \.self) {
                           Text(String($0) + "g Protein")
                              
                       }
                    }
                    .opacity(0.025) // << show picker
                    .accentColor(.gray)
                    .pickerStyle(.menu)
                }
                
            }
            HStack(spacing: 0){
                ZStack{
                    Image(systemName:("clock"))
                        .padding(.leading, 150)
                        .foregroundColor(Color("completeGreen"))
                    
                    
                    ZStack {
                       // Custom picker label
                        Text("\(recipeClass.recipePrepTime)")
                           .font(.title)
                           .foregroundColor(.black)
                       // Invisible picker
                        Picker(selection: $recipeClass.recipePrepTime, label: Text("")) {
                           ForEach(cookingTime, id: \.self) {
                               Text($0)
                                  
                           }
                        }
                        .opacity(0.025) // << show picker
                        .accentColor(.gray)
                        .pickerStyle(.menu)
                    }
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
