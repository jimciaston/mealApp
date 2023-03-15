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
    @State var userBio: String
    @State var userProfileImage: String
    @StateObject var jm = JournalDashLogicNonUser()
    @StateObject var rm = RecipeLogicNonUser()
    var body: some View {
        
        /*
         Note the two navigation Links. NOt sure what is happening, but If I remove the NavLink from the Image, the first element in the list does not click. Will figure out in next update..possibly..
         */
        NavigationLink(destination: UserProfileView(userUID: userUID, name: userName, userBio: userBio, userProfilePicture: userProfileImage, journalCount: jm.userJournalCountNonUser, rm: rm, jm: jm).onAppear{
            jm.grabUserJournalCount(userID: userUID)
            rm.grabRecipes(userUID: userUID)
        }){
            VStack{
                VStack{
                    HStack{
                        
                            WebImage(url: URL(string: userProfileImage))
                                .placeholder(Image("profileDefaultPicture"))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:60, height: 60)
                                .clipShape(Circle())
                                .padding(.leading, 20)
                                .padding(.trailing, 25)
                        
                         
                        VStack{
                            HStack{
                                Text(userName)
                                    .font(.title)
                                    
                                Spacer()
                            }
                          
                            
                            HStack {
                                ZStack {
                                    Text("Dancing")
                                        .padding([.leading, .trailing], 10)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .background(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .foregroundColor(Color("PieChart1"))
                                           )
                                        }
                                ZStack {
                                    Text("PowerLifting")
                                        .padding([.leading, .trailing], 10)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .background(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .foregroundColor(Color("PieChart2"))
                                           )
                                        }
                                ZStack {
                                    Text("Cardio")
                                        .padding([.leading, .trailing], 10)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .background(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .foregroundColor(Color("PieChart3"))
                                           )
                                        }
                              
                            }
                            .padding(.top, -5)
                          

                        }
                      
                    }
                    
                    .padding(.leading, -20)
                    .padding()
                    
                  
                    .frame(maxWidth: 360)
                }
              
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                       
                )

            }
            .padding(.bottom, 20)
        }
        
       
    }
    
}

struct FollowingListRow_Previews: PreviewProvider {
    static var previews: some View {
        FollowingListRow(userUID: "", userName: "John Doe", userBio: "", userProfileImage: "")
    }
}
