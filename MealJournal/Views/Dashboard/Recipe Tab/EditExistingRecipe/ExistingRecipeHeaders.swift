//
//  ExistingRecipeHeaders.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/24/23.
//

import SwiftUI

struct ExistingRecipeHeaders: View {
    @Environment (\.colorScheme) var colorScheme
    @ObservedObject var ema: EditModeActive
    @State var name: String
    @Binding var prepTime: String
    @State private var recipeTime = "Cook Time"
    @State private var pickerTime: String = ""
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
    var body: some View {
        if ema.editMode{
            TextField(name, text: $ema.recipeTitle)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .cornerRadius(5)
                .padding(.top, 45)
                .padding(.leading, 25)
                .submitLabel(.done)
            
            
            HStack(spacing: 0){
                Text("Prep Time: ")
                    ZStack {
                       // Custom picker label
                        Text("\(ema.recipePrepTime)")
                            .font(.body)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                       // Invisible picker
                        Picker(selection: $ema.recipePrepTime, label: Text("")) {
                           ForEach(cookingTime, id: \.self) {
                               Text($0)
                                  
                           }
                        }
                        .opacity(0.025) // << show picker
                        .accentColor(colorScheme == .dark ? .white : .gray)
                        .pickerStyle(.menu)
                    }
                    
                
                .multilineTextAlignment(.leading)
                
            }
                .padding(.leading, 25)
                .padding(.bottom, 25)
                
        }
        else{
            Text("Recipe Title: \(ema.recipeTitle)")
               
                .font(.custom("Montserrat-Regular", size: 21))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .multilineTextAlignment(.leading)
                .cornerRadius(5)
                .padding(.top, 45)
                .padding(.leading, 25)
                .submitLabel(.done)
            
            Text("Prep Time: \(ema.recipePrepTime)")
                .font(.custom("Montserrat-Regular", size: 18))
                .padding(.top, 5)
                .padding(.leading, 25)
                .padding(.bottom, 25)
        }
    }
}
//
//struct ExistingRecipeHeaders_Previews: PreviewProvider {
//    static var previews: some View {
//        ExistingRecipeHeaders()
//    }
//}
