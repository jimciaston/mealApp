//
//  ProfilePicture.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/13/22.
//

import SwiftUI

struct ProfilePicture: View {
    var body: some View {
        VStack{
            Image("userProfile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:150, height: 150)
                .clipShape(Circle())
        }
    }
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicture()
    }
}
