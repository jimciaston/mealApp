//
//  Recipe Ingredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/15/22.
//

import SwiftUI


struct RecipeIngredients: View {
    
    @State private var sheetMode: SheetMode = .quarter
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            VStack{
                List{
                    HStack{
                        Text("4 oz")
                            .font(.title2)
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                        Text("Chicken Breast")
                            .font(.title3)
                    }
                    
                    HStack{
                        Text("1 cup")
                            .font(.title2)
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                        Text("Milk")
                            .font(.title3)
                    }
                    
                    HStack{
                        Text("3 cups")
                            .font(.title2)
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                        Text("BreadCrumbs")
                            .font(.title3)
                    }
                    
                }
                .listStyle(SidebarListStyle())
                
                
                
                }
          
            
            }
        }
    }


struct Recipe_Ingredients_Previews: PreviewProvider {
    static var previews: some View {
        RecipeIngredients()
    }
}

