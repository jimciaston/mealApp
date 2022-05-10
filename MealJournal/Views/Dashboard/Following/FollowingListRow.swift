//
//  FollowingListRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/6/22.
//

import SwiftUI

struct FollowingListRow: View {
    var body: some View {
        HStack{
            Image("bodybuilding-2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:70, height: 70)
                .clipShape(Circle())
                .overlay(
                            Circle()
                                .stroke(Color("LightWhite"), lineWidth: 4)
                        )
            Text("Syndey Dermott")
                .font(.title2)
        }
    }
}

struct FollowingListRow_Previews: PreviewProvider {
    static var previews: some View {
        FollowingListRow()
    }
}
