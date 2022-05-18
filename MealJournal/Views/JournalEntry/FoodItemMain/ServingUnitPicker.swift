//
//  FoodItemEditors.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/27/22.
//

import SwiftUI
import UIKit

struct ServingUnitPicker: View {
    var options = ["cup", "oz" , "tbsp", "tsp", "ml"]
    @State var a = ""
    
    var body: some View {
        VStack{
            Picker("Choose your Sizing", selection: $a){
                ForEach(options, id: \.self){value in
                    Text(value)
                }
            }
            Text(a)
            .pickerStyle(.menu).labelsHidden()
            .onAppear {
                UISegmentedControl.appearance().tintColor = .red
                    }
        }
        
    }
}

struct FoodItemEditors_Previews: PreviewProvider {
    static var previews: some View {
        ServingUnitPicker()
    }
}
