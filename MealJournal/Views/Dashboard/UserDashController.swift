//
//  Toolbar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/14/22.
//

import SwiftUI

struct UserDashController: View {
    
   // @State private var showMealView = false
    @State private var showSettingsView = false
    @State private var showAddViews = false

    @State private var angle: Double = 0
    
    init(){
        UIToolbar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        NavigationView {
            VStack{
                ProfilePicture()
                   
                FollowUserButton()
                    .padding(.top, 10)
                MacroView()
                    .padding(.top, 25)
                    .padding(.bottom, -20)
                RecipeListView()
            }
        
            //sets setting bar top right
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        VStack{
                            Button(action: {
                                showSettingsView.toggle()
                            }) {
                                Image(systemName: "line.3.horizontal")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                            .sheet(isPresented: $showSettingsView){
                                JournalEntryMain()
                            }
                        }
                   }
                    
                   // sets add meal option bottom/center
                    ToolbarItem(placement: .bottomBar) {
                        //displaying add meal and recipe icons when clicked
                        HStack{
                            Button(action: {
                                angle += 90
                                showAddViews.toggle()
                            }) {
                                if showAddViews {
                                    VStack{
                                        AddToolbar(showAddOptions: $showAddViews)
                                            .offset(y:-50)
                                    }
                                }
                            Image(systemName: "plus.square")
                                .opacity(showAddViews ? 0.5 : 1)
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .rotationEffect(.degrees(angle))
                                .animation(.easeIn(duration: 0.25), value: angle)
                        }
                    }
                }
            }
        }
    }
}

struct UserDashController_Previews: PreviewProvider {
    static var previews: some View {
        UserDashController()
    }
}

