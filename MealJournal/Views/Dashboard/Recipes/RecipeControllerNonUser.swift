//
//  RecipeControllerNonUser.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/24/23.
//

import SwiftUI

import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI

struct RecipeControllerNonUser: View {
    @Environment(\.dismiss) var dismiss // << dismiss view
    
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
    @State var recipeCaloriesMacro: Int
    @State var recipeFatMacro: Int
    @State var recipeCarbMacro: Int
    @State var recipeProteinMacro: Int

    /*/
     can add if ingredients != ema.updatedINgredients then run the saveRecipes function
     
     */
    
    //Save updatedRecipe picture to firestore
  
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    WebImage(url: URL(string: image))
                        .placeholder(Image("defaultRecipeImage-2").resizable())
                        .resizable()
                        .frame(width:500, height: 250)
                        .aspectRatio(contentMode: .fill)
                    }
               
                .edgesIgnoringSafeArea(.all)
                .frame(width:300, height: 40)
        //show image picker
              
    
                RecipeDashHeader(recipeName: name, recipePrepTime: prepTime, caloriesPicker: recipeCaloriesMacro ,fatPicker: recipeFatMacro,carbPicker: recipeCarbMacro, proteinPicker: recipeProteinMacro, ema: ema)
                    .padding()
        
                //ingredients or directions selction
        RecipeNavigationModals(ema: ema, currentRecipeID: recipeID, directions: directions, ingredients: ingredients)
            .padding(.top, 70)
    
        //offsets toolbar, if text removed, would interrupt toolbar.
      
            
        //edit recipe button
       
            }
        }
               
       
      }
    }
