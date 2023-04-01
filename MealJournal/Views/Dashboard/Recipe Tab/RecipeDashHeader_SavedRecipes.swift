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
    var userModel: UserModel
    var cookingTime = ["5 Mins", "10 Mins","15 Mins","20 Mins","25 Mins","30 Mins ","45 Mins ","1 Hour","2 Hours", "A Long Time", "A Very Long Time"]
   // @State var cookingTimesInMinutes = [5, 10, 15, 20, 25, 30, 45, 60, 120, 240, 480]
    @State private var pickerTime: String = ""
    //@State private var selectedCookingTime = 0
    
  
    
    @ViewBuilder
    var body: some View {
      
            VStack{
                HStack{
                    Text(recipeName.capitalized)
                        .font(.title2)
                        .padding()
                    
                    if !notCurrentUserProfile { // << if navigating on own user page, don't show
                        HStack{
                            Text("Created by: ")
                                .italic()
                           
                                    NavigationLink(
                                        destination: UserProfileView(userUID: userUID, name: userModel.name, userBio: userModel.userBio, userProfilePicture: userModel.profilePictureURL, journalCount: jm.userJournalCountNonUser, rm: rm, jm: jm, userSocialLink: userSocialLink, exercisePreferences: exercisePreferences).onAppear{
                                          
                                            jm.grabUserJournalCount(userID: userUID)
                                            rm.grabRecipes(userUID: userUID)
                                        },
                                        label: {
                                            Text(userName)
                                                .italic()
                                                .foregroundColor(.blue)
                                                .underline() // or Text("localized string key")
                                        }
                                    )
                                
                        }
                       
                    }
                   
                }
                
                HStack{
                    Image(systemName: "clock")
                        .foregroundColor(.green)
                    Text(recipePrepTime)
                }
                .padding(.top, -10)
                
                Text(String(caloriesPicker) + " calories").bold()
                    .font(.body)
                    .foregroundColor(.black)
                    .font(.body)
                    .padding(.top, 15)
             
                HStack{
                    Text(String(fatPicker) + "g fat")
                        .font(.body)
                        .foregroundColor(.black)
                        .font(.body)
                    //carb
                    Text(String(carbPicker) + "g carbs")
                        .foregroundColor(.black)
                        .font(.body)
                    //protein
                    Text(String(proteinPicker) + "g protein")
                        .foregroundColor(.black)
                }
                .padding(.top, 10)
               
              
            }
            .frame(width:280, height:200)
            .background(Color.white)
            .cornerRadius(15)
          
    }
    
}
//
//struct RecipeDashHeader_savedRecipes_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDashHeader_SavedRecipes(userName: "Timmy", ema: EditModeActive(), userUID: "33", userRecipesPage: true)
//    }
//}
