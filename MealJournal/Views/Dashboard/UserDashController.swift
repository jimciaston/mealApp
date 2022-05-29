//
//  Toolbar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/14/22.
//

import SwiftUI

struct UserDashController: View {
  
    @State private var action: Int? = 0
   @State private var showMenu = false
    var body: some View {
        NavigationView{
            VStack{
//                 .navigationBarTitle("")
//                .navigationBarHidden(true)
//                    Button(action: {
//                       //display menu
//                        showMenu.toggle()
//                    }, label: {
//                            Image(systemName: "line.3.horizontal")
//                                .resizable().aspectRatio(contentMode: .fit)
//                                .frame(width: 30, height: 40)
//                                .foregroundColor(.black)
//                    })
//                        .padding(.trailing, 25)
//
//                }
//                .padding(.bottom, -25)
//
                    
                  
                    
                
                //Following and Follower button
                NavigationLink(destination: FollowingListView(), tag: 1, selection: $action) {
                                    EmptyView()
                                }
                
                NavigationLink(destination: MacroView(), tag: 2, selection: $action) {
                                    EmptyView()
                                }
                
                //profile picture
                ProfilePicture()
                
                
                Text("Bradley Martin")
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
                            
                        }){
                            Text("Sign Out")
                               
                        }
                    }
                label: {
                    Label(
                        title: { Text("fjkd;a") },
                        icon: {
                            Image(systemName: "plus")
                                
                        })
                    }
                }
            }
            .padding(.top, -70)
        
        }
        
            
        }
    }
    

struct UserDashController_Previews: PreviewProvider {
    static var previews: some View {
        UserDashController()
    }
}

