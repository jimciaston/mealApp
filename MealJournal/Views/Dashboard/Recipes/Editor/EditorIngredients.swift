//
//  EditorIngredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/12/22.
//READY FOR CORE DATA

import SwiftUI

struct EditorIngredients: View {
    @State private var sizing: String = ""
    @State private var description: String = ""
    @State private var counter = 1
    @State private var filledOut = false
    @State var uploadedRecipes: [Ingredients] = []
   
    
    @State  var testArr: [String] = []
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    TextField("ex. 1 cup", text: $sizing)
                        .font(.body)
                        .padding(.leading, 30)
                       
                    TextField("ex. Chicken Breast", text: $description)
                        .font(.body)
                }
                .padding(.top, 25) //set to give space from ingredient/direction section
                
                    Button(action: {
                        if (sizing != "" && description != ""){
                            let newIngredient = Ingredients(sizing: sizing, description: description)
                                uploadedRecipes.append(newIngredient)
                                counter += 1
                                sizing = ""
                                description  = ""
                        }
                        
                    })
                       {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.leading, 20)
                            .padding(.top, 20)
                            .opacity(!sizing.isEmpty && !description.isEmpty ? 1.0 : 0.5)
                           Spacer()
                              
                    }
                       .padding(.top, -10)
                       .padding(.bottom, 10)
                List{
                    ForEach(uploadedRecipes){ recipe in
                        HStack{
                            Text(recipe.sizing)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                                //.padding(.leading, 20)
                            Spacer()
                            Text(recipe.description)
                                .font(.body)
                                //.padding(.trailing, 20)
                        }
                    }
                }
                .frame(height: 200) //list size
                .padding(.top, -25)
               
            }
            .padding(.top, 150) //moves down from instruction/directins modal
            }
        .padding(.top, -50)
        }
    }


struct EditorIngredients_Previews: PreviewProvider {
    static var previews: some View {
        EditorIngredients()
    }
}
