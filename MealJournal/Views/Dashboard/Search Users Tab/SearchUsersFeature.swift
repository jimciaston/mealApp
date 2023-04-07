//
//  FollowersList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/6/22.
//

import SwiftUI

struct SearchUsersFeature: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var vm = DashboardLogic()
    
    @State private var userSearch = ""
    
    var body: some View {
        
        if #available(iOS 16.0, *) {
            NavigationStack{
                //DISPLAY USERS
                ScrollView{
                    ForEach ((vm.allUsers), id:\.id ) { user in
                        // localizedCaseInsensitiveContains(searchText)
                        if user.name.localizedCaseInsensitiveContains(userSearch) || user.gender.contains(userSearch) || user.weight.contains(userSearch) || user.height.contains(userSearch) {
                            FollowingListRow(userUID: user.uid ,userName: user.name,userBio: user.userBio ,userProfileImage: user.profilePictureURL, userExercisePreferences: user.exercisePreferences, userSocialLink: user.userSocialLink)
                            
                        }
                    }
                }
                
                .padding(.top, 15) // << add separation from list and search bar
                .navigationBarTitle("Search")
                
                //SEARCH
                .searchable(text: $userSearch ,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by gender, height or weight") // << always display search bar
                .disableAutocorrection(true) // << disable autocorrect
            }
        } 
    }
        
}
struct FollowingListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUsersFeature()
    }
}
