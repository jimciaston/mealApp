//
//  UserDashboardView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/4/22.
//

import SwiftUI

struct UserDashboardView: View {
    
    var body: some View {
        NavigationView{
            TabView{
                UserDashController()
                        .tabItem{
                            VStack{
                                Image(systemName: "list.bullet.rectangle")
                                    .font(.title3)
                                Text("Home")
                            }
                        }
                        JournalEntryMain().navigationBarHidden(true)
                           
                            .tabItem{
                                VStack{
                                    Image(systemName: "list.bullet.rectangle")
                                        .font(.title3)
                                    Text("Meals")
                                }
                        }
                RecipeFullListView()
                            .tabItem{
                                VStack{
                                    Image(systemName: "list.bullet.rectangle")
                                        .font(.title3)
                                    Text("Meals")
                                }
                        }
            }
        }
        .navigationBarHidden(true)
    }
}
struct UserDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboardView()
    }
}
