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
    @Environment (\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // ipad sizing
    @AppStorage("notUserFirstVisit") var notUserFirstVisit = false
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
    let networkConnectivity = NetworkConnectivity()
    
    
//    func requestPushNotificationPermission() {
//           UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//               pushNotificationPermissionStatus = granted ? .authorized : .denied
//           }
//       }
//
//    func showAlertForPushNotificationPermission() {
//        let message = "Allow app to send push notifications?"
//        let alert = UIAlertController(title: "Push Notification", message: message, preferredStyle: .alert)
//
//        let allowAction = UIAlertAction(title: "Allow", style: .default) { _ in
//            requestPushNotificationPermission()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//
//        alert.addAction(allowAction)
//        alert.addAction(cancelAction)
//
//        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
//            rootViewController.present(alert, animated: true, completion: nil)
//        }
//    }
  
    
    
    var body: some View {
        GeometryReader { geometry in
            if !vm.isUserDataLoading { // disable to see previews
                VStack{
                    switch dashboardRouter.currentTab {
                        case .home:
                            if !isUserSearching{
                                UserDashController(vm: vm, signUpController: signUpController)
                                    .environmentObject(EditModeActive())
                                    .opacity(dashboardRouter.isPlusMenuOpen ? 0 : 1)
                            }
                           
                        
                    case .journal:
                        JournalEntryMain(dayOfWeek: "")
                            .opacity(dashboardRouter.isPlusMenuOpen ? 0 : 1)
                    case .recipes:
                        RecipeFullListView_MainTab(recipes: rm_nonUser.savedRecipesNonUser, showAddButton: true, notCurrentUserProfile: .constant(false), // << don't show "created by" text in header
                                                   navigatingFromProfileCards: .constant(false))
                        .opacity(dashboardRouter.isPlusMenuOpen ? 0 : 1)
                    case .searchUsers:
                        SearchUsersFeature()
                            .opacity(dashboardRouter.isPlusMenuOpen ? 0 : 1)
                            .animation(nil)
                    case .addRecipes:
                        RecipeEditorHomeMenu(dashboardRouter: dashboardRouter, showSuccessMessage: $recipeSavedMessage)
                            .opacity(dashboardRouter.isPlusMenuOpen ? 0 : 1)
                    case .addMeal:
                        MealSearchBarPopUp(isUserDoneSearching: $isUserSearching)
                            .opacity(dashboardRouter.isPlusMenuOpen ? 0 : 1)
                        
                    case .profileCardRecipes:
                        RecipeFullListView(recipes: rm.recipes, showAddButton: true, notCurrentUserProfile: .constant(false), navigatingFromProfileCards: .constant(true))
                          //  .opacity(.dashboardRouter.isPlusMenuOpen ? 0 : 1)
                    }
                    //mini buttons
//                    let widthAndHeight: CGFloat = {
//                        if horizontalSizeClass == .regular {
//                            return 100 // set a smaller size for iPad
//                        } else {
//                            return UIScreen.main.bounds.width / 5.5 // use existing size for other devices
//                        }
//                    }()
                    ZStack{
                        if  dashboardRouter.isPlusMenuOpen {
                            PlusTabPopMenu(widthAndHeight:  horizontalSizeClass == .regular ? 120: geometry.size.width / 5.5, dashboardRouter: dashboardRouter, closePlusIconPopUpMenu: $closePlusIconPopUpMenu)
                                .padding(.top, horizontalSizeClass == .regular ? -100 : -50)
                                    .offset(y: -geometry.size.height/10) // << move up or down menu icon
                           }
                        HStack {
                            //home tab
                            TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "homekit", tabName: "Home", dashboardRouter: dashboardRouter, selectedTab: .home)
                            //journal tab
                            TabBarIconImage(width: geometry.size.width/6, height: geometry.size.height/25, iconName: "journalLogo_Dash", tabName: "Journal", dashboardRouter: dashboardRouter, selectedTab: .journal)
                            //PLUS
                            ZStack {
                                 Circle()
                                    .foregroundColor(colorScheme == .dark ? Color("LightWhite") : .white) //<<adds border around image
                                  //  .frame(width: 10 , height: 10)
                                
                                TabBarIconPlus(width: geometry.size.width/100, height: geometry.size.height / 10, iconName: "", tabName: "")
                                    .foregroundColor(.white)
                                             .shadow(radius: 4)
                                 Image(systemName: "plus.circle.fill")
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: horizontalSizeClass == .regular ? 65 : 50 , height: horizontalSizeClass == .regular ? 65 : 50)
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
                            .frame(width:100, height: 60) // << changes sizing of row
                           
                            .offset(y: dashboardRouter.isPlusMenuOpen ? -geometry.size.height / 2/15 : -geometry.size.height / 2/8) // << bring up plus button
                            
                            TabBarIconImage(width: geometry.size.width/6, height: geometry.size.height/25, iconName: "recipeSavedIcon", tabName: "Recipes", dashboardRouter: dashboardRouter, selectedTab: .recipes)
                            TabBarIconImage(width: geometry.size.width/6, height: geometry.size.height/25, iconName: "nuts", tabName: "Find Users", dashboardRouter: dashboardRouter, selectedTab: .searchUsers)
                    
                            
                         }
                        //background for tabbar
                        .frame(height: horizontalSizeClass == .regular ? 100 : 75)
            
                        
                        .frame(maxWidth: .infinity)
                     .background(Color("LighterWhite").shadow(radius: 2))
                            
                    }
                    
                    .onAppear{
                        
//                        if !notUserFirstVisit { // << Only show alert if first Time visit
//                            if let status = pushNotificationPermissionStatus {
//                                          switch status {
//                                              case .authorized, .denied:
//                                                  break
//                                              default:
//                                                 break
//                                          }
//                                      } else {
//                                          if  !notUserFirstVisit {
//                                              showAlertForPushNotificationPermission()
//                                              notUserFirstVisit = true
//                                          }
//
//                                      }
//                        }
                     
                        
                        
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
                         DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Adjust the duration here
                            recipeSavedMessage = false
                            dashboardRouter.currentTab = .profileCardRecipes
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


