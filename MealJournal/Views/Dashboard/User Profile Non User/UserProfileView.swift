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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // ipad sizing
    
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
    @State var userSocialLink: String
    @State var exercisePreferences: [String]
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
                    DispatchQueue.main.async {
                        isUserFollowed = true
                    }
                }
                else {
                    DispatchQueue.main.async {
                        isUserFollowed = false
                    }
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
                nonUserFollowersCount = data ["followersCount"] as? Int ?? 0
               
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
                        .padding(.bottom, 2)
                }
                    .padding()
                
                
                HomePageExercisePreferencesView(exercisePreferences: exercisePreferences ?? ["exercises unavailable"])
                .padding(.bottom, 25)
                
                VStack{
                    HStack{
                        HStack{
                            VStack{
                                NavigationLink(destination: FollowingListView_NonUser(userUID: userUID, listIsEmptyMessage: "User is not following any users"), tag: 1, selection: $action) {
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
                                NavigationLink(destination: FollowersListView_NonUser(userUID: userUID, listIsEmptyMessage: "User does not have any followers yet"), tag: 2, selection: $action) {
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
                            print(followingUserUID)
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
                                        fetchFollowingCount_NonUser()
                                        //Update user who is being followed
                                        FirebaseManager.shared.firestore.collection("users")
                                            .document(followingUserUID)
                                            .updateData([
                                                "followers": FieldValue.arrayRemove([uid]),
                                                "followersCount": FieldValue.increment(Int64(-1))
                                            ])
                                        fetchFollowingCount_NonUser()
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
                                        fetchFollowingCount_NonUser()
                                        //Updates user being followed
                                        FirebaseManager.shared.firestore.collection("users")
                                            .document(followingUserUID)
                                            .updateData([
                                                "followers": FieldValue.arrayUnion([uid]),
                                                "followersCount": FieldValue.increment(Int64(1))
                                            ])
                                        fetchFollowingCount_NonUser()
                                    }
                                }
                            }){
                                //FOLLOW BUTTON ICON
                                Text(isCurrentUserfollowingUser() ? "Following" : "Follow") // << user followed yay or nay
                                     .frame(width: 85, height: 40)
                                     .foregroundColor(.white)
                                     .background(Color("UserProfileCard2"))
                                     .font(.body)
                                    // .shadow(color: Color("UserProfileCard2"), radius: 2, y: 2)
                                   
                            }
                        
                        if let socialLink = userSocialLink, let url = URL(string: socialLink) {
                            Link(destination: url) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color("GetStartedPopUpBackground"), lineWidth: 2)
                                        )
                                    Image(systemName: "camera")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.black)
                                        .frame(width: 15, height: 15)
                                    
                                }
                                .frame(width:40, height: 40)
                                .padding(.leading, 5)
                            }
                            
                        }
                        else{
                            Link(destination: (URL(string: "https://www.instagram.com") ?? URL(string: "https://www.instagram.com"))!){
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color("GetStartedPopUpBackground"), lineWidth: 2)
                                        )
                                    Image(systemName: "camera")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.black)
                                        .frame(width: 15, height: 15)
                                    
                                }
                                .frame(width:40, height: 40)
                                .padding(.leading, 5)
                            }
                        }
                                      
                    }
                    .frame(width: Geo.size.width)
                    .padding(.top, -5)
                         
                }
                .onAppear{
                    print(userUID)
                    fetchFollowingCount_NonUser() // << grab follow/follower totals from firestore
                }
              
                ProfileBio(userBio: $userBio)
                    .minimumScaleFactor(0.5)
                    .padding(.top, 15)
                    .padding(.bottom, 25)
                    .frame(width: Geo.size.width / 1.25)
                
                //Display recipes
                ProfileCardsNonUserDisplay(rm: rm, jm: jm, userUID: userUID, userName: name, journalCount: journalCount)
                    .padding(.top, -10)
                   
             
                
            }
            .frame(maxWidth: Geo.size.width)
            
        }
                
    }
        
        
    
}
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let rm = RecipeLogicNonUser()
        let jm = JournalDashLogicNonUser()
        UserProfileView(userUID: "exampleUID",
                         name: "John Doe",
                         userBio: "Hi there!",
                         userProfilePicture: "examplePictureURL",
                         journalCount: 10,
                        isUserFollowed: false, fetchedUserRecipes: [RecipeItem](),
                        rm: rm,
                        jm: jm, userSocialLink: "www.google.com",
                        exercisePreferences: ["Running"]
                       )
    }
}
