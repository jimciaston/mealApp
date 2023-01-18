//
//  ProfileCardNonUserDisplay.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/17/23.
//

import SwiftUI

func fetchNonUserSavedJournals(){
   
     guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
     
     FirebaseManager.shared.firestore.collection("users").document(uid)
        .collection("userJournalEntrys")
         .getDocuments{ (querySnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
             } else {
                 for document in querySnapshot!.documents {
                     print("\(document.documentID)") // Get documentID
                     // Get specific data & type cast it.
                 }
             }
         }
     }
         
     
struct ProfileCardsNonUserDisplay: View {
    @ObservedObject var rm = RecipeLogicNonUser()
    @ObservedObject var jm = JournalDashLogic()
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
                    RecipeFullListView(recipes: rm.recipesNonUser, showAddButton: true)
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
                
                Text(String(jm.userJournalCount)).bold()
                    .font(.title2)
                    .padding(.top, 20)
                    .padding(.bottom,2)
                if jm.userJournalCount == 1 {
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
                SavedJournalsList(savedJournalIDs: jm.userJournalIDs, savedJournals: jm.userJournals)
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
