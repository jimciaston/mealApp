//
//  RecipePrepTimeSection.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/25/23.
//

import SwiftUI

struct RecipePrepTimeSection: View {
    @ObservedObject var recipeClass: Recipe
    @State private var recipeTime = "Cook Time"
    @State private var pickerTime: String = ""
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
    var body: some View {
        HStack(spacing: 0){
            Text("Prep Time: ")
          
                ZStack {
                   // Custom picker label
                    Text("\(recipeClass.recipePrepTime)")
                        .font(.body)
                       .foregroundColor(.black)
                   // Invisible picker
                    Picker(selection: $recipeClass.recipePrepTime, label: Text("")) {
                       ForEach(cookingTime, id: \.self) {
                           Text($0)
                              
                       }
                    }
                    .opacity(0.025) // << show picker
                    .accentColor(.gray)
                    .pickerStyle(.menu)
                }
                
            
            .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

struct RecipePrepTimeSection_Preview: PreviewProvider {
    static var previews: some View {
        let recipe = Recipe() // create a sample Recipe object
        
        RecipePrepTimeSection(recipeClass: recipe)
            .previewLayout(.fixed(width: 375, height: 60)) // set a fixed preview size
    }
}
