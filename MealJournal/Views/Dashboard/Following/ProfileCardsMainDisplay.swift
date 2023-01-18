//
//  ProfileCardsMainDisplay.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/21/22.
//

import SwiftUI

public func fetchSavedJournals(){
   
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
//                    let recipeTitle = data ["recipeTitle"] as? String ?? ""
//
//                    let recipeProteinMacro = data ["recipeProteinMacro"] as? Int ?? 0
//                    let recipe = RecipeItem(id: recipeID, recipeTitle:recipeTitle , recipePrepTime: recipePrepTime, recipeImage: recipeImage, createdAt: createdAt, recipeCaloriesMacro: recipeCaloriesMacro, recipeFatMacro: recipeFatMacro, recipeCarbMacro:recipeCarbMacro, recipeProteinMacro: recipeProteinMacro, directions: directions, ingredientItem: ingredients)
                 
            //first check if recipe ID exists by filtering by the id
               //  let recipeExistence = fetchedUserRecipes.filter { $0.id == recipeID }
            //if it doens't exist, append recipe
//                    if recipeExistence.isEmpty == true {
//                        self.fetchedUserRecipes.append(recipe)
//                    }
             }
         
     
struct ProfileCardsMainDisplay: View {
    @ObservedObject var rm = RecipeLogic()
    @ObservedObject var jm = JournalDashLogic()
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
                    
                    Text(String(rm.recipes.count)).bold()
                        .font(.title2)
                        .padding(.top, 20)
                        .padding(.bottom,2)
                    if (rm.recipes.count == 1){
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
                    RecipeFullListView(recipes: rm.recipes, showAddButton: true)
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
        .onTapGesture {
            showAllJournals = true
          
        }
    }
}

//struct ProfileCardsMainDisplay_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCardsMainDisplay(recipes: [RecipeItem(id: "", recipeTitle: "", recipePrepTime: "", recipeImage: "", createdAt: "", recipeCaloriesMacro: 2, recipeFatMacro: 2, recipeCarbMacro: 2, recipeProteinMacro: 2, directions: [""], ingredientItem: ["": ""])])
//    }
//}

//struct ProfileCardsMainDisplay: View {
//    var body: some View {
//        VStack{
//            ZStack{
//                HStack{
//                    Image(systemName: "r.square.on.square")
//                        .resizable()
//                        .renderingMode(.original)
//                        .frame(width: 30, height: 30)
//                        .padding(.top, 25)
//                        .padding(.leading, 20)
//                        .foregroundColor(Color(.systemCyan))
//                    HStack{
//                        HStack{
//                            Text("7 Recipes Found")
//                                .padding(.top, 20)
//                                .padding(.leading, 20)
//                                .foregroundColor(.black)
//                                .font(.body)
//
//                        }
//                        Image(systemName: "arrow.right")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .foregroundColor(.black)
//                            .padding(.top, 5)
//                           .padding(.leading, 15)
//                             Spacer()
//
//                    }
//                }
//
//            }
//            .frame(width: 350, height: 70)
//            .background(Color("UserProfileCard2"))
//            .cornerRadius(25)
//            .padding(10)
//            ZStack{
//                HStack{
//                    Image(systemName: "r.square.on.square")
//                        .resizable()
//                        .renderingMode(.original)
//                        .frame(width: 30, height: 30)
//                        .padding(.top, 25)
//                        .padding(.leading, 20)
//                        .foregroundColor(Color(.systemCyan))
//                    HStack{
//                        HStack{
//                            Text("7 Recipes Found")
//                                .padding(.top, 20)
//                                .padding(.leading, 20)
//                                .foregroundColor(.black)
//                                .font(.body)
//
//                        }
//                        Image(systemName: "arrow.right")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .foregroundColor(.black)
//                            .padding(.top, 5)
//                           .padding(.leading, 15)
//                             Spacer()
//
//                    }
//                }
//
//            }
//        .frame(width: 350, height: 120)
//        .background(Color("UserProfileCard1"))
//        .cornerRadius(25)
//
//        }
//
//    }
//}
