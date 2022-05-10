//
//  RecipeEditor.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/7/22.
//

import SwiftUI

struct RecipeEditor: View {
    var body: some View {
        VStack{
            RecipeEditorImage()
                .padding(.top,50)
           
            EditorIngredients()
                .padding(.top, 100)
            Spacer()
        }
       
       
    }
}
struct RecipeEditor_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditor()
    }
}
