//
//  Recipe Ingredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/15/22.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct RecipeIngredients: View {
    @State private var sheetMode: SheetMode = .quarter
    @ObservedObject var rm = RecipeLogic()
    @Binding var ingredients: [String: String]
   //will comment back in later
//    init(){
//        UITableView.appearance().backgroundColor = .clear
//    }
//
    var body: some View {
        ZStack{
            VStack{
                List{
                    ForEach(Array(ingredients), id:\.key){ measurement, ingredient in
                        HStack{
                           Text(measurement)
                               .font(.title2)
                               .foregroundColor(.green)
                               .fontWeight(.bold)
                           Text(ingredient)
                               .font(.title3)
                       }
                    }
                }
                .listStyle(SidebarListStyle())
            
                }
          
            }
        }
    }


//struct Recipe_Ingredients_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeIngredients()
//    }
//}

