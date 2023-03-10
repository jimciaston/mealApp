//
//  TabBarIconImage.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/28/23.
//

import SwiftUI

struct TabBarIconImage: View {
    let width, height: CGFloat
    let iconName: String
    let  tabName: String
    
    @ObservedObject var dashboardRouter: DashboardRouter
    let selectedTab: DashboardTab
    
    var body: some View {
        VStack {
                Image(iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            
                    .frame(width: width, height: height)
                    .padding(.top, 10)
           
                Text(tabName)
                    .font(.footnote)
                    .padding(.top, -5)
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

