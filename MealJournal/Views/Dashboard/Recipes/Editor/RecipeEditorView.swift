//
//  EditorIngredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import SwiftUI

struct RecipeEditorView: View {
    @State private var recipeTitle = ""
    @State private var recipeTime = "Cook Time"
    @State private var sheetMode: SheetMode = .none
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
    @State private var pickerTime = ""
    
    var body: some View {
        VStack{
        
                    TextField("Recipe Title", text: $recipeTitle)
                        .foregroundColor(Color.black)
                        .font(.title3)
                    
                
                .multilineTextAlignment(.center)
            
           
            
            HStack(spacing: 0){
                ZStack{
                    Image(systemName:("clock"))
                        .padding(.leading, 150)
                        .foregroundColor(Color("completeGreen"))
                    Picker(selection: $pickerTime, label: Text("Gender")) {
                                   ForEach(cookingTime, id: \.self) {
                                       Text($0)
                                   }
                    }
                    
                }
                .multilineTextAlignment(.center)
            }
           
         
            }
           
        }
       
    }

struct RecipeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorView()
    }
}
