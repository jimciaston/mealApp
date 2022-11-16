//
//  UserDashboardView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/4/22.
//

import SwiftUI
import Firebase
struct UserDashboardView: View {
    @ObservedObject var vm: DashboardLogic
    @EnvironmentObject var mealEntrys: MealEntrys
    @ObservedObject var signUpController: SignUpController
    @StateObject var dashboardRouter: DashboardRouter
    @StateObject var rm = RecipeLogic()
    @State private var signedOut = false
   
    //    init(){
//        UITabBar.appearance().backgroundColor = UIColor.white
//        self._signUpController = signUpController
//    }
   
    var body: some View {
        GeometryReader { geometry in
            VStack{
                switch dashboardRouter.currentTab {
                    case .home:
                        UserDashController(vm: vm, signUpController: signUpController)
                            .environmentObject(EditModeActive())
                           
                case .journal:
                    JournalEntryMain()
                case .recipes:
                    RecipeFullListView(recipes: rm.recipes, showAddButton: true)
                case .searchUsers:
                    SearchUsersFeature()
                }
                
                
                HStack {
                    TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "homekit", tabName: "Home", dashboardRouter: dashboardRouter, selectedTab: .home)
                    TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "pencil.circle", tabName: "Journal", dashboardRouter: dashboardRouter, selectedTab: .journal)
                    ZStack {
                         Circle()
                            .foregroundColor(.white) //<<adds border around image
                          //  .frame(width: 10 , height: 10)
                        
                        TabBarIconPlus(width: geometry.size.width/100, height: geometry.size.height / 10, iconName: "", tabName: "")
                            .foregroundColor(.white)
                                     .shadow(radius: 4)
                         Image(systemName: "plus.circle.fill")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 50 , height: 50)
                             .foregroundColor(Color("ButtonTwo"))
                             .shadow(color: Color("LightWhite"), radius: 1.2, x: 2, y: 5)
                     }
                    
                    .frame(width:70, height: 60) // << changes sizing of row
                   
                    
                        .offset(y: -geometry.size.height / 2/15) // << bring up plus button
                    
                    TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "magnifyingglass.circle", tabName: "Recipes",dashboardRouter: dashboardRouter, selectedTab: .recipes)
                    TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "magnifyingglass.circle", tabName: "Find Users", dashboardRouter: dashboardRouter, selectedTab: .searchUsers)
                    
                    
                 }
               
                
               // .position(x: screenSize.width / 2, y: screenSize.height / 20)
                .frame(height:90)
                     .background(Color(.clear).shadow(radius: 2))
                    
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        
       
        
    }
      
}
struct UserDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboardView(vm: DashboardLogic(), signUpController: SignUpController(), dashboardRouter: DashboardRouter())
    }
}


