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
    
    @State var userUID: String
    @State var userName: String
    @State var userBio: String
    @State var userProfileImage: String
    @State var userExercisePreferences: [String]
    @State var userSocialLink: String
    @StateObject var jm = JournalDashLogicNonUser()
    @StateObject var rm = RecipeLogicNonUser()
    var body: some View {
        
        /*
         Note the two navigation Links. NOt sure what is happening, but If I remove the NavLink from the Image, the first element in the list does not click. Will figure out in next update..possibly..
         */
        
        NavigationLink(destination: UserProfileView(userUID: userUID, name: userName, userBio: userBio, userProfilePicture: userProfileImage, journalCount: jm.userJournalCountNonUser, rm: rm, jm: jm, userSocialLink: userSocialLink, exercisePreferences: userExercisePreferences).padding(.top, -65)
           
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
                                    HomePageExercisePreferencesView(exercisePreferences: userExercisePreferences)
                                    Spacer()
                                }
                                
                                .padding(.top, -5)
                              

                            }
                          
                        }
                        
                        .padding(.leading, -20)
                        .padding()
                        
                      
                        .frame(maxWidth: horizontalSizeClass == .regular ? 500 : 340)
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
        FollowingListRow(userUID: "", userName: "John Doe", userBio: "", userProfileImage: "", userExercisePreferences: ["Bodybuilding"], userSocialLink: "www.google.com")
    }
}
