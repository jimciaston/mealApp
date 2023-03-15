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
    var journalCount: Int
    @State var isUserFollowed = false
    @State var fetchedUserRecipes = [RecipeItem]()
    //get user recipes from database
    @ObservedObject var rm: RecipeLogicNonUser
    @ObservedObject var jm: JournalDashLogicNonUser
    @State private var action: Int? = 0
    @State private var nonUserFollowingCount: Int = 0
    @State private var nonUserFollowersCount: Int = 0
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
    func fetchFollowingCount_NonUser(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("no current User")
            return
        }
        
        FirebaseManager.shared.firestore.collection("users")
            .document(userUID)
            .getDocument { (snapshot, err) in
               guard let data = snapshot?.data()
                else{
                    print ("error grabbing users ")
                    return
                }
                nonUserFollowingCount = data ["followingCount"] as? Int ?? 0
                nonUserFollowersCount = data ["followers"] as? Int ?? 0
               
            }
        }
    var body: some View {
        GeometryReader { Geo in
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
               
                    .padding()
                
                VStack{
                    
                    HStack{
                        HStack{
                            VStack{
                                NavigationLink(destination: FollowingListView_NonUser(userUID: userUID), tag: 1, selection: $action) {
                                                                   EmptyView()
                                                               }
                                Text(String(nonUserFollowingCount))
                                Text("Following").foregroundColor(.gray)
                            }
                            //.padding(.trailing, 15)
                        }
                        
                        .onTapGesture {
                            //perform some tasks if needed before opening Destination view
                            self.action = 1
                            }
                        
                        HStack{
                            VStack{
                                NavigationLink(destination: FollowersUsersView(), tag: 2, selection: $action) {
                                       EmptyView()
                                   }
                                Text(String(nonUserFollowersCount))
                                Text("Followers").foregroundColor(.gray)
                            }
                            .padding(.leading, 15)
                        }
                      
                        
                        .onTapGesture {
                            //perform some tasks if needed before opening Destination view
                            self.action = 2
                        }
                    }
                    
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                        //custom divider
                    Rectangle()
                    .fill(Color("LighterGray"))
                    .frame(width: abs(Geo.size.width - 125))
                    .frame(height: 2)
                        //.edgesIgnoringSafeArea(.horizontal)
                        .padding(.bottom, 10)
                       
                    HStack{
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
                                    
                                     .foregroundColor(.white)
                                     .background(Color("FollowerButton"))
                                     .font(.body)
                                     .shadow(color: Color("FollowerButton"), radius: 2, y: 2)
                            }
                        Link (destination: URL(string: "https://www.instagram.com/carolinafearfest/")!){
                            Image("Instagram_Logo_1")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 50, height: 50)
                                .padding(.leading, -5) // << bring closer to follow button
                        }
                    }
                    //save following
                    .frame(width: Geo.size.width - 140)
                         
                }
                .onAppear{
                    fetchFollowingCount_NonUser() // << grab follow/follower totals from firestore
                }
                Spacer()
               //display user recipes
            
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
                ProfileCardsNonUserDisplay(rm: rm, jm: jm, userUID: userUID, userName: name, journalCount: journalCount)
                    .padding(.top, -10)
                   
             
                
            }
            .frame(maxWidth: Geo.size.width)
            .padding(.top, -65)
        }
                
    }
        
        
    
}
