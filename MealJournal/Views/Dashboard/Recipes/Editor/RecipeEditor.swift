//
//  RecipeEditor.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/7/22.
//

import SwiftUI

struct RecipeEditor: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Button(action: {
               dismiss()
            }){
                Text("Close")
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 200)
                    .foregroundColor(.black)
                
            }
            RecipeEditorImage()
                .padding(.top,50)
           
            RecipeEditorView()
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
