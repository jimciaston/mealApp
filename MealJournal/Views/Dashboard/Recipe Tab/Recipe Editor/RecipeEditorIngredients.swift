//
//  RecipeEditorIngredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/12/22.
//

import SwiftUI

struct RecipeEditorIngredients: View {
    var body: some View {
        ZStack{
            VStack{
                List{
                    HStack{
                        Text("4 oz")
                            .font(.title2)
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .padding(5)
                            .border(.black)
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

struct RecipeEditorIngredients_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorIngredients()
    }
}
