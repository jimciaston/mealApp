//
//  testmodal2.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/21/22.
//

import SwiftUI

struct RecipeNavigationModals: View {
    @Environment (\.dismiss) var dismiss
    @State private var sheetModeIngredients: SheetMode = .quarter
    @State private var isIngredientsActive = true
   
    
    @State private var sheetModeDirections: SheetMode = .none
    @State private var isDirectionsActive = false
    
    var body: some View {
        ZStack {
            FlexibleSheet(sheetMode: $sheetModeIngredients) {
                VStack {
                    RecipeIngredients()
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                //sets coordinates of view on dash
                .offset(y:-300)
                
            }
            FlexibleSheet(sheetMode: $sheetModeDirections) {
                VStack {
                    RecipeDirections()
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                
                //sets coordinates of view on dash
                .offset(y:-300)
            }
            
            HStack(){
                //ingredients BUTTON
                Button(action: {
                        isDirectionsActive = false
                        isIngredientsActive = true
                        
                        switch sheetModeIngredients {
                            case .none:
                            sheetModeDirections = .none
                            sheetModeIngredients = .quarter
                            case .quarter:
                            sheetModeIngredients = .quarter
                            
        
                        }
                    }){
                        Text("Ingredients")
                            .foregroundColor(isIngredientsActive ? .gray : .black)
                            .font(.title2)
                    }
                
                     Divider()
                    .frame(width: 0.8, height:45)
                        .padding(.bottom, 0.9)
                        .background(Color.black)
                //directions BUTTON
                Button(action: {
                    isIngredientsActive = false
                    isDirectionsActive = true
                    //leave on quarter so user can't disapear a view on the screen
                    switch sheetModeDirections {
                    case .none:
                        sheetModeIngredients = .none
                        sheetModeDirections = .quarter
                    case .quarter:
                        sheetModeDirections = .quarter
                    }
                        
                }){
                    Text("Directions")
                        .foregroundColor(isDirectionsActive ? .gray : .black)
                         .font(.title3)
                }
                    
            }
     .offset(y:-200)
        }
    }
}

struct ContentVieww_Previews: PreviewProvider {
    static var previews: some View {
        RecipeNavigationModals()
    }
}
