//
//  FollowersList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/6/22.
//

import SwiftUI

struct FollowingListView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var vm = DashboardLogic()
    
    @State private var userSearch = ""
    
    var body: some View {
        NavigationView{
                VStack{
                    //DISPLAY USERS
                    ScrollView{
                        ForEach ((vm.allUsers), id:\.id ) { user in
                            if user.name.contains(userSearch){
                                FollowingListRow(userUID: user.uid ,userName: user.name, userProfileImage: user.profilePictureURL, userRecipes: ["fjkd;": "FJ"])
                                   
                            }
                        }
                    }
                }
                .padding(.top, 15) // << add separation from list and search bar
                .navigationBarTitle("")
            //SEARCH
                .searchable(text: $userSearch,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for Users") // << always display search bar
        }

        
    }
}
struct FollowingListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingListView()
    }
}
