//
//  FollowersListView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/15/23.
//

import SwiftUI
import SDWebImageSwiftUI
 
struct FollowersListView_NonUser: View {
    @State var userUID: String
    @State var followingUserUID: String = ""
    @State var name: String = ""
    @State var userBio: String = ""
    @State var userBioPulled: String = ""
    @State var userProfilePicture: String = ""
    @State var userRecipes: [String:String] = [:]
    @State var isUserFollowed = false
    @State var fetchedUserRecipes = [RecipeItem]()
    @State var exercisePreferences: [String] = [""]
    @State var userSocialLink: String = ""
    @StateObject var rm = RecipeLogicNonUser()
    @StateObject var jm = JournalDashLogicNonUser()
   
    @State private var userModel = [UserModelFirestore]()
    var listIsEmptyMessage: String
    
    /*
     this works, just need to unwrap snapshot data better.

     */

    
    func fetchFollowersList(){
        var userName = ""
        userModel = []
       // var fetchedFollowingList = [String:String]()
        if userUID != "" {
            FirebaseManager.shared.firestore.collection("users")
                .document(userUID)
                .getDocument { (snapshot, err) in
                   guard let data = snapshot?.data()
                    else{
                        print ("error grabbing users ")
                        return
                    }
                    let fetchedFollowersList = data ["followers"] as? [String] ?? [""]
                    //GRAB FOLLOWING LIST
                    for user in fetchedFollowersList {
                        print(user)
                        if !user.isEmpty {
                           
                            FirebaseManager.shared.firestore.collection("users")
                                .document(user)
                                .getDocument {(snap, error) in
                                    guard let userData = snap?.data() else { return }
                                    print(userData)
                                    followingUserUID = userData["uid"] as? String ?? ""
                                    userBioPulled = userData["userBio"] as? String ?? ""
                                    userName = userData ["name"] as? String ?? "Name Unavailable"
                                    userProfilePicture = userData ["profilePicture"] as? String ?? "Image Unavailable"
                                    exercisePreferences = userData ["exercisePreferences"] as? [String ] ?? ["Unavailable"]
                                    userSocialLink = userData["userSocialLink"] as? String ?? "Unavailable"
                                    FirebaseManager.shared.firestore.collection("users").document(followingUserUID).collection("userRecipes")
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
                                            var userFirestore = UserModelFirestore(username: userName, userID: followingUserUID, userBio: userBio, profileImage: userProfilePicture, recipeInfo: fetchedUserRecipes)
                                            userModel.append(userFirestore)
                                        }
                                }
                           
                        }
                    }
                }
            }
        }

    var body: some View {
        VStack{
            if followingUserUID == ""{
                Text(listIsEmptyMessage)
            }

            else{
                
                ForEach(userModel, id: \.id) { user in
                    NavigationLink(destination: UserProfileView(userUID: user.userID, name: user.username, userBio: user.userBio, userProfilePicture: user.profileImage, journalCount: jm.userJournalCountNonUser, rm: rm, jm: jm, userSocialLink: userSocialLink, exercisePreferences: exercisePreferences).padding(.top, -50).onAppear{
                        jm.grabUserJournalCount(userID: user.userID)
                        rm.grabRecipes(userUID: user.userID)
                    }){
                        VStack{
                            VStack{
                                HStack{
                                    WebImage(url: URL(string: user.profileImage))
                                            .placeholder(Image("profileDefaultPicture"))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width:60, height: 60)
                                            .clipShape(Circle())
                                            .padding(.leading, 20)
                                            .padding(.trailing, 25)
                                    
                                     
                                    VStack{
                                        HStack{
                                            Text(user.username)
                                                .font(.title)
                                                
                                            Spacer()
                                        }
                                      
                                        
                                        HStack {
                                            HomePageExercisePills_NonUser(exercisePreferences: exercisePreferences)
                                            
                                            Spacer()
                                        }
                                        
                                        .padding(.top, -5)
                                      

                                    }
                                  
                                }
                                
                                .padding(.leading, -20)
                                .padding()
                                
                              
                                .frame(maxWidth: 380)
                            }
                          
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                                   
                            )

                        }
                        .padding(.bottom, 20)
                    }
                 
                }
                    Spacer()

            }
        }
        Spacer()
        .onAppear(){
            fetchFollowersList()
        }
    }
}


