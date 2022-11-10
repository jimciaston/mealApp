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
   
  
    @State private var signedOut = false
    
    //    init(){
//        UITabBar.appearance().backgroundColor = UIColor.white
//        self._signUpController = signUpController
//    }
   
    var body: some View {
        GeometryReader { geometry in
            VStack{
                UserDashController(vm: vm, signUpController: signUpController)
                    .environmentObject(EditModeActive())
                    .frame(width: geometry.size.width, height: geometry.size.height - 60)
                HStack {
                    TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "homekit", tabName: "Home")
                    TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "pencil.circle", tabName: "Journal")
                    ZStack {
                         Circle()
                            .foregroundColor(.white) //<<adds border around image
                          //  .frame(width: 10 , height: 10)
                        
                        TabBarIconPlus(width: geometry.size.width/100, height: geometry.size.width/10, iconName: "", tabName: "")
                            .foregroundColor(.white)
                                  
                                     .shadow(radius: 4)
                         Image(systemName: "plus.circle.fill")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 50 , height: 50)
                             .foregroundColor(Color(.black))
                     }
                    .frame(width:100, height: 60) // << changes sizing of row
                        .offset(y: -geometry.size.height/10/2) // << bring up plus button
                    
                    TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "magnifyingglass.circle", tabName: "Recipes")
                    TabBarIcon(width: geometry.size.width/6, height: geometry.size.height/30, iconName: "magnifyingglass.circle", tabName: "Find Users")
                    
                    
                 }
                     .frame(width: geometry.size.width, height: geometry.size.height/10)
                     .background(Color(.clear).shadow(radius: 2))
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        
        
        
    }
      
}
struct UserDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboardView(vm: DashboardLogic(), signUpController: SignUpController())
    }
}


