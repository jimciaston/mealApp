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
    @ObservedObject var signUpController: SignUpController
    
    @State private var action: Int? = 0
    @State private var userSigningOut = false
    @State private var showMenu = false
    @State private var presentSettingsPage = false
    
    var body: some View {
        NavigationView{
            VStack{
                //Following and Follower button
                NavigationLink(destination: FollowingListView(), tag: 1, selection: $action) {
                                    EmptyView()
                                }
                
                NavigationLink(destination: MacroView(), tag: 2, selection: $action) {
                                    EmptyView()
                                }
                
                //profile picture
                ProfilePicture()
                
                HStack{
                    Text(vm.userModel?.name ?? "Billy" )
                }
               
                    .padding()
                HStack{
                    HStack{
                        Text("20").bold()
                        Text("Following").foregroundColor(.gray)
                    }
                    .onTapGesture {
                        //perform some tasks if needed before opening Destination view
                        self.action = 1
                        }
                    
                    HStack{
                        Text("73").bold()
                        Text("Followers").foregroundColor(.gray)
                    }
                    .onTapGesture {
                        //perform some tasks if needed before opening Destination view
                        self.action = 2
                    }
                }
                .padding(.top, -5)
        
                RecipeListView()
            }
            
            .toolbar{
                ToolbarItem (placement: .navigationBarTrailing){
                    Menu {
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
                        title: { Text("User Settings") },
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
    
            .fullScreenCover(isPresented: $userSigningOut){
                userLogin(signUpController: signUpController)
            }
        
        
            
        }
    }
    

struct UserDashController_Previews: PreviewProvider {
    static var previews: some View {
        UserDashController(signUpController: SignUpController())
    }
}

