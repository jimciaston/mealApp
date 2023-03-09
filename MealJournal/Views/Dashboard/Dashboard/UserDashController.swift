//
//  Toolbar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/14/22.
//

import SwiftUI
import Firebase
import SwiftUIX

struct UserDashController: View {
    @ObservedObject var vm: DashboardLogic
    @ObservedObject var rm = RecipeLogic()
    @ObservedObject var signUpController: LandingPageViewModel
    @AppStorage("followingCount") var followingCount = 0
    @AppStorage("followersCount") var followersCount = 0
    @State private var action: Int? = 0
    @State private var userSigningOut = false
    @State private var showMenu = false
    @State private var presentSettingsPage = false
    @State private var presentAddRecipePage = false
   // @State var followingCount = 0
    @State var deleteAccountSheet = false
   
    @ObservedObject var rm_nonUser = RecipeLogicNonUser()
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
                ZStack{
                    GeometryReader { Geo in
                        VStack{
                            VStack{
                        
                            
                            //profile picture
                            ProfilePicture()
                                    .padding(.top, 50) // << bring down profile picture on view
                            HStack{
                                Text(vm.userModel?.name ?? "Name unavailable" )
                                    .font(.custom("OpenSans-Regular", size: 24))
                            }
                            HStack{
                                HStack{
                                    VStack{
                                        NavigationLink(destination: FollowingUsersView(), tag: 1, selection: $action) {
                                                                           EmptyView()
                                                                       }
                                        Text(String(followingCount))
                                        Text("Following").foregroundColor(.gray)
                                    }
                                    .padding(.trailing, 15)
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
                                        Text(String(followersCount))
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
                        }
                             // .background(Color("LighterGray"))
                            
                            Text("About Me")
                                .font(.title3)
                                .padding(.bottom, -10)
                            
                            //User Bio
                            ProfileBio(userBio: .constant(vm.userModel?.userBio ?? "Bio unavailable"))
                                .padding(.top, -5)
                                .minimumScaleFactor(0.5)
                                .padding(.bottom, 10)
                         
                            .padding(.top, -15)// << bring follow/followers up
                            
                            //Display recipes
                            ProfileCardsMainDisplay()
                                .padding(.top, -10)
                            Spacer()
                        }
                        
                        .frame(width: Geo.size.width, height: Geo.size.height)
                        .onAppear{
                            fetchFollowingCount()
                            vm.fetchCurrentUser() //view refreshes if new data entered
                         
                        }
                    }
                    
                    .toolbar{
                        ToolbarItem (placement: .navigationBarTrailing){
                            Menu {
                                Button(action: {
                                    presentSettingsPage = true
                                }){
                                    Text("Settings")
                                }
                                Button(action: {
                                    //logs out user
                                    userSigningOut = true
                                    signUpController.logOutUser()
                                }){
                                    Text("Sign Out")
                                }
                                Button(role: .destructive, action: {
                                    //Delete Account
                                    //variable to show Bottom Sheet
                                    deleteAccountSheet = true
                                    
                                }){
                                   Text("Delete Account")
                                }
                            
                                .padding(.top, 25)
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
                    PersonalSettingsView(vm: vm)
                }
                
                .fullScreenCover(isPresented: $presentAddRecipePage){
                    RecipeEditor()
                }
            
                .fullScreenCover(isPresented: $userSigningOut){
                    LandingPage()
                }
                .blur(radius: deleteAccountSheet ? 2 : 0) // blur when bottomsheet open
               
                .windowOverlay(isKeyAndVisible: self.$deleteAccountSheet, {
                    GeometryReader { geometry in {
                        BottomSheetView(
                            isOpen: self.$deleteAccountSheet,
                            maxHeight: geometry.size.height * 0.5 * 0.7, minHeight: geometry.size.height * 0.5 * 0.7
                        ) {
                            DeleteProfileView(deleteSuccess: $deleteAccountSheet)
                                .onTapGesture{
                                    self.deleteAccountSheet = false
                                }
                        }

                    }()
                            .edgesIgnoringSafeArea(.all)

                    }

                })
            }
           
           
        }

        else{
            ActivityIndicator()
            //activity indicator had bug where it wouldn't leave after initial setup
                .onAppear{
                    vm.fetchCurrentUser()
                }

            // << showing loading spinner while loading
        }
        
    }
        
        
}
    

struct UserDashController_Previews: PreviewProvider {
    static var previews: some View {
        UserDashController(vm: DashboardLogic(), signUpController: LandingPageViewModel())
    }
}

