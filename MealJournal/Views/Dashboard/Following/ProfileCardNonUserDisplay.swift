//
//  ProfileCardNonUserDisplay.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/17/23.
//

import SwiftUI
  
struct ProfileCardsNonUserDisplay: View {
    @ObservedObject var rm = RecipeLogicNonUser()
    @ObservedObject var jm = JournalDashLogicNonUser()
    var userUID: String
    @State var showAllRecipes = false
    @State var showAllJournals = false
    let transition: AnyTransition = .asymmetric(insertion: .move(edge:.trailing), removal: .move(edge: .leading))
   
    var body: some View {
        HStack{
            ZStack{
                VStack(alignment: .center){
                    Image("recipeCard")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(.systemPink))
                        .padding(.top, 15)
                    
                    Text(String(rm.recipesNonUser.count)).bold()
                        .font(.title2)
                        .padding(.top, 20)
                        .padding(.bottom,2)
                    if (rm.recipesNonUser.count == 1){
                        Text("Recipe Found")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                    else{
                        Text("Recipes Found")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        }
                    }
                }
          
                .frame(width: 150, height: 180)
                .background(Color("UserProfileCard2"))
                .cornerRadius(25)
                .padding(12)
                .shadow(color: Color("LighterGray"), radius: 5, x: 0, y: 8)
                .onTapGesture{
                    showAllRecipes = true
                }
                .sheet(isPresented: $showAllRecipes){
                    RecipeFullListView(recipes: rm.recipesNonUser, showAddButton: true, notCurrentUserProfile: .constant(true))
                        .transition(transition)
                        
                }
        ZStack{ 
            VStack(alignment: .center){
                Image("837043")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 60, height: 50)
                    .foregroundColor(Color(.systemPink))
                    .padding(.top, 15)
                
                Text(String(jm.userJournalCountNonUser)).bold()
                    .font(.title2)
                    .padding(.top, 20)
                    .padding(.bottom,2)
                if jm.userJournalCountNonUser == 1 {
                    Text("Journal Found")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                else{
                    Text("Journals Found")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                        
            }
            .sheet(isPresented: $showAllJournals){
                SavedJournalsListNonUser(savedJournalIDs: jm.userJournalIDsNonUser, savedJournals: jm.userJournalsNonUser)
                    .transition(transition)
                   
                    
            }
            .animation(Animation.easeInOut(duration: 0.30), value: showAllRecipes)
            
        }
        .frame(width: 150, height: 180)
        .background(Color("UserProfileCard1"))
        .cornerRadius(25)
        .shadow(color: Color("LighterGray"), radius: 5, x: 0, y: 8)
        }
        .onAppear {
            rm.grabRecipes(userUID: userUID)
            jm.grabUserJournalCount(userID: userUID)
        }
        .onTapGesture {
            showAllJournals = true
          
        }
    }
}
//
//struct ProfileCardNonUserDisplay_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCardsNonUserDisplay()
//    }
//}
