//
//  ExistingRecipeIngredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/25/23.
//

import SwiftUI

struct ExistingRecipeIngredients: View {
    @EnvironmentObject var recipeClass: Recipe
    @ObservedObject var ema: EditModeActive
    @State private var sizing: String = ""
    @State private var description: String = ""
    //@State private var counter = 1
    @State private var filledOut = false
    @Binding var ingredients: [String : String]
  
    var body: some View {
        if ema.editMode{
            VStack{
                HStack{
                    TextField("ex. 1 cup", text: $sizing)
                        .font(.body)
                        .padding(.leading, 30)
                        .submitLabel(.done)
                       
                    TextField("ex. Chicken Breast", text: $description)
                        .font(.body)
                        .submitLabel(.done)
                }
                //.padding(.top, 25) //set to give space from ingredient/direction section
                
                    Button(action: {
                        if (sizing != "" && description != "") {
                               ingredients[sizing] = description
                            ema.updatedIngredients.updateValue(description, forKey: sizing)
                            ingredients = ema.updatedIngredients
                            ema.isIngredientsActive = true
                               sizing = ""
                               description = ""
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
                    ForEach(Array(ingredients), id: \.key) { key, value in
                        HStack{
                            Text(key)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color("UserProfileCard1"))
                                //.padding(.leading, 20)
                            Spacer()
                            Text(value)
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
        else{
            List{
                ForEach(Array(ingredients), id: \.key) { key, value in
                    HStack{
                        Text(key)
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(Color("UserProfileCard1"))
                            //.padding(.leading, 20)
                        Spacer()
                        Text(value)
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
//
//struct ExistingRecipeIngredients_Previews: PreviewProvider {
//    static var previews: some View {
//        ExistingRecipeIngredients()
//    }
//}
