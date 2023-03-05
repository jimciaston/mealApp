//
//  IngredientsPicker.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/10/22.
//WILL PUT ON RECIPE PAGE

import SwiftUI

struct IngredientsPicker: View {
   
    @State private var initialCookTime = "5 Mins"
    var cookingTimeOptions = [
    "10 Mins", "15 Mins","30 Mins","45 Mins","1 Hour & 15 Mins","1:15 Hours","1:30 Hours","2:00 Hours","",
    ]
    var body: some View {
        VStack{
            TextField("RecipeTime", text: $initialCookTime)
                .foregroundColor(Color.black)
                .font(.title3)
            Picker("Recipe Cook Time", selection: $initialCookTime){
                ForEach(cookingTimeOptions, id: \.self){number in
                    Text(number)
                }
                
            }.pickerStyle(.wheel)
        }
        .background(.red)
    }
}
struct IngredientsPicker_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsPicker()
    }
}
