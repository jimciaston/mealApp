//
//  LandingPage.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/2/22.
//

import SwiftUI

struct LandingPage: View {
    @AppStorage("signedIn") var signedIn = false
    @Environment (\.dismiss) var dismiss
    
    @StateObject var signUpController = SignUpController()
    @StateObject var vm = DashboardLogic()
    
    @State private var animateGradient = false
    @State private var test = false
    
    @ViewBuilder
    var body: some View {
        if(signedIn){
            UserDashboardView(vm: vm, signUpController: signUpController)
        }
        else{
            NavigationView{
                VStack{
                        Image("bodybuilding-1") // << main image
                            .resizable()
                            .scaledToFit()
                            //.frame(width:150, height:150)
                            //.renderingMode(.template)
                            .foregroundColor(.black)
                            .padding(.top, 200)
                    
                        Text("Welcome to Meal Journal")
                            .font(.title)
                            .padding()
                    
                    .offset(y:-25) // << adjusts title
                    
                    VStack{
                        NavigationLink(destination:createUserAccount() .navigationBarHidden(true),
                       label:{
                            Text("Get Started").fontWeight(.bold)
                                .frame(minWidth: 0, maxWidth: 200)
                                .padding(10)
                                .foregroundColor(.white)
                            //draw rectange around buttons
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(
                                            LinearGradient(
                                                colors: [.orange, .yellow],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )))
                                        })
                        
                        NavigationLink(destination: userLogin(signUpController: signUpController).navigationBarHidden(true), label: {
                            Text("Login").fontWeight(.semibold)
                                .frame(minWidth:0, maxWidth: 200)
                                .padding(10)
                                .foregroundColor(.black)
                                .overlay( RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.gray, lineWidth: 3)
                                    )
                        })
                            .padding()
                    }
                    Rectangle()
                        .frame(height: 0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                }
                //.background(Color.purple)
                .background(RadialGradient(colors: [.purple, .yellow], center: .center, startRadius: animateGradient ? 400 : 200, endRadius: animateGradient ? 20 : 40))
                .onAppear {
                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                }
                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                 .ignoresSafeArea()
                
            }
            
        }
    }
}


   
struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
