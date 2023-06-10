//
//  Toolbar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/14/22.
//

import SwiftUI
import Firebase
import SwiftUIX
extension Color {
    static let systemBackground = Color("lightWhite")
}
struct UserDashController: View {
    @Environment(\.colorScheme) var colorScheme
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
    @State private var presentSupportPage = false
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
                followersCount = data ["followersCount"] as? Int ?? 0
               
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
                                ProfilePicture(profilePicURL: vm.userModel?.profilePictureURL ?? "unavailable")
                                    .padding(.top, 50) // << bring down profile picture on view
                            HStack{
                                Text(vm.userModel?.name ?? "Name unavailable" )
                                    .font(.custom("OpenSans-Regular", size: 24))
                                    .padding(.bottom, 2)
                            }
                
                                HomePageExercisePreferencesView(exercisePreferences: vm.userModel?.exercisePreferences ?? ["exercises unavailable"])
                                .padding(.bottom, 25)
                               
                                
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
                           .padding(.top, 15)
                            .padding(.bottom, 25)
                                //custom divider
                            Rectangle()
                            .fill(Color("LighterGray"))
                            .frame(width: abs(Geo.size.width - 125))
                            .frame(height: 2)
                                //.edgesIgnoringSafeArea(.horizontal)
                                .padding(.bottom, 10)
                        }
                             // .background(Color("LighterGray"))
                          
                            //User Bio
                            ProfileBio(userBio: .constant(vm.userModel?.userBio ?? "User has yet to enter bio"))
                                .padding(.top, 10)
                                .minimumScaleFactor(0.5)
                                .padding(.bottom, 50)
                                .frame(width: Geo.size.width / 1.25)
                         
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
                                    presentSupportPage = true
                                }){
                                    Text("Support")
                                }
                                Button(role: .destructive, action: {
                                    userSigningOut = true
                                    signUpController.logOutUser()
                                    
                                }){
                                   Text("Log Out")
                                }
                            
                                .padding(.top, 25)
                            }
                        label: {
                            Label(
                                title: { Text("") },
                                icon: {
                                    Image(systemName: "line.3.horizontal.decrease")
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color("ButtonTwo"))
                                        
                                })
                            }
                        }
                    }
                  
                       .padding(.top, -70)
                    
                    
                }
                .background(colorScheme == .dark  ? Color("darkModeBackground") : .white)
                .fullScreenCover(isPresented: $presentSettingsPage){
                    PersonalSettingsView(vm: vm, deleteAccountSheet: $deleteAccountSheet)
                }
                .fullScreenCover(isPresented: $presentSupportPage){
                    ContactUsView()
                }
                .fullScreenCover(isPresented: $presentAddRecipePage){
                    RecipeEditor()
                }
            
                .fullScreenCover(isPresented: $userSigningOut){
                    LandingPage()
                }
               
               
               
            }
          
            .navigationViewStyle(StackNavigationViewStyle())
           
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

