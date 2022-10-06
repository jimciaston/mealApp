//
//  UserProfileView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 8/19/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct UserProfileView: View {
    @State var userUID: String
    @State var name: String
    @State var userProfilePicture: String
    @State var userRecipes: [String:String]
    @State var isUserFollowed = false
    @State var fetchedUserRecipes = [RecipeItem]()
    //get user recipes from database
   
    
    func getUserRecipes(uid: String){
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("userRecipes")
            .getDocuments{ recipeDocumentSnapshot, error in
                if let error = error {
                    print("Errors retreiving recipes")
                    return
                }
                recipeDocumentSnapshot?.documents.forEach({ recipeSnapshot in
                    let data = recipeSnapshot.data()
                 
                    let recipeTitle = data ["recipeTitle"] as? String ?? ""
                    let recipePrepTime = data ["recipePrepTime"] as? String ?? ""
                    let recipeImage = data ["recipeImage"] as? String ?? ""
                    let createdAt = data ["createdAt"] as? String ?? ""
                    let ingredients = data ["ingredientItem"] as? [String: String] ?? ["": ""]
                    let directions = data ["directions"] as? [String] ?? [""]
                    let recipeID = data ["recipeID"] as? String ?? ""
                    let recipeCalories = data ["recipeCaloriesMacro"] as? Int ?? 0
                    let recipeFatMacro = data ["recipeFatMacro"] as? Int ?? 0
                    let recipeCarbMacro = data ["recipeCarbMacro"] as? Int ?? 0
                    let recipeProteinMacro = data ["recipeProteinMacro"] as? Int ?? 0
                    let recipe = RecipeItem(id: recipeID, recipeTitle:recipeTitle , recipePrepTime: recipePrepTime, recipeImage: recipeImage, createdAt: createdAt, recipeCaloriesMacro: 0, recipeFatMacro: recipeFatMacro, recipeCarbMacro:recipeCarbMacro, recipeProteinMacro: recipeProteinMacro, directions: directions, ingredientItem: ingredients)
                    
               //first check if recipe ID exists by filtering by the id
                    let recipeExistence = fetchedUserRecipes.filter { $0.id == recipeID }
               //if it doens't exist, append recipe
                    if recipeExistence.isEmpty == true {
                        self.fetchedUserRecipes.append(recipe)
                    }
                })
            }
        }
    
    //check if user is being followed or not
    func isCurrentUserfollowingUser() -> Bool{
        FirebaseManager.shared.firestore.collection("users")
            .whereField("FollowingUsersList", arrayContains: userUID)
            .getDocuments { (snapshot, err) in
                guard let followingList = snapshot else { return }
                if followingList.count > 0 {
                    isUserFollowed = false
                }
                else {
                    isUserFollowed = true
                }
            }
       
        return isUserFollowed
    }
    
    var body: some View {
                VStack{
                    WebImage(url: URL(string: userProfilePicture))
                        .placeholder(Image("profileDefaultPicture").resizable())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:150, height: 150)
                            .clipShape(Circle())
                           
                    HStack{
                        Text(name ?? "" ) // << username
                    }
                    //get user recipes
                    .onAppear{
                        getUserRecipes(uid: userUID)
                    }
                        .padding()
                    
                    HStack{
                        //save following
                        Button(action: {
                            //grab current user UID
                        
                            guard let uid = Auth.auth().currentUser?.uid else { return } // << current user
                           
                            let followingUserUID = userUID // person following
               
                            
                            FirebaseManager.shared.firestore.collection("users")
                                .whereField("FollowingUsersList", arrayContains: followingUserUID)
                                .getDocuments { (snapshot, err) in
                                    guard let followingList = snapshot else { return }
                                    if followingList.count > 0 {
                                        isUserFollowed = true
                                        FirebaseManager.shared.firestore.collection("users")
                                            .document(uid)
                                            .updateData([
                                                //updates current User
                                                "followingCount" : FieldValue.increment(Int64(-1)),
                                               
                                                "FollowingUsersList" : FieldValue.arrayRemove([followingUserUID]),
                                            ])
                                        isUserFollowed = false
                                        
                                        //Update user who is being followed
                                        FirebaseManager.shared.firestore.collection("users")
                                            .document(followingUserUID)
                                            .updateData([
                                                "followers": FieldValue.arrayRemove([uid]),
                                                "followersCount": FieldValue.increment(Int64(-1))
                                            ])
                                    }
                                    else {
                                        isUserFollowed = false
                                        //updates current User
                                        FirebaseManager.shared.firestore.collection("users")
                                          .document(uid)
                                          .updateData([
                                            "followingCount" : FieldValue.increment(Int64(1)),
                                              "FollowingUsersList" : FieldValue.arrayUnion([followingUserUID]), // << add to fire
                                          ])
                                        isUserFollowed = true
                                        
                                        //Updates user being followed
                                        FirebaseManager.shared.firestore.collection("users")
                                            .document(followingUserUID)
                                            .updateData([
                                                "followers": FieldValue.arrayUnion([uid]),
                                                "followersCount": FieldValue.increment(Int64(1))
                                            ])
                                    }
                                }
                            }){
                                Text(isCurrentUserfollowingUser() ? "Follow" : "Following") // << user followed yay or nay
                                     .frame(width: 85, height: 35)
                                     .border(.white)
                                     .foregroundColor(.white)
                                     .background(.green)
                                     .font(.body)
                            }
                        Link (destination: URL(string: "https://www.instagram.com/carolinafearfest/")!){
                            Image("Instagram_Logo_1")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 35, height: 35)
                                .padding(.leading, -5) // << bring closer to follow button
                        }
                             
                            }
                    .onAppear{
                        isCurrentUserfollowingUser()
                    }
                    Spacer()
                   //display user recipes
                }
        if fetchedUserRecipes.count != 0 {
                   VStack{
                       List{
                           //prefix = only show 3 recipes at a time
                           ForEach(fetchedUserRecipes.prefix(3)){ recipe in
                                   HStack{
                                       WebImage(url: URL(string: recipe.recipeImage))
                                          .aspectRatio(contentMode: .fill)
                                        .frame (width: 70, height:70)
                                        .cornerRadius(15)
                                VStack{
                                    ZStack{
                                        Text(recipe.recipeTitle)
                                            .font(.body)
                                        //temp solution until I can center it
                                            .padding(.top, 1)
                                        //as a note, sets empty view to hide list arrow
                                        NavigationLink(destination: {UserProfileRecipeView(name: recipe.recipeTitle,prepTime: recipe.recipePrepTime, image: recipe.recipeImage,  ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id, recipeCaloriesMacro: recipe.recipeCaloriesMacro, recipeFatMacro: recipe.recipeFatMacro, recipeCarbMacro: recipe.recipeCarbMacro, recipeProteinMacro: recipe.recipeProteinMacro)}, label: {
                                            emptyview()
                                            })
                                            .opacity(0.0)
                                            .buttonStyle(PlainButtonStyle())

                                        HStack{
                                            Text(String(recipe.recipeFatMacro) + "g")
                                                .foregroundColor(.gray)
                                            Text(String(recipe.recipeCarbMacro) + "g")
                                                .foregroundColor(.gray)
                                            Text(String(recipe.recipeProteinMacro) + "g")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.top, 80)
                                        .padding(.bottom, 10)
                                        .frame(height:90)
                                    }
                                    .padding(.top, -20)

                                    }
                                .padding(EdgeInsets(top: -5, leading: -25, bottom: 0, trailing: 0))
                                }
                            }

                    ZStack{
                        NavigationLink(destination:RecipeFullListView(recipes: fetchedUserRecipes)) {
                               emptyview()
                           }

                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())

                           HStack {
                               Text("View More")
                                   .font(.body)
                                   .frame(width:300)
                                   .padding(.top, 20)
                           }
                           
                    }
                }
            }
        }
        else{
            VStack{
                Image(systemName: "note")
                    .resizable()
                    .frame(width: 70, height: 70)
                    
                Text("User has yet to upload a recipe")
                    .font(.title3)
                    .padding()
                Spacer()
            }
            
        }
    }
        
        
    
}
//
//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView(name: "Teddy", userProfilePicture: "", userRecipes: ["1 cup": "Water"])
//    }
//}
