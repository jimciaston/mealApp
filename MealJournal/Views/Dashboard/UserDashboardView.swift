//
//  UserDashboardView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/4/22.
//

import SwiftUI

struct UserDashboardView: View {
    @State var selectedIndex = 0
   
    init(){
        UITabBar.appearance().backgroundColor = UIColor.white
        
    }
  
    var body: some View {
        NavigationView{
            TabView{
                UserDashController()
                        .tabItem{
                            VStack{
                                Image(systemName: "house.circle")
                                    .font(.title3)
                                Text("Home")
                            }
                        }
                
                           JournalEntryMain()
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
                           
            }.accentColor(.black)
        }
        .navigationBarHidden(true)
      
      
    }
      
}
struct UserDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboardView()
    }
}
