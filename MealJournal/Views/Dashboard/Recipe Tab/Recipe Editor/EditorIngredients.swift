//
//  EditorIngredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/12/22.
//READY FOR CORE DATA

import SwiftUI

struct EditorIngredients: View {
    @EnvironmentObject var recipeClass: Recipe
    
    @State private var sizing: String = ""
    @State private var description: String = ""
    //@State private var counter = 1
    @State private var filledOut = false
    

   
    var body: some View {
       
            VStack{
                HStack{
                    TextField("ex. 1 cup", text: $sizing)
                        .font(.body)
                        .padding(.leading, 30)
                       
                    TextField("ex. Chicken Breast", text: $description)
                        .font(.body)
                }
                //.padding(.top, 25) //set to give space from ingredient/direction section
                
                    Button(action: {
                        if (sizing != "" && description != ""){
                            let newIngredient = Ingredients(sizing: sizing, description: description)
                            recipeClass.ingredients.append(newIngredient)
                                //clear when appended
                                sizing = ""
                                description  = ""
                        }
                        
                    })
                       {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.leading, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                            .opacity(!sizing.isEmpty && !description.isEmpty ? 1.0 : 0.5)
                           Spacer()
                              
                    }
                       .padding(.top, -10)
                       .padding(.bottom, 10)
                
                List{
                    ForEach(recipeClass.ingredients){ recipe in
                        HStack{
                            Text(recipe.sizing)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color("UserProfileCard1"))
                                //.padding(.leading, 20)
                            Spacer()
                            Text(recipe.description)
                                .font(.body)
                                //.padding(.trailing, 20)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        recipeClass.ingredients.remove(atOffsets: indexSet)
                    })
                }
                .listStyle(PlainListStyle())
            }
        }
    }


struct EditorIngredients_Previews: PreviewProvider {
    static var previews: some View {
        EditorIngredients().environmentObject(Recipe())
    }
}
