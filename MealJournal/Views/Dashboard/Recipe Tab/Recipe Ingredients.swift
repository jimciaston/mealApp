//
//  Recipe Ingredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/15/22.
//

import SwiftUI
import FirebaseFirestore
import Firebase
import OrderedCollections


struct RecipeIngredients: View {
    @State private var sheetMode: SheetMode = .quarter
    @State private var sizing = ""
    @State private var description = ""
    
    @ObservedObject var rm = RecipeLogic()
    @ObservedObject var ema: EditModeActive
    
    @Binding var currentRecipeID: String
    @Binding var ingredients: [String: String]
    
    //turn into Ordered Dictionary so I can grab ingredients key
    func turnIntoOrderedDictionary(regularDictionary: [String: String]) -> OrderedDictionary <String, String>{
        var dict = OrderedDictionary <String, String> (
            uniqueKeys: regularDictionary.keys,
            values: regularDictionary.values
        )
        dict.sort()
        return dict
    }
   
    //produces view
    private func listContent(for keys: [String]) -> some View {
        ForEach(keys.reversed(), id: \.self) { key in
            HStack{
                Text(key)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("UserProfileCard1"))
                    .padding(.trailing, 15)
                
                Text(turnIntoOrderedDictionary(regularDictionary: ingredients)[key] ?? "default")
                    .font(.title3)
            }
        }
        .onDelete { indexSet in
            if ema.editMode{
                var ingredientsOrdered = turnIntoOrderedDictionary(regularDictionary: ingredients)
                let key = ingredientsOrdered.keys[indexSet.first!]
                ingredients.removeValue(forKey: key)
                ema.updatedIngredients = ingredients
            }
           
        }
    }
   
    var body: some View {
        ZStack{
            VStack{
                if ema.editMode{
                    HStack{
                        TextField("ex. 1 cup", text: $sizing)
                            .font(.body)
                            .padding(.leading, 30)
                            .submitLabel(.done)
                        TextField("ex. Chicken Breast", text: $description)
                            .font(.body)
                            .submitLabel(.done)
                    }
                    .padding(.top, 30) //set to give space from ingredient/direction section
                    
                    Button(action: {
                        if (sizing != "" && description != ""){
                            ingredients[sizing] = description
                            ingredients[sizing] = description
                            
                            ema.updatedIngredients[sizing] = description
                                sizing = ""
                                description  = ""
                        }
                        
                    })
                       {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.leading, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 5)
                            .opacity(!sizing.isEmpty && !description.isEmpty ? 1.0 : 0.5)
                           Spacer()
                              
                    }
                      
                }
                List{
                    self.listContent(for: Array(turnIntoOrderedDictionary(regularDictionary: ingredients).keys))
                  
                }
                .padding(.top, 15)
                .onAppear{
                    ema.updatedIngredients = ingredients
                }
                .listStyle(PlainListStyle())
            
                }
            }
        }
    }


//struct Recipe_Ingredients_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeIngredients()
//    }
//}

