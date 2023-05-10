//
//  FollowersUsersView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/7/22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI



struct FollowersUsersView: View {
    @Environment (\.colorScheme) var colorScheme
    @State var userUID: String = ""
    @State var name: String = ""
    @State var userBio: String = ""
    @State var userProfilePicture: String = ""
    @State var userRecipes: [String:String] = [:]
    @State var exercisePreferences: [String] = [""]
    @State var isUserFollowed = false
    @State var fetchedUserRecipes = [RecipeItem]()
    @StateObject var rm = RecipeLogicNonUser()
    @StateObject var jm = JournalDashLogicNonUser()
    @State var userSocialLink: String = ""
    @State var followerUsersList = [followingUserData]()
    @State var fcmToken: String = ""
    
  //move below function to another view, shouldn't be in view
    func fetchFollowersList(){
        followerUsersList.removeAll()
       // var fetchedFollowingList = [String:String]()
        let uid = Auth.auth().currentUser?.uid ?? ""
        if uid != ""{
            FirebaseManager.shared.firestore.collection("users")
                .document(uid)
                .getDocument { (snapshot, err) in
                   guard let data = snapshot?.data()
                    else{
                        print ("error grabbing users ")
                        return
                    }
                   
                    let fetchedFollowersList = data ["followers"] as? [String] ?? [""]
                    //GRAB FOLLOWING LIST
                    for user in fetchedFollowersList {
                        if user != "" { // << if no user exists
                            FirebaseManager.shared.firestore.collection("users")
                                .document(user)
                                .getDocument {(snap, error) in
                                    guard let userData = snap?.data() else { return }
                                    
                                    userUID = userData["uid"] as? String ?? ""
                                    name = userData ["name"] as? String ?? "Name Unavailable"
                                    userProfilePicture = userData ["profilePicture"] as? String ?? "Image Unavailable"
                                    exercisePreferences = userData ["exercisePreferences"] as? [String] ?? ["Unavailable"]
                                    userSocialLink = userData ["userSocialLink"] as? String ?? "Invalid link"
                                    fcmToken = userData ["token"] as? String ?? ""
                                    let newUser = followingUserData(uid: userUID, name: name, bio: userBio, profilePicture: userProfilePicture, recipes: userRecipes, isFollowed: isUserFollowed, socialLink: userSocialLink, exercisePreferences: exercisePreferences, fcmToken: fcmToken)
                                    followerUsersList.append(newUser)
                                    
                                    FirebaseManager.shared.firestore.collection("users").document(userUID).collection("userRecipes")
                                        .getDocuments { recipeDocumentSnapshot, error in
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
       

    }
    var body: some View {
        VStack{
            if userUID == "" {
                Text("You currently don't have any followers")
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .offset(y: 250)
            }
            else {
                ForEach(followerUsersList, id: \.self) { user in
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
            fetchFollowersList()
        }
        }

    }


//struct FollowersUsersView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowersUsersView()
//    }
//}
