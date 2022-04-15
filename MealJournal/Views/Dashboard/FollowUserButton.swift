//
//  AddMeal.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/14/22.
//

import SwiftUI

struct FollowUserButton: View {
    //when true, subscribe window opens
    @State private var subscribeWindow = false
       var body: some View {
               ZStack {
                   HStack(){
                       //Button Follow on Profile Page
                       Button(action: {
                           subscribeWindow.toggle()
                       })
                        {
                           Text("Follow")
                                   .padding(10)
                                   .border(.green, width: 2)
                                   .foregroundColor(.black)
                          
                       }
                   }
                   
                   if subscribeWindow {
                       
                       withAnimation(.easeIn(duration: 1)) {
                           SubscriptionPopUp(show: $subscribeWindow)
                               .frame(width:700, height: 800)
                       }
                   }
               }
           }
        }

struct UserDashboard_Previews: PreviewProvider {
    static var previews: some View {
        FollowUserButton()
    }
}
