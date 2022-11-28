//
//  ProfileCardsMainDisplay.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/21/22.
//

import SwiftUI

struct ProfileCardsMainDisplay: View {
    @ObservedObject var rm = RecipeLogic()
    @State var showAllRecipes = false
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
                    if (rm.recipes.count < 2){
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
        ZStack{
            VStack(alignment: .center){
                Image("recipeCard")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(.systemPink))
                    .padding(.top, 15)
                
                Text("2").bold()
                    .font(.title2)
                    .padding(.top, 20)
                    .padding(.bottom,2)
                        Text("Journals Found")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    
                   
            }
           
        }
        .frame(width: 150, height: 180)
        .background(Color("UserProfileCard1"))
        .cornerRadius(25)
        .shadow(color: Color("LighterGray"), radius: 5, x: 0, y: 8)
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
