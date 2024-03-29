//
//  FollowingListRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/6/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FollowingListRow: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // ipad sizing
    @Environment (\.colorScheme) var colorScheme
    @State var userUID: String
    @State var userName: String
    @State var userBio: String
    @State var userProfileImage: String
    @State var userExercisePreferences: [String]
    @State var userSocialLink: String
    @State var fcmToken: String
    @StateObject var jm = JournalDashLogicNonUser()
    @StateObject var rm = RecipeLogicNonUser()
    var body: some View {
        
        /*
         Note the two navigation Links. NOt sure what is happening, but If I remove the NavLink from the Image, the first element in the list does not click. Will figure out in next update..possibly..
         */
        
        NavigationLink(destination: UserProfileView(userUID: userUID, name: userName, userBio: userBio, userProfilePicture: userProfileImage, journalCount: jm.userJournalCountNonUser, rm: rm, jm: jm, userSocialLink: userSocialLink, exercisePreferences: userExercisePreferences, fcmToken: fcmToken).padding(.top, -65)
           
            .onAppear{
              
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
                                    .scaledToFit()
                                    .frame(width:35, height: 35)
                                    .clipShape(Circle())
                                    .padding(.leading, 20)
                                    .padding(.trailing, 25)
                            
                             
                            VStack{
                                HStack{
                                    Text(userName)
                                        .font(.title3)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    Spacer()
                                }
                              
                                
                                HStack {
                                    HomePageExercisePreferencesView(exercisePreferences: userExercisePreferences)
                                      Spacer()
                                   
                                }
                              
                                .padding(.top, -5)
                                

                            }
                          
                        }
                        
                        .padding(.leading, -20)
                        .padding()
                        
                      
                        .frame(maxWidth: horizontalSizeClass == .regular ? 500 : 380)
                    }
                  
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorScheme == .dark ? Color.gray : Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                           
                    )

                }
                .padding(.bottom, 20)
            
          
        }
       
       
    }
    
}
struct FollowingListRow_Previews: PreviewProvider {
    static var previews: some View {
        FollowingListRow(userUID: "userID",
                         userName: "John Doe",
                         userBio: "Lorem ipsum dolor sit amet",
                         userProfileImage: "profileImageURL",
                         userExercisePreferences: ["bodybuilding", "bodyweight", "Boxing"],
                         userSocialLink: "https://example.com",
                         fcmToken: "fcmToken",
                         jm: JournalDashLogicNonUser(),
                         rm: RecipeLogicNonUser())
    }
}
