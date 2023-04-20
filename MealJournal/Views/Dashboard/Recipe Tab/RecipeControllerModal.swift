//
//  RecipeControllerModal.swift
//  MealJournal
//
//  Created by Jim Ciaston on 7/29/22.
//



import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI
import _PhotosUI_SwiftUI

@available(iOS 16.0, *)
struct RecipeControllerModal: View {
    @Environment(\.dismiss) var dismiss // << dismiss view
   
    @ObservedObject var rm = RecipeLogic()
    @StateObject var ema = EditModeActive()
    //displays image picker
    @State var showingImagePicker = false
    @State private var inputImage: Image?
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
    @State private var updatedRecipeImage: PhotosPickerItem?
    /*/
     can add if ingredients != ema.updatedINgredients then run the saveRecipes function
     .placeholder(Image("defaultRecipeImage").resizable())
     .resizable()
     .clipShape(RoundedRectangle(cornerRadius: 10.0))
     .frame(width:320, height: 200)
     .aspectRatio(contentMode: .fill)
 }
.padding(.top, 15)
     */
  
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    if let inputImage {
                        inputImage
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .frame(width:320, height: 200)
                            .aspectRatio(contentMode: .fill)
                        
                    } else{
                        WebImage(url: URL(string: image))
                            .placeholder(Image("defaultRecipeImage").resizable())
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .frame(width:320, height: 200)
                            .aspectRatio(contentMode: .fill)

                      
                        .onTapGesture {
                            if(ema.editMode){
                              showingImagePicker = true
                            }
                        }
                    }
                }
                .frame(width:300, height: 100)
                //show image picker
                       
                .onChange(of: updatedRecipeImage) { _ in
                    Task {
                        if let data = try? await updatedRecipeImage?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                inputImage = Image(uiImage: uiImage)
                                guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
                                let ref = FirebaseManager.shared.storage.reference(withPath: "\(uid)/recipeImage.jpg")
                                guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return }
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
                                        ema.recipeImage = url.absoluteString // Save the image URL to the recipe model'
                                        showingImagePicker = false
                                    }
                                }
                                return
                            }
                        }
                        print("Failed")
                    }
                }
               
                
      
                .sheet(isPresented: $showingImagePicker){
                    if #available(iOS 16.0, *) {
                        PhotosPicker("Select Recipe Image", selection: $updatedRecipeImage, matching: .images)
                            .onChange(of: showingImagePicker, perform: { _ in
                               dismiss()
                            })
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                RecipeDashHeader(recipeName: name, recipePrepTime: prepTime, caloriesPicker: recipeCaloriesMacro ,fatPicker: recipeFatMacro,carbPicker: recipeCarbMacro, proteinPicker: recipeProteinMacro, ema: ema)
                    .padding()
                    .padding(.top, 5)
                    .shadow(color: Color("LightWhite"), radius: 5, x: 8, y: 10)
                    .cornerRadius(25)
        
                //ingredients or directions selction
        RecipeNavigationModals(ema: ema, currentRecipeID: recipeID, directions: directions, ingredients: ingredients)
            .padding(.top, 70)
                     HStack{
                         Spacer() // << moves to the right
                         if ema.editMode{
                             DeleteRecipe(currentRecipeID: recipeID){
                                dismiss()
                             }
                             .alignmentGuide(.trailing) { d in d[.trailing] }
                             .padding(.trailing, 25)
                             .padding(.top, 25)
                         }
                         
                     }
                     .frame(height:40)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    if !ema.editMode {
                        Button(action: {
                            dismiss()
                        })
                        {
                            Text("Back")
                        }
                    }
                    else{
                        Button(action: {
                            ema.editMode.toggle()
                        })
                        {
                            Image(systemName: "x.square")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                                .opacity(0.8)
                        }
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
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.black.opacity(0.4))
                                        .cornerRadius(10)
//                                      Image(systemName: !ema.editMode ? "pencil.circle" : "")
//                                          .foregroundColor(.white)
//                                          .font(.body)
//                                          .padding(.trailing, 45)
                                      
                                      Text(!ema.editMode ? "Edit" : "Done")
                                          .foregroundColor(.white)
                                          .font(Font.headline.weight(.bold))
                                          .font(.title3)
                                          .padding([.leading, .trailing], 25)
                                  }
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
  
//struct RecipeControllerModal_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeControllerModal(
//            name: "Test Recipe",
//            prepTime: "30 mins",
//            image: "https://example.com/image.png",
//            ingredients: ["Flour": "2 cups", "Sugar": "1/2 cup"],
//            directions: ["Preheat oven to 350°F", "Mix flour and sugar in a bowl", "Bake for 20 mins"],
//            recipeID: "12345",
//            recipeCaloriesMacro: 500,
//            recipeFatMacro: 20,
//            recipeCarbMacro: 60,
//            recipeProteinMacro: 30
//        )
//    }
//}
