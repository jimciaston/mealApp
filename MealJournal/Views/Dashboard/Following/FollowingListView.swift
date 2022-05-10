//
//  FollowersList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/6/22.
//

import SwiftUI

struct FollowingListView: View {
    var body: some View {
        VStack{
            FollowingListRow()
            FollowingListRow()
            FollowingListRow()
        }
        
    }
}

struct FollowingListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingListView()
    }
}
