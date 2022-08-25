//
//  UserProfileRecipeView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 8/23/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfileRecipeView: View {
    @StateObject var rm = RecipeLogic()
    @ObservedObject var ema = EditModeActive()
    //displays image picker
    @State var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State var name: String
    @State var prepTime: String
    @State var image: String
    @State var ingredients: [String: String]
    @State var directions: [String]
    @State var recipeID: String
    @State var recipeFatMacro: Int
    @State var recipeCarbMacro: Int
    @State var recipeProteinMacro: Int

    /*/
     can add if ingredients != ema.updatedINgredients then run the saveRecipes function
     
     */
    
    
    var body: some View {
                VStack{
                    WebImage(url: URL(string: image))
                        .placeholder(Image("defaultRecipeImage-2").resizable())
                        .resizable()
                        .frame(width:500, height: 250)
                        .aspectRatio(contentMode: .fill)
                    }
                
                .edgesIgnoringSafeArea(.all)
                .frame(width:300, height: 40)
       
        RecipeDashHeader(recipeName: name, recipePrepTime: prepTime, fatPicker: recipeFatMacro,carbPicker: recipeCarbMacro, proteinPicker: recipeProteinMacro, ema: ema)
           
                    .padding()
        
                //ingredients or directions selction
        RecipeNavigationModals(ema: ema, currentRecipeID: recipeID, directions: directions, ingredients: ingredients)
            .padding(.top, 50)
        
        //delete recipe
       
        //offsets toolbar, if text removed, would interrupt toolbar.
       
     
        
      }
    }
//
//struct UserProfileRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileRecipeView()
//    }
//}
