//
//  RecipeView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/15/22.
//

import SwiftUI

struct RecipeController: View {
   @State var name: String
    @State var image: String
   
    @State var recipeEdit = true
    
    var recipeList = RecipeList.recipes
    var body: some View {
        
                VStack(){
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:300, height: 100)
                    }
                
                RecipeDashHeader(recipeName: name)//title
                    .padding()
          
                RecipeNavigationModals()
                   
            
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

