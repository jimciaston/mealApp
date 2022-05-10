//
//  EditorIngredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import SwiftUI

struct EditorIngredients: View {
    @State private var recipeTitle = "Recipe Name"
    @State private var recipeTime = "Cook Time"
    @State private var sheetMode: SheetMode = .none
    @State private var balls = false
    var body: some View {
        VStack{
            HStack(spacing: 0){
           
                TextField("Recipe Title", text: $recipeTitle)
                    .foregroundColor(Color.black)
                    .font(.title3)
                    .onTapGesture {
                        self.balls.toggle()
                    }
            }
            .multilineTextAlignment(.center)
            
            if balls{
                FlexibleSheet(sheetMode: $sheetMode) {
                        IngredientsPicker()
                    }
            }
            
            
            
            }
           
        }
       
    }

struct EditorIngredients_Previews: PreviewProvider {
    static var previews: some View {
        EditorIngredients()
    }
}
