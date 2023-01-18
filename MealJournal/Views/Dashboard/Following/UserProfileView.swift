//
//  UserProfileView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 8/19/22.
//
/*
 Non user profile view
 
 */

import SwiftUI
import SDWebImageSwiftUI
import Firebase


struct UserProfileView: View {
    @State var userUID: String
    @State var name: String
    @State var userBio: String
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
                    let recipeCaloriesMacro = data ["recipeCaloriesMacro"] as? Int ?? 0
                    let recipeFatMacro = data ["recipeFatMacro"] as? Int ?? 0
                    let recipeCarbMacro = data ["recipeCarbMacro"] as? Int ?? 0
                    let recipeProteinMacro = data ["recipeProteinMacro"] as? Int ?? 0
                    let recipe = RecipeItem(id: recipeID, recipeTitle:recipeTitle , recipePrepTime: recipePrepTime, recipeImage: recipeImage, createdAt: createdAt, recipeCaloriesMacro: recipeCaloriesMacro, recipeFatMacro: recipeFatMacro, recipeCarbMacro:recipeCarbMacro, recipeProteinMacro: recipeProteinMacro, directions: directions, ingredientItem: ingredients)
                    
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
                        Text(name ?? "" ).bold()
                            .font(.title2)
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
                                     .background(Color("ButtonTwo"))
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
                    //check if user is followed
                    .onAppear{
                        isCurrentUserfollowingUser()
                    }
                    Spacer()
                   //display user recipes
                 //   ProfileCardsMainDisplay
                    Spacer()
                    
                    Text("About Me")
                        .font(.title3)
                        .padding(.bottom, -10)
                    
                    //User Bio
                    ProfileBio(userBio: $userBio )
                        .padding(.top, -5)
                        .minimumScaleFactor(0.5)
                        .padding(.bottom, 10)
                 
                    .padding(.top, -15)// << bring follow/followers up
                    
                    //Display recipes
                    ProfileCardsNonUserDisplay(userUID: userUID)
                        .padding(.top, -10)
                    Spacer()
                    
                }
       
    }
        
        
    
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userUID: "223", name: "Teddy", userBio: "This thing on?", userProfilePicture: "", userRecipes: ["1 cup": "Water"])
    }
}
