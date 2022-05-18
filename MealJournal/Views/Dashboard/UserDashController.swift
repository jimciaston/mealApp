//
//  Toolbar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/14/22.
//

import SwiftUI

struct UserDashController: View {
  
    @State private var action: Int? = 0
   
    var body: some View {

            VStack{
                NavigationLink(destination: FollowingListView(), tag: 1, selection: $action) {
                                    EmptyView()
                                }
                
                NavigationLink(destination: MacroView(), tag: 2, selection: $action) {
                                    EmptyView()
                                }
                
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
               
//                FollowUserButton()
//                    .padding(.top, 10)
                
                RecipeListView()
            }    
        }
   

    }
    
        
    
//
//
struct UserDashController_Previews: PreviewProvider {
    static var previews: some View {
        UserDashController()
    }
}

