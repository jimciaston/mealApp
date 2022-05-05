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
  
    
    
    init(){
        
       // UIToolbar.appearance().backgroundColor = UIColor(red: 0.0/255.0, green: 125/255.0, blue: 0.0/255.0, alpha: 1.0)
//        UIToolbar.appearance().scrollEdgeAppearance = UIToolbar().compactAppearance
        UIToolbar.appearance().isTranslucent = true
       
    }
    
    var body: some View {
       
    
            VStack{
                
                ProfilePicture()
  
                FollowUserButton()
                    .padding(.top, 10)
                
                MacroView()
                   
                    .padding(.top, 25)
                    .padding(.bottom, -20)
                RecipeListView()
                   
                   
            }
        }
    }

        
    


struct UserDashController_Previews: PreviewProvider {
    static var previews: some View {
        UserDashController()
    }
}

