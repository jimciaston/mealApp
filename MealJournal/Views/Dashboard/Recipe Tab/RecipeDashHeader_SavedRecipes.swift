//
//  RecipeDashHeader_savedRecipes.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/15/23.
//

import SwiftUI

struct RecipeDashHeader_SavedRecipes: View {
    @State var recipeName = ""
    @State var recipePrepTime = ""
    @Environment(\.colorScheme) var colorScheme
    //calls macro pickers
    @State var caloriesPicker:Int =     0
    @State var fatPicker:Int =     0
    @State var carbPicker:Int =     0
    @State var proteinPicker:Int =     0
    @State var userName: String
    @ObservedObject var ema: EditModeActive
    @State var userUID: String
    @State var notCurrentUserProfile: Bool
    //Recipe Logic for user
    @State var userRecipeName = ""
    @State var userBio = ""
    @State var userProfileImage = ""
    @State var testSubject = ""
    @StateObject var rm = RecipeLogicNonUser()
    @StateObject var jm = JournalDashLogicNonUser()
   @State var uid = ""
    @Binding var exercisePreferences: [String]
    @Binding var userSocialLink: String
    @Binding var fcmToken: String
    var userModel: UserModel
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
   // @State var cookingTimesInMinutes = [5, 10, 15, 20, 25, 30, 45, 60, 120, 240, 480]
    @State private var pickerTime: String = ""
    //@State private var selectedCookingTime = 0
    
  
    
    @ViewBuilder
    var body: some View {
      
            VStack{
                VStack{
                    Text(recipeName.capitalized)
                        .font(.title2)
                        .padding()
                       .multilineTextAlignment(.center)
                       .frame(width: 400)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    if !notCurrentUserProfile { // << if navigating on own user page, don't show
                        HStack{
                            Text("Created by: ")
                                .italic()
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                    NavigationLink(
                                        destination: UserProfileView(userUID: userUID, name: userModel.name, userBio: userModel.userBio, userProfilePicture: userModel.profilePictureURL, journalCount: jm.userJournalCountNonUser, rm: rm, jm: jm, userSocialLink: userSocialLink, exercisePreferences: exercisePreferences, fcmToken: fcmToken).onAppear{
                                          
                                            jm.grabUserJournalCount(userID: userUID)
                                            rm.grabRecipes(userUID: userUID)
                                        },
                                        label: {
                                            Text(userName)
                                                .italic()
                                                .foregroundColor(Color("defaultColorForExercise"))
                                                .underline() // or Text("localized string key")
                                        }
                                    )
                                
                        }
                        .padding(.top, -15)
                        .padding(.bottom, 15)
                    }
                   
                }
                
                HStack{
                    Image(systemName: "clock")
                        .foregroundColor(Color("defaultColorForExercise"))
                    Text(recipePrepTime)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .padding(.top, -10)
                
                Text(String(caloriesPicker) + " calories")
                    .font(.body)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.top, 5)
             
                HStack{
                    Text(String(fatPicker) + "g fat")
                        .font(.body)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                    //carb
                    Text(String(carbPicker) + "g carbs")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.body)
                    //protein
                    Text(String(proteinPicker) + "g protein")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .padding(.top, 5)
               
              
            }
            .frame(width:400, height:notCurrentUserProfile ? 180 : 200)
            .background(colorScheme == .dark ? Color("recipeDashHeader") : .white)
            .cornerRadius(15)
          
    }
    
}

struct RecipeDashHeader_SavedRecipes_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDashHeader_SavedRecipes(recipeName: "Mango Coolada in PineApple in mango sauceee",
                                      recipePrepTime: "30 Mins",
                                      userName: "John Doe",
                                      ema: EditModeActive(),
                                      userUID: "123456",
                                      notCurrentUserProfile: true,
                                      userRecipeName: "Sample Recipe",
                                      userBio: "Lorem ipsum dolor sit amet",
                                      userProfileImage: "profile-image",
                                      testSubject: "Sample Subject",
                                      rm: RecipeLogicNonUser(),
                                      jm: JournalDashLogicNonUser(),
                                      uid: "654321",
                                      exercisePreferences: .constant(["Running", "Yoga"]),
                                      userSocialLink: .constant("https://example.com"),
                                      fcmToken: .constant("FCM_TOKEN"),
                                      userModel: UserModel(data: ["d": "Jk"]))
      
    }
}
