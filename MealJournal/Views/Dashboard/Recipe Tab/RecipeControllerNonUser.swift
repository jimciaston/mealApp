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
    @ObservedObject var ema = EditModeActive()
    //displays image picker
   
    @ObservedObject var rm = RecipeLogicNonUser()
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
    @State var userName: String
    @State var userUID: String
    @State var isRecipeSaved = false
    @State var showSavedMessage = false
    @State var isUserFollowed = false
  
    @State private var sheetMode: SheetMode = .none
    
    @Binding var notCurrentUserProfile: Bool
    var userModel: UserModel
    //check if recipeID is saved by user
    func checkIfRecipeExists(recipeID: String) {
        // grab current user
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("savedUserRecipesNonUser")
            .whereField("recipeID", isEqualTo: recipeID)
            .getDocuments { (snapshot, err) in
                guard let recipeList = snapshot else { return }
                //recipe exists
                    if recipeList.count > 0 {
                        isRecipeSaved = true
                    }
                //no saved recipes from user
                    else {
                        isRecipeSaved = false
                    }
              
            }
       
    }
    /*/
     can add if ingredients != ema.updatedINgredients then run the saveRecipes function
     
     */
    
    //Save updatedRecipe picture to firestore
   
    
    //check if user is followed
    func isCurrentUserfollowingUser(userUID: String) -> Bool{
        FirebaseManager.shared.firestore.collection("users")
            .whereField("FollowingUsersList", arrayContains: userUID)
            .getDocuments { (snapshot, err) in
                guard let followingList = snapshot else { return }
                if followingList.count > 0 {
                    isUserFollowed = true
                }
                else {
                    isUserFollowed = false
                }
            }
       
        return isUserFollowed
    }
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack(alignment: .topTrailing) {
                  WebImage(url: URL(string: image))
                      .placeholder(Image("recipeImageNew").resizable())
                      .clipShape(RoundedRectangle(cornerRadius: 10.0))
                      .frame(width:350, height: 200)
                      .aspectRatio(contentMode: .fill)
                  Image(systemName: "bookmark.square.fill")
                      .font(.largeTitle)
            //styling for colors of icon if saved / not saved
                      .foregroundStyle(
                          isRecipeSaved ? Color.white : Color.white,
                          isRecipeSaved ? Color.yellow : Color.gray
                      )
                     // .animation(Animation.easeInOut(duration: 0.3))
                      .padding(.top, 25)
                      .padding(.leading, -60)
                  
                      .onTapGesture{
                         
                          if isRecipeSaved{
                              switch sheetMode {
                                  case .none:
                                      sheetMode = .mealTimingSelection
                                  case .mealTimingSelection:
                                      sheetMode = .none
                                  case .quarter:
                                      sheetMode = .none
                              }
                             // rm.deleteRecipe(selectedRecipeID: recipeID)
                             // dismiss()
                          }
                          else{
                              if isUserFollowed { // << don't allow if user is not followed
                                  rm.saveUserRecipe(userName: userName, recipeImage: image, recipeTitle: name, recipePrepTime: prepTime, recipeCaloriesMacro: recipeCaloriesMacro, recipeFatMacro: recipeFatMacro, recipeCarbMacro: recipeCarbMacro, recipeProteinMacro: recipeProteinMacro, createdAt: Date.now, ingredientItem: ingredients, directions: directions, recipeID: recipeID, userUID: userUID)
                                  
                                 isRecipeSaved = true
                                  showSavedMessage = true
                                  //keep here until I test
                                  let generator = UINotificationFeedbackGenerator()
                                      generator.notificationOccurred(.success)
                                      
                                  DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                      showSavedMessage = false
                                  }
                              }
                             
                          }
             
                      }
                      .onAppear{
                         //check if recipe is saved or not
                         
                        checkIfRecipeExists(recipeID: recipeID)
                        rm.grabSavedUserRecipes() // refresh list
                          isCurrentUserfollowingUser(userUID: userUID) // << check if user is followed (allow to save re
                                                                 
                      }
                    
                    if showSavedMessage {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 80)
                                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                            VStack {
                                Text("Recipe Saved!")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.top, 16)
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                                    .padding(.bottom, 16)
                            }
                        }
                                    .offset(x: -30, y: 65)
                                    .transition(.opacity.animation(.easeInOut(duration: 1)))
                                }
                }
       
        .padding(.top, 65)
        .frame(width:300, height: 120)
        
       
        
//show image picker
       

                RecipeDashHeader_SavedRecipes(recipeName: name, recipePrepTime: prepTime, caloriesPicker: recipeCaloriesMacro ,fatPicker: recipeFatMacro,carbPicker: recipeCarbMacro, proteinPicker: recipeProteinMacro,userName: userName ,ema: ema, userUID: userUID, notCurrentUserProfile: notCurrentUserProfile, userModel: userModel)
            .padding()
            .padding(.top, 15)
            .shadow(color: Color("LightWhite"), radius: 5, x: 10, y: 10)
            .cornerRadius(25)
            
        //ingredients or directions selction
RecipeNavigationModals(ema: ema, currentRecipeID: recipeID, directions: directions, ingredients: ingredients)
    .padding(.top, 70)
   

//offsets toolbar, if text removed, would interrupt toolbar.

    
//edit recipe button

    }
    .opacity(sheetMode == .none ? 1 : 0.3)
    .blur(radius: sheetMode == .none ? 0 : 3)
        }
                   
        //yes/no dialog box
        FlexibleSheet(sheetMode: $sheetMode) {
            VStack {
              Text("Remove Recipe Bookmark?")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                HStack{
                    Button(action: {
                        sheetMode = .none
                    })
                    {
                        Text("No")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    //button styling
                    .frame(width: 80, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding()
                    //yes button
                    Button(action: {
                        rm.deleteRecipe(selectedRecipeID: recipeID)
                        dismiss()
                    }) {
                      Text("Yes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    }
                    //button styling
                    .frame(width: 80, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 5)
                }
            
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding()
            .shadow(radius: 10)
            .frame(width:355, height: 100)
            //sets coordinates of view on dash
         .offset(y:-500)
        }
        .frame(height: sheetMode == .none ? 0 : 100)
    }
 
}
       
      
//    
//struct RecipeControllerNonUser_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeControllerNonUser(name: "Jumbalaya", prepTime: "30 min", image: "", ingredients: [:], directions: [], recipeID: "", recipeCaloriesMacro: 220, recipeFatMacro: 12, recipeCarbMacro: 40, recipeProteinMacro: 20, userName: "leave for nowf", userUID: "0")
//    }
//}