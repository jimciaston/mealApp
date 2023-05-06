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
    @State private var filteredUsers: [UserModel] = [] // store filtered users to keep track to prevent view from refreshing

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack{
                //DISPLAY USERS
                LazyVStack{
                    ForEach(filteredUsers, id:\.id ) { user in
                        FollowingListRow(userUID: user.uid ,userName: user.name,userBio: user.userBio ,userProfileImage: user.profilePictureURL, userExercisePreferences: user.exercisePreferences, userSocialLink: user.userSocialLink).animation(nil)
                    }
                }
                Spacer()
                    .padding(.top, 25) // << add separation from list and search bar
                    .navigationBarTitle("Search")

                //SEARCH
                .searchable(text: $userSearch, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by gender, height or weight") // << always display search bar
                .disableAutocorrection(true) // << disable autocorrect

                // Update filteredUsers only when the search query changes and is not empty
                .onChange(of: userSearch) { query in
                    if !query.isEmpty {
                        filteredUsers = vm.allUsers.filter { user in
                            if user.healthSettingsPrivate == "No" || user.healthSettingsPrivate == nil{
                                return user.name.localizedCaseInsensitiveContains(query) || user.gender.contains(query) || user.weight.contains(query) || user.height.contains(query)
                            } else {
                                return false
                            }
                        }
                    } else {
                        filteredUsers = []
                    }
                }
            }
        }
    }
}

struct FollowingListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUsersFeature()
    }
}
