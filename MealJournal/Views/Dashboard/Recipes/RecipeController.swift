//
//  RecipeView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/15/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeController: View {
    @State var name: String
    @State var image: String
    @State var recipeEdit = true
    @State var ingredients: [String: String]
    @State var directions: [String]
    @State var recipeID: String
    
    var body: some View {
                VStack(){
                    WebImage(url: URL(string: image))
                        .placeholder(Image("defaultRecipeImage-2").resizable())
                        .resizable()
                        .frame(width:500, height: 250)
                        .aspectRatio(contentMode: .fill)
                        
                    }
                .frame(width:300, height: 80)
        
                RecipeDashHeader(recipeName: name)
                    .padding()
        
                //ingredients or directions selction
        RecipeNavigationModals(directions: directions, ingredients: ingredients)
            .padding(.top, 50)
      }
    
    }
                
//    .toolbar{
//        ToolbarItem(placement: .bottomBar){
//                Button(action: {
//
//                }){
//                    HStack{
//                    Image(systemName: "pencil.circle").foregroundColor(.black)
//                        Text("Edit")
//                        .foregroundColor(.black)
//                    }
//                    .font(.title)
//                }
//                .edgesIgnoringSafeArea(.all)
//                .frame(maxWidth: .infinity)
//                .frame(height: 60)
//
//            }
//        }
                
                
         
      
       



//struct RecipeController_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeController(name: .constant(true), image: .constant(true))
//    }
//}

