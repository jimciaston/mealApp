//
//  ShowFollowingView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/2/22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct followingUserData: Hashable {
    var uid: String
    var name: String
    var bio: String
    var profilePicture: String
    var recipes: [String:String]
    var isFollowed: Bool
    var socialLink: String
    var exercisePreferences: [String]
    var fcmToken: String
    func hash(into hasher: inout Hasher) {
            hasher.combine(uid)
            hasher.combine(name)
            hasher.combine(bio)
            hasher.combine(profilePicture)
            hasher.combine(recipes)
            hasher.combine(isFollowed)
            hasher.combine(socialLink)
            hasher.combine(exercisePreferences)
            hasher.combine(fcmToken)
        }
}



struct FollowingUsersView: View {
    @Environment (\.colorScheme) var colorScheme
    @State var userUID: String = ""
    @State var followingUsers: [followingUserData] = []
    @State var name: String = ""
    @State var userBio: String = ""
    @State var userProfilePicture: String = ""
    @State var userRecipes: [String:String] = [:]
    @State var isUserFollowed = false
    @State var fetchedUserRecipes = [RecipeItem]()
    @State var exercisePreferences: [String] = [""]
    @State var userSocialLink: String = ""
    @State var fcmToken: String = ""
    @State var followingUsersList = [Any]()
    @StateObject var rm = RecipeLogicNonUser()
    @StateObject var jm = JournalDashLogicNonUser()
    /*
     this works, just need to unwrap snapshot data better.

     */

    func fetchFollowingList(){
        followingUsers.removeAll()
       // var fetchedFollowingList = [String:String]()
        let uid = Auth.auth().currentUser?.uid ?? "no name"
        FirebaseManager.shared.firestore.collection("users")
            .document(uid)
            .getDocument { (snapshot, err) in
               guard let data = snapshot?.data()
                else{
                    print ("error grabbing users ")
                    return
                }
                let fetchedFollowingList = data ["FollowingUsersList"] as? [String] ?? [""]
                //GRAB FOLLOWING LIST
                for user in fetchedFollowingList {
                    if user != "" {
                        FirebaseManager.shared.firestore.collection("users")
                            .document(user)
                            .getDocument {(snap, error) in
                                guard let userData = snap?.data() else { return }
                                userUID = userData["uid"] as? String ?? ""
                                name = userData ["name"] as? String ?? "Name Unavailable"
                                exercisePreferences = userData ["exercisePreferences"] as? [String] ?? ["Unavailable"]
                                userProfilePicture = userData ["profilePicture"] as? String ?? "Image Unavailable"
                                exercisePreferences = userData ["exercisePreferences"] as? [String] ?? [""]
                                fcmToken = userData ["token"] as? String ?? ""
                                let newUser = followingUserData(uid: userUID, name: name, bio: userBio, profilePicture: userProfilePicture, recipes: userRecipes, isFollowed: isUserFollowed, socialLink: userSocialLink, exercisePreferences: exercisePreferences, fcmToken: fcmToken)
                                followingUsers.append(newUser)
                              
                                FirebaseManager.shared.firestore.collection("users").document(userUID).collection("userRecipes")
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
                    }

                }
            }

    }

    var body: some View {
        VStack{
            if userUID == ""{
                Text("You currently aren't following any users")
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .offset(y: 250)
            }

            else{
                ForEach(followingUsers, id: \.self){ user in
                    NavigationLink(destination: UserProfileView(userUID: user.uid, name: user.name, userBio: userBio, userProfilePicture: user.profilePicture, journalCount: jm.userJournalCountNonUser, rm: rm, jm: jm, userSocialLink: user.socialLink, exercisePreferences: user.exercisePreferences, fcmToken: user.fcmToken ).onAppear{
                        jm.grabUserJournalCount(userID: userUID)
                        rm.grabRecipes(userUID: userUID)
                    }){
                                VStack{
                                    HStack{
                                        WebImage(url: URL(string: user.profilePicture))
                                                .placeholder(Image("profileDefaultPicture"))
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width:60, height: 60)
                                                .clipShape(Circle())
                                                .padding(.leading, 20)
                                                .padding(.trailing, 25)
                                        
                                         
                                        VStack{
                                            HStack{
                                                Text(user.name)
                                                    .font(.title3)
                                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                                Spacer()
                                            }
                                          
                                            
                                            HStack {
                                                HomePageExercisePreferencesView(exercisePreferences: user.exercisePreferences)
                                                Spacer()
                                            }
                                            .padding(.top, -5)
                                          

                                        }
                                      
                                    }
                                    .frame(height: 50)
                                    .padding(.leading, -20)
                                    .padding()
                                    
                                  
                                    .frame(maxWidth: 360)
                                }
                              
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(colorScheme == .dark ? Color.gray : Color.white)
                                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                                       
                                )
                        }
                    }
                }
            }
        Spacer()
        .onAppear(){
            fetchFollowingList()
        }
    }
}

//struct ShowFollowingView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowingUsersView()
//    }
//}
