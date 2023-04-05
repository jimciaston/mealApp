//
//  ProfileCardNonUserDisplay.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/17/23.
//

import SwiftUI
  
struct ProfileCardsNonUserDisplay: View {
    @ObservedObject var rm: RecipeLogicNonUser
    @ObservedObject var jm: JournalDashLogicNonUser
    var userUID: String
    var userName: String
    var journalCount: Int
    @State var showAllRecipes = false
    @State var showAllJournals = false
    let transition: AnyTransition = .asymmetric(insertion: .move(edge:.trailing), removal: .move(edge: .leading))
   
    var journalCountText:  some View {
        if jm.userJournalCountNonUser == 1 {
           return  Text("Journal Found")
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        else{
            return Text("Journals Found")
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
    
    var recipeCountText: some View {
        Group {
            Text(String(rm.recipesNonUser.count))
                .bold()
                .font(.title2)
                .padding(.top, 20)
                .padding(.bottom,2)
            
            Text(rm.recipesNonUser.count == 1 ? "Recipe Found" : "Recipes Found")
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
    
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
                
                    recipeCountText
                    }
                }
          
                .frame(width: 150, height: 180)
                .background(Color("UserProfileCard2"))
                .cornerRadius(25)
                .padding(.trailing, 6)
                .padding(.bottom, 15)
                .shadow(color: Color("LighterGray"), radius: 5, x: 0, y: 8)
                .onTapGesture{
                    showAllRecipes = true
                 
                }
                .sheet(isPresented: $showAllRecipes){
                    RecipeFullListView_nonUser(recipes: rm.recipesNonUser, showAddButton: true, notCurrentUserProfile: .constant(true), userUID: userUID, userName: userName)
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
                
 
                    
                Text(String(journalCount))
                    .bold()
                    .font(.title2)
                    .padding(.top, 20)
                    .padding(.bottom,2)
                
                journalCountText // << text count view
                        
            }
            .sheet(isPresented: $showAllJournals){
                SavedJournalsListNonUser(savedJournalIDs: jm.userJournalIDsNonUser, savedJournals: jm.userJournalsHalfNonUser, userUID: userUID)
                    .transition(transition)
                   
                    
            }
            .animation(Animation.easeInOut(duration: 0.30), value: showAllRecipes)
            
        }
        .frame(width: 150, height: 180)
        .background(Color("UserProfileCard1"))
        .cornerRadius(25)
        .padding(.leading, 6)
        .padding(.bottom, 15)
        .shadow(color: Color("LighterGray"), radius: 5, x: 0, y: 8)
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
