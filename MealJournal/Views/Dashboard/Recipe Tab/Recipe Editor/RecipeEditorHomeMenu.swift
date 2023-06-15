//
//  RecipeEditorHomeMenu.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/18/23.
//

import SwiftUI

struct RecipeEditorHomeMenu: View {
    @Environment(\.dismiss) var dismiss
    @Environment (\.colorScheme) var colorScheme
    @State var recipeAddedSuccess = false
    @State private var showSaveButton = false
    @State var selectedButton: String = "Nutrition"
    @State var isNutritionSelected = true // << auto true for recipe startup
    @State var isDirectionsSelected = false
    @State var isInstructionsSelected = false
    @State private var sheetMode: SheetMode = .none
    @State var shown = false
    @StateObject var recipeClass = Recipe()
    var onDismiss: (() -> Void)?
    var resetPickerTime: (() -> Void)?
    @ObservedObject var dashboardRouter: DashboardRouter
    @State var dismissSaveRecipeSheet = false
    @Binding var showSuccessMessage: Bool
    
    @State var recipeTitleEmpty: Bool = false
    
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack{
                    HStack{
                        Spacer()
                        //bottom sheet for meals
                        Button(action: {
                            if (recipeClass.recipeTitle == "" ){
                                recipeTitleEmpty = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        recipeTitleEmpty = false
                                    }
                            }
                            else{
                                recipeTitleEmpty = false
                                showSaveButton.toggle()
                                switch sheetMode {
                                case .none:
                                    sheetMode = .mealTimingSelection
                                case .mealTimingSelection:
                                    sheetMode = .none
                                case .quarter:
                                    sheetMode = .none
                                }
                            }
                        
                        }){
                            Image(systemName:"checkmark.square.fill").resizable()
                                .frame(width: 30, height: 30)
                            //  .frame(maxWidth: .infinity)
                                .foregroundColor(Color("ButtonTwo"))
                                .padding(.trailing, 20)
                        }
                        .blur(radius: showSuccessMessage ? 15 : 0)
                    }
                    
                    if #available(iOS 16.0, *) {
                        RecipeEditorImage()
                            .padding(.top,-45)
                            .blur(radius: showSuccessMessage ? 15 : 0)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    //Recipe Title
                    TextField("Recipe Title", text: $recipeClass.recipeTitle)
                    //.frame(height: 20)
                        .foregroundColor(colorScheme == .dark ? Color.white : .black)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .cornerRadius(5)
                        .padding(.top, 25)
                        .padding(.leading, 25)
                        .submitLabel(.done)
                        .overlay(
                                !recipeTitleEmpty ?
                                    AnyView(EmptyView()) :
                                    AnyView(
                                        VStack {
                                            Spacer()
                                            Text("Recipe title cannot be empty")
                                                .foregroundColor(.white)
                                                .font(.body)
                                                .padding()
                                                .background(Color("graySettingsPillbox"))
                                                .cornerRadius(10)
                                                .offset(y: -10)
                                                .padding(10)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.bottom, 40)
                                        .padding(.trailing, 25)
                                    )
                            )
                  




                    RecipePrepTimeSection(recipeClass: recipeClass)
                        .padding(.leading, 25)
                        .padding(.bottom, 25)
                    
                    HStack{
                        SelectableButton(label: "Nutrition", action: { /* do something */ }, isSelected: $isNutritionSelected)
                        SelectableButton(label: "Ingredients", action: { /* do something */ }, isSelected: $isDirectionsSelected)
                        SelectableButton(label: "Directions", action: { /* do something */ }, isSelected: $isInstructionsSelected)
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
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    else if isInstructionsSelected{
                        EditorDirections()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }
                    
                    //RecipeEditModals()
                    //                    .blur(radius: showSuccessMessage ? 15 : 0)
                    Spacer()
                    if showSaveButton {
                        VStack {
                           
                            SaveRecipeButton(showSuccessMessage: $showSuccessMessage, recipeClass: recipeClass, dismissSaveRecipeSheet: $showSaveButton)
                         //       .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 1, alignment: .bottom)
                               
                                
                        }
                        .frame(height:0)
                        .transition(.move(edge: .bottom))
                    }
                    
                }
                
                .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                .environmentObject(recipeClass)
                       
            }
            
        }
    }
}

//struct RecipeEditorHomeMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEditorHomeMenu()
//    }
//}
