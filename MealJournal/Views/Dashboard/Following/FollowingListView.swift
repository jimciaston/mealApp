//
//  FollowersList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/6/22.
//

import SwiftUI

struct FollowingListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var allUsers: FetchedResults <User>
    
    var body: some View {
        VStack{
            List {
                ForEach(allUsers) { user in
                    Text(user.firstName ?? "user unknown")
                }
            }
            Text("All Users : \(allUsers.count)")
        }
        
    }
}

struct FollowingListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingListView()
    }
}
