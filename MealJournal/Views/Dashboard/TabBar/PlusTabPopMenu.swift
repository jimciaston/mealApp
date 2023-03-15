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
        HStack(spacing: 20) {
              ZStack {
                Circle()
                  .foregroundColor(Color("DarkPurple"))
                  .frame(width: widthAndHeight, height: widthAndHeight)
                Image("pullUpMealIcon")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .padding(15)
                  .frame(width: widthAndHeight, height: widthAndHeight)
                  .foregroundColor(Color("ButtonTwo"))
                  
                  .onTapGesture{
                      dashboardRouter.isPlusMenuOpen = false
                      dashboardRouter.currentTab = .addMeal
                  }
              }
              ZStack {
                Circle()
                  .foregroundColor(Color("DarkPurple"))
                  .frame(width: widthAndHeight, height: widthAndHeight)
                  //add recipe tab
                Image("recipeProfileCardIcon")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .padding(15)
                  .frame(width: widthAndHeight, height: widthAndHeight)
                  .foregroundColor(Color("ButtonTwo"))
                  .onTapGesture{
                      dashboardRouter.isPlusMenuOpen = false
                      dashboardRouter.currentTab = .addRecipes
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
