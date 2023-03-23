//
//  UserDashboardView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/4/22.
//

import SwiftUI
import Firebase
struct UserDashboardView: View {
    //Core Data Variables
    @Environment(\.managedObjectContext) var managedObjContext
    
    @StateObject var calendarHelper = CalendarHelper()
    @ObservedObject var vm: DashboardLogic
    @EnvironmentObject var mealEntrys: MealEntrys 
    @ObservedObject var signUpController: LandingPageViewModel
    @StateObject var dashboardRouter: DashboardRouter
    @StateObject var rm = RecipeLogic()
    @StateObject var rm_nonUser = RecipeLogicNonUser()
    @State private var signedOut = false
    //@State private var plusTabIconTapped = false
    @State private var closePlusIconPopUpMenu = false
    @State var isUserSearching = false
    @State var recipeSavedMessage = false
    
    //    init(){
//        UITabBar.appearance().backgroundColor = UIColor.white
//        self._signUpController = signUpController
//    }
   
    var body: some View {
        GeometryReader { geometry in
            if !vm.isUserDataLoading{
                VStack{
                    switch dashboardRouter.currentTab {
                        case .home:
                            if !isUserSearching{
                                UserDashController(vm: vm, signUpController: signUpController)
                                    .environmentObject(EditModeActive())
                                    .opacity(dashboardRouter.isPlusMenuOpen ? 0 : 0.8)
                            }
                           
                        
                    case .journal:
                        JournalEntryMain(dayOfWeek: "")
                    case .recipes:
                        RecipeFullListView_MainTab(recipes: rm_nonUser.savedRecipesNonUser, showAddButton: true, notCurrentUserProfile: .constant(false), // << don't show "created by" text in header
                                                   navigatingFromProfileCards: .constant(false))
                    case .searchUsers:
                        SearchUsersFeature()
                    case .addRecipes:
                        RecipeEditorHomeMenu(dashboardRouter: dashboardRouter, showSuccessMessage: $recipeSavedMessage)
                    case .addMeal:
                        MealSearchBarPopUp(isUserDoneSearching: $isUserSearching)
                    }
               
                    ZStack{
                        if  dashboardRouter.isPlusMenuOpen {
                            PlusTabPopMenu(widthAndHeight: geometry.size.width / 5.5, dashboardRouter: dashboardRouter, closePlusIconPopUpMenu: $closePlusIconPopUpMenu)
                                    .offset(y: -geometry.size.height/10)
                           }
                        HStack {
                            //home tab
                            TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "homekit", tabName: "Home", dashboardRouter: dashboardRouter, selectedTab: .home)
                            //journal tab
                            TabBarIconImage(width: geometry.size.width/6, height: geometry.size.height/25, iconName: "journalLogo_Dash", tabName: "Journal", dashboardRouter: dashboardRouter, selectedTab: .journal)
                            //PLUS
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
                                     .shadow(color: dashboardRouter.isPlusMenuOpen ?  Color("spaceGray") : Color("LightWhite"), radius: 1.2, x: 2, y: 5)
                                     .scaleEffect(dashboardRouter.isPlusMenuOpen ? 0.9 : 1)
  
                             }
                            
                            //animation for pop up menu
                            .onTapGesture{
                                withAnimation {
                                    dashboardRouter.isPlusMenuOpen.toggle()
                                 }
                            }
                            .frame(width:70, height: 60) // << changes sizing of row
                           
                            .offset(y: dashboardRouter.isPlusMenuOpen ? -geometry.size.height / 2/15 : -geometry.size.height / 2/10) // << bring up plus button
                            
                            TabBarIconImage(width: geometry.size.width/6, height: geometry.size.height/25, iconName: "recipeTabIcon", tabName: "Recipes", dashboardRouter: dashboardRouter, selectedTab: .recipes)
                            TabBarIconImage(width: geometry.size.width/6, height: geometry.size.height/25, iconName: "searchUsersIcon", tabName: "Find Users", dashboardRouter: dashboardRouter, selectedTab: .searchUsers)
                          
                            
                         }
                       
                        
                       // .position(x: screenSize.width / 2, y: screenSize.height / 20)
                        //background for tabbar
                        .frame(height:75)
                        
                        .frame(maxWidth: .infinity)
                     .background(Color("LighterWhite").shadow(radius: 2))
                            
                    }
                    .onAppear{
                        rm_nonUser.grabSavedUserRecipes()
                    }
                    
                    
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            ZStack{
             if recipeSavedMessage {
                 
                     //oringllay shown: #showsuccess button don't know how to incorporation
                     RecipeSuccessPopUp(showSuccessMessage: $recipeSavedMessage)
                    // allow view to leave after 2 seconds
                     .frame(width:geometry.size.width, height: geometry.size.height / 1.2)
                     .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Adjust the duration here
                            recipeSavedMessage = false
                        }
                    }
                }
                    
             
            }
        }
         
    }
      
}
struct UserDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboardView(vm: DashboardLogic(), signUpController: LandingPageViewModel(), dashboardRouter: DashboardRouter())
    }
}


