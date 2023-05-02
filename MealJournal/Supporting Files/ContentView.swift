//
//  ContentView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/2/22.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let isSignedIn = UserDefaults.standard.object(forKey: "signedIn") as? Bool ?? false
    var body: some View {
       
        if isSignedIn {
            SplashView()
        }
        else{
            LandingPage()
        }
      
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}

