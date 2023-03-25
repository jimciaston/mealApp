//
//  PlusTabPopMenu.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/16/22.
//

import SwiftUI

struct PlusTabPopMenu: View {
    let widthAndHeight: CGFloat
    @ObservedObject var dashboardRouter: DashboardRouter
    @Binding var closePlusIconPopUpMenu: Bool
    var body: some View {
        HStack(spacing: 45) {
              ZStack {
//                Circle()
//                  .foregroundColor(Color("UserProfileCard1"))
//                  .frame(width: widthAndHeight - 25, height: widthAndHeight - 25)
                Image("recipeProfileCardIcon")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .padding(15)
                  .frame(width: widthAndHeight, height: widthAndHeight)
                  .foregroundColor(Color("UserProfileCard2"))
                  .onTapGesture{
                      dashboardRouter.isPlusMenuOpen = false
                      dashboardRouter.currentTab = .addMeal
                  }
                  Text("Add Meal")
                .padding(.top, 75)
                .font(.caption2)
                .foregroundColor(Color("UserProfileCard2"))
                  .onTapGesture{
                      dashboardRouter.isPlusMenuOpen = false
                      dashboardRouter.currentTab = .addMeal
                  }
              }
              ZStack {
//                  Circle()
//                  .foregroundColor(Color("UserProfileCard1"))
//                  .frame(width: widthAndHeight - 25, height: widthAndHeight - 25)
                  //add recipe tab
                  
                      Image("recipeTabIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(15)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .foregroundColor(Color("UserProfileCard2"))
                        .onTapGesture{
                            dashboardRouter.isPlusMenuOpen = false
                            dashboardRouter.currentTab = .addRecipes
                        }
                        Text("Add Recipe")
                      .font(.caption2)
                      .foregroundColor(Color("UserProfileCard2"))
                      .padding(.top, 75)
                      .onTapGesture{
                          dashboardRouter.isPlusMenuOpen = false
                          dashboardRouter.currentTab = .addMeal
                      }
              }
        }
        .transition(.scale)
    }
}

//struct PlusTabPopMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        PlusTabPopMenu(widthAndHeight: 100, selectedTab: .constant(.journal))
//    }
//}
