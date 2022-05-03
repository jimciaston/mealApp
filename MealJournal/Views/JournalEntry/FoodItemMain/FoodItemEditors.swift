//
//  FoodItemEditors.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/27/22.
//

import SwiftUI

struct FoodItemEditors: View {
    var options = ["1 cup", "1 TSB", "1 Gram"]
    @State var a = ""
    
    var body: some View {
        Picker("Choose your Sizing", selection: $a){
            ForEach(options, id: \.self){value in
                Text(value)
            }
        }
        .pickerStyle(.menu)
    }
}

struct FoodItemEditors_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemEditors()
    }
}
