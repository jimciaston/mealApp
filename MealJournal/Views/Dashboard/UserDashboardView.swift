//
//  UserDashboardView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/4/22.
//

import SwiftUI
import Firebase
struct UserDashboardView: View {
    @StateObject var mealEntrys = MealEntrys()
    @ObservedObject var signUpController: SignUpController
   
    
    @State private var signedOut = false
    
    //    init(){
//        UITabBar.appearance().backgroundColor = UIColor.white
//        self._signUpController = signUpController
//    }
    
    var body: some View {
     
            TabView{
                UserDashController(signUpController: signUpController)
                        .tabItem{
                            VStack{
                                Image(systemName: "house.circle")
                                    .font(.title3)
                                Text("Home")
                            }
                        }
                
                           JournalEntryMain().environmentObject(mealEntrys) //references meal entry
                    
                            .tabItem{
                                VStack{
                                    Image(systemName: "pencil.circle")
                                        .font(.title3)
                                    Text("Meals")
                                }
                        } 
                    
                FollowingListView()
                            .tabItem{
                                VStack{
                                    Image(systemName: "person.2.circle")
                                        .font(.title3)
                                    Text("Following")
                                }
                        }
                           
            }
            .accentColor(.black)
               
        
    }
      
}
//struct UserDashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDashboardView()
//    }
//}