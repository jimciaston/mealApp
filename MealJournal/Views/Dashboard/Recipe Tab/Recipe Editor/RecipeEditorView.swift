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
    @State private var recipeCalories = ""
    //calls macro pickers
    @State var caloriesPicker: Int = 0
    @State var fatPicker: Int = 0
    @State var carbPicker: Int = 0
    @State var proteinPicker: Int = 0
    @Binding var showSuccessMessage: Bool
    @State private var timer: Timer?
    @State var isLongPressing = false
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
    var resetPickerTime: (() -> Void)?
   @State var fatSelectorActivated = false
   
    
    
    var body: some View {
        let releaseGesture = DragGesture(minimumDistance: 0) // << detects finger release
            .onEnded { _ in
                self.timer?.invalidate()
            }
        
        
        let longPressGesture = LongPressGesture(minimumDuration: 0.2)
            .onEnded { _ in
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                    if fatSelectorActivated {
                        recipeClass.recipeFatMacro += 1
                    }
                })
            }
        let combined = longPressGesture.sequenced(before: releaseGesture)
        
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
            .padding(.bottom, 15)
                HStack {
                    Text("Fat:")
                        .padding(.trailing, 10)
                    Image(systemName: "minus")
                        .frame(width: 15, height: 15)
                        .foregroundColor(.white)
                        .padding(3)
                        .background(Circle().fill(Color("PieChart3")))
                        .onTapGesture{
                            recipeClass.recipeFatMacro -= 1
                        }
                    Text("\(recipeClass.recipeFatMacro)g")
                        .foregroundColor(.black)
                        .padding(.trailing, 15)
                        .frame(width:60)
                       
                    
                   
                        Image(systemName: "plus")
                        .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                            .padding(3)
                            .background(Circle().fill(Color("PieChart3")))
                            .onTapGesture{
                                fatSelectorActivated = true
                                recipeClass.recipeFatMacro += 1
                            }
                    .gesture(combined)
                }
                .multilineTextAlignment(.leading)
                ZStack {
                   // Custom picker label
                    Text("\(recipeClass.recipeCarbMacro)g Carbs")
                        .font(.body)
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
                        .font(.body)
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
                
            
            HStack(spacing: 0){
                ZStack{
                    Image(systemName:("clock"))
                        .padding(.leading, 150)
                        .foregroundColor(Color("UserProfileCard1"))
                    
                    
                    ZStack {
                       // Custom picker label
                        Text("\(recipeClass.recipePrepTime)")
                            .font(.body)
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
struct RecipeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorView(recipeClass: Recipe(), showSuccessMessage: .constant(false))
    }
}
