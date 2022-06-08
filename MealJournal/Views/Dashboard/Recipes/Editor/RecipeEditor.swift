//
//  RecipeEditor.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/7/22.
//

import SwiftUI

struct RecipeEditor: View {
    @State private var showSaveButton = false
    @State private var sheetMode: SheetMode = .none
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                   dismiss()
                }){
                    Image(systemName:"xmark").resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("ButtonTwo"))
                    
                }
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
            }
         
           
            RecipeEditorImage()
                .padding(.top,50)
           
            RecipeEditorView()
                .padding(.top, 80)
            
            RecipeEditModals()
            Spacer()
            
            //display save button
            FlexibleSheet(sheetMode: $sheetMode) {
                    SaveRecipeButton()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                
                //sets coordinates of view on dash
             .offset(y:-200)
            }
        }
       
    }
}
struct RecipeEditor_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditor()
    }
}
