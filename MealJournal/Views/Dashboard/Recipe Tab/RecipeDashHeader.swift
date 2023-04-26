//
//  RecipeDashHeader.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/20/22.
//

import SwiftUI
import UIKit



@available(iOS 16.0, *)
struct RecipeDashHeader: View {
    @State var recipeName = ""
    @State var recipePrepTime = ""
  
    //calls macro pickers
    @State var caloriesPicker:Int =     0
    @State var fatPicker:Int =     0
    @State var carbPicker:Int =     0
    @State var proteinPicker:Int =     0
    @ObservedObject var ema: EditModeActive
    var focused: FocusState<RecipeControllerModal.FocusField?>.Binding 
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
   // @State var cookingTimesInMinutes = [5, 10, 15, 20, 25, 30, 45, 60, 120, 240, 480]
    @State private var pickerTime: String = ""
    //@State private var selectedCookingTime = 0
    
    
    
    @ViewBuilder
    var body: some View {
        if ema.editMode {
            VStack{
                    TextField(ema.recipeTitle, text: $ema.recipeTitle)
                        .foregroundColor(!ema.editMode ? Color.black : Color("olympic"))
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                       
                        .focused(focused, equals: .header)
                        .submitLabel(.done)
                        .onChange(of: ema.recipeTitle, perform: { _ in
                            recipeName = ema.recipeTitle
                        })
                        
                
                //}
               
                
                //prep time
                HStack{
                        Image(systemName:("clock"))
                            .foregroundColor(Color("olympic"))
                        //select amount of time prepping/cooking
                    ZStack{
                        Text("\(recipePrepTime)")
                              .font(.body)
                              .foregroundColor(Color("olympic"))
                        Picker(selection: $recipePrepTime, label: Text("").foregroundColor(.red)) {
                            ForEach(cookingTime, id: \.self) {
                                Text($0).foregroundColor(.black)
                                    .font(.body)
                            }
                        }
                        .frame(height: 15)
                        .frame(width:0)
                        .opacity(0.025)
                        .onChange(of: recipePrepTime) { value in
                            ema.recipePrepTime = recipePrepTime
                        }
                       
                    }
                }
                
                .padding(.top, -10)
                ZStack{
                    Text("\(caloriesPicker) calories")
                          .font(.body)
                          .foregroundColor(Color("olympic"))
                    Picker(selection: $caloriesPicker, label: Text("").foregroundColor(.red)) {
                        ForEach(0 ..< calorieCounter().count, id: \.self) {
                            Text(String(calorieCounter()[$0]) + " calories")
                                .font(.body)
                               
                        }
                    }
                    .frame(height: 15)
                    .frame(width:0)
                    .opacity(0.025)
                    .onChange(of: caloriesPicker) { value in
                        ema.recipeCaloriesMacro = calorieCounter()[value]
                    }
                   
                }
                HStack{
                    //macro pickers for recipe
                  
                    ZStack{
                        Text("\(fatPicker)g Fat")
                              .font(.body)
                              .foregroundColor(Color("olympic"))
                        Picker(selection: $fatPicker, label: Text("").foregroundColor(.red)) {
                            ForEach(0 ..< pickerGramCounter().count, id: \.self) {
                                Text(String(pickerGramCounter()[$0]) + "g Fat")
                                    .font(.body)
                                   
                            }
                        }
                        .frame(height: 15)
                        .frame(width:0)
                        .opacity(0.025)
                        .onChange(of: carbPicker) { value in
                            ema.recipeCarbMacro = pickerGramCounter()[value]
                        }
                       
                    }
                    ZStack{
                        Text("\(carbPicker)g carbs")
                              .font(.body)
                              .foregroundColor(Color("olympic"))
                        Picker(selection: $carbPicker, label: Text("").foregroundColor(.red)) {
                            ForEach(0 ..< pickerGramCounter().count, id: \.self) {
                                Text(String(pickerGramCounter()[$0]) + "g Carbs")
                                    .font(.body)
                                   
                            }
                        }
                        .frame(height: 15)
                        .frame(width:0)
                        .opacity(0.025)
                        .onChange(of: carbPicker) { value in
                            ema.recipeCarbMacro = pickerGramCounter()[value]
                        }
                       
                    }
                    
                    ZStack{
                        Text("\(proteinPicker)g Protein")
                              .font(.body)
                              .foregroundColor(Color("olympic"))
                        Picker(selection: $proteinPicker, label: Text("").foregroundColor(.red)) {
                            ForEach(0 ..< pickerGramCounter().count, id: \.self) {
                                Text(String(pickerGramCounter()[$0]) + "g Protein")
                                    .font(.body)
                            }
                        }
                        .frame(width:0)
                        .opacity(0.025)
                        .onChange(of: proteinPicker) { value in
                            ema.recipeProteinMacro = pickerGramCounter()[value]
                        }
                    }
                    
                   
                }
                .padding(.top, -5)
            }
            .frame(width:280, height:170)
            .background(Color.white)
            .cornerRadius(10)
            .onAppear{
                ema.recipeFatMacro = fatPicker
                ema.recipeCaloriesMacro = caloriesPicker
                ema.recipeCarbMacro = carbPicker
                ema.recipeProteinMacro = proteinPicker
                ema.recipeTitle = recipeName
                ema.recipePrepTime = recipePrepTime
                
            }
       
        }
        //if not editing recipe
        else{
            VStack{
                HStack{
                    Text(recipeName.capitalized)
                        .font(.title2)
                        .padding()
                }
                .multilineTextAlignment(.leading)
                HStack{
                    Image(systemName: "clock")
                        .foregroundColor(Color("UserProfileCard2"))
                    Text(recipePrepTime)
                }
                .multilineTextAlignment(.leading)
                .padding(.top, -10)
                
                Text(String(caloriesPicker) + " calories").bold()
                    .font(.body)
                    .foregroundColor(.black)
                    .font(.body)
                    .padding(.top, 5)
             
                HStack{
                    Text(String(fatPicker) + "g fat")
                        .font(.body)
                        .foregroundColor(.black)
                        .font(.body)
                    //carb
                    Text(String(carbPicker) + "g carbs")
                        .foregroundColor(.black)
                        .font(.body)
                    //protein
                    Text(String(proteinPicker) + "g protein")
                        .foregroundColor(.black)
                }
                .padding(.top, 10)
               
              
            }
            .frame(width:280, height:200)
            .background(Color.white)
            .cornerRadius(10)
           
        }
       
    }
    
}

//struct RecipeDashHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDashHeader()
//    }
//}
