//
//  RecipeEditor_NonUser.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/3/23.
//

import SwiftUI

struct RecipeEditor_NonUser: View {
    @Environment(\.dismiss) var dismiss
    
    
    @ObservedObject var recipeClass = Recipe()
    
    @State private var showSaveButton = false
    @State var showSuccessMessage = false
    @State private var sheetMode: SheetMode = .none
    var onDismiss: (() -> Void)?
   
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
               
                if showSuccessMessage {
                    RecipeSuccessPopUp(shown: $showSuccessMessage, recipeClass: recipeClass, onDismiss: onDismiss, showSuccessMessage: $showSuccessMessage)
                }
                RecipeEditorView(recipeClass: recipeClass, showSuccessMessage: $showSuccessMessage)
                    .blur(radius: showSuccessMessage ? 15 : 0)
                    .padding(.top, 80)
                
                RecipeEditModals()
                    .blur(radius: showSuccessMessage ? 15 : 0)
               // Spacer()
                
                
                //display save button
                FlexibleSheet(sheetMode: $sheetMode) {
                    SaveRecipeButton(showSuccessMessage: $showSuccessMessage, recipeClass: recipeClass)
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
struct RecipeEditor_NonUser_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditor_NonUser()
    }
}
