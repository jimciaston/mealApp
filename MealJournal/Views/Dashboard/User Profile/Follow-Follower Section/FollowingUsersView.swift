//
//  ShowFollowingView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/2/22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
//struct FollowingUsersView: View {
//    @State var userUID: String = ""
//    @State var name: String = ""
//    @State var userBio: String = ""
//    @State var userProfilePicture: String = ""
//    @State var userRecipes: [String:String] = [:]
//    @State var isUserFollowed = false
//    @State var fetchedUserRecipes = [RecipeItem]()
//
//    /*
//     this works, just need to unwrap snapshot data better.
//
//     */
//
//    func fetchFollowingList(){
//
//       // var fetchedFollowingList = [String:String]()
//        let uid = Auth.auth().currentUser?.uid ?? "no name"
//        FirebaseManager.shared.firestore.collection("users")
//            .document(uid)
//            .getDocument { (snapshot, err) in
//               guard let data = snapshot?.data()
//                else{
//                    print ("error grabbing users ")
//                    return
//                }
//                let fetchedFollowingList = data ["FollowingUsersList"] as? [String] ?? [""]
//                //GRAB FOLLOWING LIST
//                for user in fetchedFollowingList {
//                    FirebaseManager.shared.firestore.collection("users")
//                        .document(user)
//                        .getDocument {(snap, error) in
//                            guard let userData = snap?.data() else { return }
//                            userUID = userData["uid"] as? String ?? ""
//                            name = userData ["name"] as? String ?? "Name Unavailable"
//                            userProfilePicture = userData ["profilePicture"] as? String ?? "Image Unavailable"
//
//                            FirebaseManager.shared.firestore.collection("users").document(userUID).collection("userRecipes")
//                                .getDocuments{ recipeDocumentSnapshot, error in
//                                    if let error = error {
//                                        print("Errors retreiving recipes")
//                                        return
//                                    }
//                                    recipeDocumentSnapshot?.documents.forEach({ recipeSnapshot in
//                                        let data = recipeSnapshot.data()
//
//                                        let recipeTitle = data ["recipeTitle"] as? String ?? ""
//                                        let recipePrepTime = data ["recipePrepTime"] as? String ?? ""
//                                        let recipeImage = data ["recipeImage"] as? String ?? ""
//                                        let createdAt = data ["createdAt"] as? String ?? ""
//                                        let ingredients = data ["ingredientItem"] as? [String: String] ?? ["": ""]
//                                        let directions = data ["directions"] as? [String] ?? [""]
//                                        let recipeID = data ["recipeID"] as? String ?? ""
//                                        let recipeCaloriesMacro = data ["recipeCaloriesMacro"] as? Int ?? 0
//                                        let recipeFatMacro = data ["recipeFatMacro"] as? Int ?? 0
//                                        let recipeCarbMacro = data ["recipeCarbMacro"] as? Int ?? 0
//                                        let recipeProteinMacro = data ["recipeProteinMacro"] as? Int ?? 0
//                                        let recipe = RecipeItem(id: recipeID, recipeTitle:recipeTitle , recipePrepTime: recipePrepTime, recipeImage: recipeImage, createdAt: createdAt, recipeCaloriesMacro: recipeCaloriesMacro, recipeFatMacro: recipeFatMacro, recipeCarbMacro:recipeCarbMacro, recipeProteinMacro: recipeProteinMacro, directions: directions, ingredientItem: ingredients)
//
//                                   //first check if recipe ID exists by filtering by the id
//                                        let recipeExistence = fetchedUserRecipes.filter { $0.id == recipeID }
//                                   //if it doens't exist, append recipe
//                                        if recipeExistence.isEmpty == true {
//                                            self.fetchedUserRecipes.append(recipe)
//                                        }
//                                    })
//                                }
//                        }
//                }
//            }
//
//    }
//
//    var body: some View {
//        VStack{
//            if userUID == ""{
//                Text("You currently aren't following any users")
//            }
//
//            else{
//                HStack{
//                    NavigationLink(destination: UserProfileView(userUID: userUID, name: name, userBio: userBio, userProfilePicture: userProfilePicture)){
//                        WebImage(url: URL(string: userProfilePicture))
//                            .placeholder(Image("profileDefaultPicture"))
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width:60, height: 60)
//                            .clipShape(Circle())
//                            .padding(.trailing, 45)
//
//                    }
//                    .multilineTextAlignment(.center)
//
//               VStack{
//                   Text(name)
//                       .font(.title)
//
//                   NavigationLink(destination:  UserProfileView(userUID: userUID, name: name, userBio: userBio, userProfilePicture: userProfilePicture)){
//                       Text("View Profile")
//                       .font(.caption)
//                       .foregroundColor(.black)
//                       .padding(3) //general padding
//                       .padding([.leading, .trailing], 15) // << side padding
//                       .border(.black)
//                       .padding(.top, -5) // <<bring up button
//                   }
//
//               }
//
//            }
//               Spacer()
//
//            }
//        }
//        .onAppear(){
//            fetchFollowingList()
//        }
//    }
//}
//
//struct ShowFollowingView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowingUsersView()
//    }
//}
