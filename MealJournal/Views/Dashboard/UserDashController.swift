//
//  Toolbar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/14/22.
//

import SwiftUI
import Firebase

struct UserDashController: View {
    @ObservedObject var vm = DashboardLogic()
    @ObservedObject var rm = RecipeLogic()
    @ObservedObject var signUpController: SignUpController
    
    @State private var action: Int? = 0
    @State private var userSigningOut = false
    @State private var showMenu = false
    @State private var presentSettingsPage = false
    @State private var presentAddRecipePage = false
    @State var followingCount = 0
    @State var followersCount = 0
    
    func fetchFollowingCount(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("no current User")
            return
        }
        FirebaseManager.shared.firestore.collection("users")
            .document(uid)
            .getDocument { (snapshot, err) in
               guard let data = snapshot?.data()
                else{
                    print ("error grabbing users ")
                    return
                }
                followingCount = data ["followingCount"] as? Int ?? 0
                followersCount = data ["followers"] as? Int ?? 0
               
            }
    }
    
    
    var body: some View {
        if !vm.isUserDataLoading { // << if user data loaded
            NavigationView{
                VStack{
                    //Following and Follower button
                    NavigationLink(destination: FollowingUsersView(), tag: 1, selection: $action) {
                            EmptyView()
                        }
                    
                    NavigationLink(destination: FollowersUsersView(), tag: 2, selection: $action) {
                        EmptyView()
                    }
                    
                    //profile picture
                    ProfilePicture()
                    
                    HStack{
                        Text(vm.userModel?.name ?? "" )
                    }
                        .padding()
                    
                    HStack{
                        HStack{
                            Text("Following").foregroundColor(.gray)
                            Text(String(followingCount)).bold()
                            
                        }
                        .onTapGesture {
                            //perform some tasks if needed before opening Destination view
                            self.action = 1
                            }
                        
                        HStack{
                           
                            Text("Followers").foregroundColor(.gray)
                            Text(String(followersCount)).bold()
                        }
                        .onTapGesture {
                            //perform some tasks if needed before opening Destination view
                            self.action = 2
                        }
                    }
                    .padding(.top, -5)
            
                    RecipeListView()
                }
                .onAppear{
                    fetchFollowingCount()
                }
                
                .toolbar{
                    ToolbarItem (placement: .navigationBarTrailing){
                        Menu {
                            Button(action: {
                                presentAddRecipePage = true
                            }){
                                Text("Add Recipe")
                            }
                            Button(action: {
                                presentSettingsPage = true
                            }){
                                Text("Settings")
                            }
                            Button(role: .destructive, action: {
                                //logs out user
                                userSigningOut = true
                                signUpController.logOutUser()
                            }){
                                Text("Sign Out")
                                   
                            }
                        }
                    label: {
                        Label(
                            title: { Text("") },
                            icon: {
                                Image(systemName: "plus")
                                    
                            })
                        }
                    }
                }
              
                .padding(.top, -70)
            
            }
            .fullScreenCover(isPresented: $presentSettingsPage){
                SettingsView()
            }
            
            .fullScreenCover(isPresented: $presentAddRecipePage){
                RecipeEditor()
            }
        
            .fullScreenCover(isPresented: $userSigningOut){
                userLogin(signUpController: signUpController)
            }
        }
        else{
            ActivityIndicator() // << showing loading spinner while loading
        }
    } 
}
    

struct UserDashController_Previews: PreviewProvider {
    static var previews: some View {
        UserDashController(signUpController: SignUpController())
    }
}

