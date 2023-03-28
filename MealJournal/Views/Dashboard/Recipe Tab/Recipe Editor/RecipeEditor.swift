//
//  RecipeEditor.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/7/22.
//

import SwiftUI
struct SelectableButtonStyle: ButtonStyle {

    var isSelected: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
           
            .foregroundColor(isSelected ? Color("UserProfileCard2") : Color("LighterGray"))
            .font(.title3)
            .padding(10)
            .padding(.top, -10)
            .background(
                        isSelected ? Color("UserProfileCard2")
                            .frame(width: 40, height: 3) // underline's height
                            .offset(y: 14) // underline's y pos
                            : nil // no background if isSelected is false
                    )
                }
            }
struct SelectableButton: View {
    let label: String
    let action: () -> Void

    @Binding var isSelected: Bool

    var body: some View {
        Button(action: {
            isSelected = true
            action()
        }) {
            Text(label)
                
        }
        .buttonStyle(SelectableButtonStyle(isSelected: isSelected))
    }
}
struct RecipeEditor: View {
    @Environment(\.dismiss) var dismiss
    
    
    @ObservedObject var recipeClass = Recipe()
    
    @State private var showSaveButton = false
    @State var showSuccessMessage = false
    @State private var sheetMode: SheetMode = .none
    @State private var showNutritionInfo = true
    var onDismiss: (() -> Void)?
    @State var selectedButton: String = "Nutrition"
    @State var isNutritionSelected = true // << auto true for recipe startup
       @State var isDirectionsSelected = false
       @State var isInstructionsSelected = false
   
    var body: some View {
        GeometryReader{ geo in
            VStack{
                HStack{
                    Button(action: {
                        SaveRecipeButton.newRecipeCreated = false
                        dismiss()
                    }){
                        Image(systemName:"xmark").resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("ButtonTwo"))
                        
                    }
                    .blur(radius: showSuccessMessage ? 15 : 0)
                    .padding(.leading, 20)
                   Spacer()
                    //bottom sheet for meals
                    Button(action: {
                        showSaveButton.toggle()
                        switch sheetMode {
                            case .none:
                                sheetMode = .mealTimingSelection
                            case .mealTimingSelection:
                                sheetMode = .none
                            case .quarter:
                                sheetMode = .none
                        }
                    }){
                        Image(systemName:"checkmark.circle.fill").resizable()
                            .frame(width: 30, height: 30)
                          //  .frame(maxWidth: .infinity)
                            .foregroundColor(Color("ButtonTwo"))
                            .padding(.trailing, 20)
                    }
                    .blur(radius: showSuccessMessage ? 15 : 0)
                }
               
                RecipeEditorImage()
                    .padding(.top,5)
                    .blur(radius: showSuccessMessage ? 15 : 0)
                
                //Recipe Title
                TextField("Recipe Title", text: $recipeClass.recipeTitle)
                  
                    .frame(height: 40)
                    .foregroundColor(Color.black)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .cornerRadius(5)
                    .padding(.top, 50)
                    .padding(.leading, 25)
                
                RecipePrepTimeSection(recipeClass: recipeClass)
                    .padding(.leading, 25)
                    .padding(.bottom, 25)
                HStack{
                        SelectableButton(label: "Nutrition", action: { /* do something */ }, isSelected: $isNutritionSelected)
                        SelectableButton(label: "Directions", action: { /* do something */ }, isSelected: $isDirectionsSelected)
                        SelectableButton(label: "Instructions", action: { /* do something */ }, isSelected: $isInstructionsSelected)
                }
               
                .padding(.bottom, 25)
                .onChange(of: isNutritionSelected) { value in
                           if value {
                               isDirectionsSelected = false
                               isInstructionsSelected = false
                           }
                       }
                       .onChange(of: isDirectionsSelected) { value in
                           if value {
                               isNutritionSelected = false
                               isInstructionsSelected = false
                           }
                       }
                       .onChange(of: isInstructionsSelected) { value in
                           if value {
                               isNutritionSelected = false
                               isDirectionsSelected = false
                           }
                       }
                if isNutritionSelected{
                    RecipeEditorView(recipeClass: recipeClass, showSuccessMessage: $showSuccessMessage)
                        .blur(radius: showSuccessMessage ? 15 : 0)
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                }
                else if isDirectionsSelected{
                    EditorIngredients()
                }
                else if isInstructionsSelected{
                    EditorDirections()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                        .border(.red)
                }
                
                //RecipeEditModals()
//                    .blur(radius: showSuccessMessage ? 15 : 0)
                Spacer()
              
              
                FlexibleSheet(sheetMode: $sheetMode) {
                   SaveRecipeButton(showSuccessMessage: $showSuccessMessage, recipeClass: recipeClass, dismissSaveRecipeSheet: $showSaveButton)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))

                    //sets coordinates of view on dash
                 .offset(y:-200)
                }
            }
            //center view 
            .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .environmentObject(recipeClass)
        }
        
    }
    
}
struct RecipeEditor_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditor()
    }
}
