//
//  RecipeControllerModal.swift
//  MealJournal
//
//  Created by Jim Ciaston on 7/29/22.
//

import SwiftUI

import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI

struct RecipeControllerModal: View {
    @Environment(\.dismiss) var dismiss // << dismiss view
    
    @ObservedObject var rm = RecipeLogic()
    @StateObject var ema = EditModeActive()
    //displays image picker
    @State var showingImagePicker = false
    @State private var inputImage: UIImage?
    @ObservedObject var keyboardResponder = KeyboardResponder()
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
                   
                }
            }
        }
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    WebImage(url: URL(string: image))
                        .placeholder(Image("defaultRecipeImage-2").resizable())
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .frame(width:350, height: 200)
                        .aspectRatio(contentMode: .fill)
                    }
                .padding(.top, 15)
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
                
                RecipeDashHeader(recipeName: name, recipePrepTime: prepTime, caloriesPicker: recipeCaloriesMacro ,fatPicker: recipeFatMacro,carbPicker: recipeCarbMacro, proteinPicker: recipeProteinMacro, ema: ema)
                    .padding()
        
                //ingredients or directions selction
        RecipeNavigationModals(ema: ema, currentRecipeID: recipeID, directions: directions, ingredients: ingredients)
            .padding(.top, 70)
                
                
                     HStack{
                         Spacer() // << moves to the right
                         DeleteRecipe(currentRecipeID: recipeID){
                            dismiss()
                         }
                         .alignmentGuide(.trailing) { d in d[.trailing] }
                         .padding(.trailing, 25)
                         .padding(.top, 25)
                     }
                     .frame(height:40)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        dismiss()
                    })
                    {
                        Text("Back")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            ema.editMode.toggle()
                          
                          //  if user is saving when complete is on the button
                            if !ema.editMode {
                                //save image to firestore

                                rm.updateRecipeImage(recipeImage: ema.recipeImage, currentRecipe: recipeID)

                                //save dash headers to firestore
                                rm.saveDashHeaders(recipeTitle: ema.recipeTitle, recipePrepTime: ema.recipePrepTime, recipeCaloriesMacro: ema.recipeCaloriesMacro, recipeFatMacro: ema.recipeFatMacro, recipeCarbMacro: ema.recipeCarbMacro, recipeProteinMacro: ema.recipeProteinMacro, currentRecipe: recipeID)

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
                                        .foregroundColor(.black)
                                        .font(.title3)
                                Text(!ema.editMode ? "Edit" : "Complete")
                                    .foregroundColor(.black) .font(Font.headline.weight(.bold))
                                    .font(.title3)
                                }
                        }
                    }
                }
        //delete recipe
           
//                HStack{
//                    Spacer() // << moves to the right
//                    DeleteRecipe(currentRecipeID: recipeID){
//                       dismiss()
//                    }
//                    .alignmentGuide(.trailing) { d in d[.trailing] }
//                    .padding(.trailing, 25)
//                }
//               // .padding(.top, -50)
//              //  .padding(.bottom, 100)
//                .frame(height:40)
//
        
        //offsets toolbar, if text removed, would interrupt toolbar.
       //Text("")
                  
        //edit recipe button

            }
           
        }
       
       
      }
    }
  
      
