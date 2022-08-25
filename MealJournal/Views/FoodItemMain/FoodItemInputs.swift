//
//  FoodItemInputs.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/11/22.
//

import SwiftUI

struct FoodItemInputs: View {
    @Binding var mealUnitSize: String
    @State var userToggleServings = false
    @State var userToggleNumberServings = false
    @State var sheetOption: SheetMode = .none
    
    var body: some View {
        VStack{
            HStack(spacing: 100){
                Text("Serving Size")
                    .frame(maxWidth:.infinity)
                    .multilineTextAlignment(.trailing)
                Button(action: {
                    switch sheetOption{
                        case.none:
                            sheetOption = .quarter
                        case .quarter:
                            sheetOption = .none
                        case .mealTimingSelection:
                            sheetOption = .quarter
                        }
                    userToggleNumberServings.toggle()
                }){
                    Text(" ")
                        .frame(width:80, height:20)
                }
                
                .border(.black)
             
            }
            
            //NUM SERVINGS
            HStack(spacing: 100){
                Text("Serving Size Unit")
                    .frame(maxWidth:.infinity)
                    .multilineTextAlignment(.trailing)
                Button(action: {
                    switch sheetOption{
                        case.none:
                            sheetOption = .quarter
                        case .quarter:
                            sheetOption = .none
                        case .mealTimingSelection:
                            sheetOption = .quarter
                        }
                    userToggleServings.toggle()
                }){
                    Text(" ")
                        .frame(width:80, height:20)
                }
                
                .border(.black)
             
            }
        }
       
        if userToggleServings {
            FlexibleSheetPicker(SheetOptions: $sheetOption){
                WholeNFractionPicker()
                    .border(.red)
                    .transition(.move(edge: self.userToggleServings ? .bottom : .top))
            }
            .animation(Animation.easeInOut(duration: 0.40))
        }
        
        if userToggleNumberServings {
            FlexibleSheetPicker(SheetOptions: $sheetOption){
                ServingUnitPicker()
                    .border(.red)
                    .transition(.move(edge: self.userToggleNumberServings ? .bottom : .top))
            }
            .animation(Animation.easeInOut(duration: 0.40))
        }
    }
}

struct FoodItemInputs_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemInputs(mealUnitSize: .constant( "hello "))
    }
}
