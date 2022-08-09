//
//  RecipeView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/15/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeController: View {
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
    
    //Save updatedRecipe picture to firestore
    private func persistImageToStorage() {
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
            let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        
            guard let imageData = self.inputImage?.jpegData(compressionQuality: 0.5) else { return }
            ref.putData(imageData, metadata: nil) { metadata, err in
                if let err = err {
                   print("failed to push to storage \(err)")
                    return
                }

                ref.downloadURL { url, err in
                    if let err = err {
                        print("failed to fetch download link")
                        return
                    }

                   print("Image saved Successfully")
                    guard let url = url else { return }
                    
                    //save
                    image = url.absoluteString
                    ema.recipeImage = url.absoluteString
                    //recipeLogic Call
                   
                    
                }
            }
        }
    
    var body: some View {
                VStack{
                    WebImage(url: URL(string: image))
                        .placeholder(Image("defaultRecipeImage-2").resizable())
                        .resizable()
                        .frame(width:500, height: 250)
                        .aspectRatio(contentMode: .fill)
                    }
                .onChange(of: inputImage, perform: { _ in
                    persistImageToStorage()
                })
                .edgesIgnoringSafeArea(.all)
                .frame(width:300, height: 40)
        //show image picker
                .onTapGesture {
                    if(ema.editMode){
                      showingImagePicker = true
                    }
                }
                .sheet(isPresented: $showingImagePicker){
                    EditorImagePicker(image: $inputImage)
                }
    
        RecipeDashHeader(recipeName: name, recipePrepTime: prepTime, fatPicker: recipeFatMacro,carbPicker: recipeCarbMacro, proteinPicker: recipeProteinMacro, ema: ema)
           
                    .padding()
        
                //ingredients or directions selction
        RecipeNavigationModals(ema: ema, currentRecipeID: recipeID, directions: directions, ingredients: ingredients)
            .padding(.top, 50)
        
        //delete recipe
        if ema.editMode{
            DeleteRecipe(currentRecipeID: recipeID)
        }
        //offsets toolbar, if text removed, would interrupt toolbar.
       Text("")
            
        //edit recipe button
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        ema.editMode.toggle()
                      
                        //if user is saving when complete is on the button
                        if !ema.editMode {
                            //save image to firestore
                           
                            rm.updateRecipeImage(recipeImage: ema.recipeImage, currentRecipe: recipeID)
                            
                            //save dash headers to firestore
                            rm.saveDashHeaders(recipeTitle: ema.recipeTitle, recipePrepTime: ema.recipePrepTime, recipeFatMacro: ema.recipeFatMacro, recipeCarbMacro: ema.recipeCarbMacro, recipeProteinMacro: ema.recipeProteinMacro, currentRecipe: recipeID)
                            
                            if ema.isIngredientsActive{
                                    rm.saveRecipeIngredients(ingredientList: ema.updatedIngredients, currentRecipe: recipeID)
                            }
                            else{
                                if ema.isDirectionsActive{
                                    rm.saveRecipeDirections(directions: ema.updatedDirections, currentRecipe: recipeID)
                                }
                            }
                        }
                    }){
                        HStack{
                            Image(systemName: !ema.editMode ? "pencil.circle" : "")
                                    .foregroundColor(.white)
                                    .font(.title3)
                            Text(!ema.editMode ? "Edit" : "Complete")
                                .foregroundColor(.white) .font(Font.headline.weight(.bold))
                                .font(.title3)
                            }
                      

                    }
                   
                    
                }
           
            }
        
      }
    }
  
                
                
         
      
//
//
//
//
//struct RecipeController_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeController(name: "jimmy", prepTime: "20 mins", image: "", ingredients: ["peppers": "ghost"], directions: ["hello"], recipeID: "223")
//    }
//}

