//
//  TabBar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/23/22.
//

import SwiftUI

struct TabBarIcon: View {
    let width, height: CGFloat
    let iconName, tabName: String
    
    @ObservedObject var dashboardRouter: DashboardRouter
    let selectedTab: DashboardTab
    
    var body: some View {
        VStack {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .padding(.top, 10)
                Text(tabName)
                    .font(.footnote)
                Spacer()
            }
                .padding(.horizontal, -4)
                .foregroundColor(dashboardRouter.currentTab == selectedTab ? Color(.blue) : Color (.black))
                .onTapGesture {
                    dashboardRouter.isPlusMenuOpen = false
                    
                    // don't allow view to be clicked again if selected tab is already present
                    if dashboardRouter.currentTab != selectedTab {
                        dashboardRouter.currentTab = selectedTab
                          
                    }
               }
            }
        }

//struct TabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBar()
//    }
//}
