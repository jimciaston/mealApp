//
//  FollowingListRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/6/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FollowingListRow: View {
    @State var userUID: String
    @State var userName: String
    @State var userProfileImage: String
    @State var userRecipes: [String: String]
    
    var body: some View {
        
        /*
         Note the two navigation Links. NOt sure what is happening, but If I remove the NavLink from the Image, the first element in the list does not click. Will figure out in next update..possibly..
         */
        
        
        HStack{
            NavigationLink(destination: UserProfileView(userUID: userUID, name: userName, userProfilePicture: userProfileImage, userRecipes: userRecipes)){
                WebImage(url: URL(string: userProfileImage))
                    .placeholder(Image("profileDefaultPicture"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 45)
                    
            }
          
             
            VStack{
                Text(userName)
                    .font(.title)
                
                NavigationLink(destination: UserProfileView(userUID: userUID, name: userName, userProfilePicture: userProfileImage, userRecipes: userRecipes)){
                    Text("View Profile")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(3) //general padding
                    .padding([.leading, .trailing], 15) // << side padding
                    .border(.black)
                    .padding(.top, -5) // <<bring up button
                }

            }
            
        }
        .padding()
    }
}

//struct FollowingListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowingListRow(userName: "John Doe", userProfileImage: "", userRecipes: ["fjdsa": "fjkd;sa"])
//    }
//}
