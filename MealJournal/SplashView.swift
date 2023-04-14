//
//  SplashView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/14/23.
//

import SwiftUI

struct SplashView: View {
    @State private var progress: CGFloat = 0
    //colors for background on landing page
    let gradient1 = Gradient(colors: [Color("LandingPage1"), Color("LandingPage2")])
    let gradient2 = Gradient(colors: [.orange, Color("LandingPage3")])
    
  
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                LandingPage()  
            } else {
                ZStack{
                    Rectangle()
                        .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                        .ignoresSafeArea()
                    VStack{
                        Image("bodybuilding-1") // << main image
                            .resizable()
                            .scaledToFit()
                            .frame(width:200, height:200)
                            //.renderingMode(.template)
                            .foregroundColor(Color("titleLogo"))
                    }
                    .frame(width: 500, height: 200)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
