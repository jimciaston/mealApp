//
//  RecipeDashHeader.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/20/22.
//

import SwiftUI

struct RecipeDashHeader: View {
    @State var recipeName = ""
    @State var recipePrepTime = ""
    @State var updatedRecipeName = ""
    @Binding var editingRecipe: Bool
    
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
    @State private var pickerTime: String = ""
    
    @ViewBuilder
    var body: some View {
        if editingRecipe {
            VStack{
                TextField(recipeName, text: $recipeName)
                    .foregroundColor(!editingRecipe ? Color.black : Color.gray)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                
                .onChange(of: updatedRecipeName, perform: { _ in
                    //update firebase logic
                })
                
            //prep time
            HStack{
                    Image(systemName:("clock"))
                        .foregroundColor(Color("completeGreen"))
                    //select amount of time prepping/cooking
                    Picker(selection: $recipePrepTime, label: Text("")) {
                       ForEach(cookingTime, id: \.self) {
                           Text($0)
                       }
                      
                    }
                    
                    .onChange(of: pickerTime, perform: { _ in
                     //   recipeClass.recipePrepTime = pickerTime
                    })
            }
        }
        .frame(width:250, height:95)
        .background(Color.white)
        .cornerRadius(15)
        }
        //if not editing recipe
        else{
            VStack{
                Text(recipeName)
                    .font(.title2)
                    .padding()
                HStack{
                    Image(systemName: "clock")
                        .foregroundColor(.green)
                    Text(recipePrepTime)
                }
            }
            .frame(width:250, height:95)
            .background(Color.white)
            .cornerRadius(15)
        }
        
    }
}

//struct RecipeDashHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDashHeader()
//    }
//}
