//
//  ProfileBio.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/7/22.
//

import SwiftUI

struct ProfileBio: View {
    @Binding var userBio: String
    var body: some View {
        Text(userBio == "" ? "User has not entered a Bio yet": userBio)
            .font(.custom("OpenSans-Regular", size: 18))
            .multilineTextAlignment(.center)
           // .frame(width: 250, height: 100)
      
    }
}
//
//struct ProfileBio_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileBio(userBio: "I am an avid bodybuilding champ")
//    }
//}
