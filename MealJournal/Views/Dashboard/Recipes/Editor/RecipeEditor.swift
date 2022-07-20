//
//  RecipeEditor.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/7/22.
//

import SwiftUI

struct RecipeEditor: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showSaveButton = false
    @State var showSuccessMessage = false
    @State private var sheetMode: SheetMode = .none
    
    @StateObject private var recipeClass = Recipe()
    
    
    var body: some View {
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
                .padding(.top,50)
                .blur(radius: showSuccessMessage ? 15 : 0)
           
            if showSuccessMessage {
                RecipeSuccessPopUp(shown: $showSuccessMessage)
            }
            RecipeEditorView()
                .blur(radius: showSuccessMessage ? 15 : 0)
                .padding(.top, 80)
            
            RecipeEditModals()
                .blur(radius: showSuccessMessage ? 15 : 0)
            Spacer()
            
            
            //display save button
            FlexibleSheet(sheetMode: $sheetMode) {
                SaveRecipeButton(showSuccessMessage: $showSuccessMessage)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                
                //sets coordinates of view on dash
             .offset(y:-200)
            }
            
        }
        .environmentObject(recipeClass)
    }
    
}
struct RecipeEditor_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditor()
    }
}
