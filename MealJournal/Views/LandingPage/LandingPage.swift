//
//  LandingPage.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/2/22.
//

import SwiftUI
import SwiftUIX

extension View {
    func animatableGradient(fromGradient: Gradient, toGradient: Gradient, progress: CGFloat) -> some View {
        self.modifier(AnimatableGradientModifier(fromGradient: fromGradient, toGradient: toGradient, progress: progress))
    }
}


enum ViewState {
    case landingPage
    case createUserAccountView
    case signUpController
}

struct LandingPage: View {
    @AppStorage("signedIn") var signedIn = false
    @State private var isPressed = false
    @Environment (\.dismiss) var dismiss
   
    @StateObject var signUpController = SignUpController()
    @StateObject var vm = DashboardLogic()
    
    @State private var progress: CGFloat = 0
    //colors for background on landing page
   let gradient1 = Gradient(colors: [.pink, .orange])
   let gradient2 = Gradient(colors: [.orange, .yellow])
    
    @State private var animateGradient = false
    @State var scale: CGFloat = 1.0
    @State var offsetValue: CGFloat = -60 // << image
    @State var isMealJournalTitleShowing = false
    
    @State private var viewState: ViewState = .landingPage
    
    
    @ViewBuilder
    var body: some View {
        if(signedIn){
            UserDashboardView(vm: vm, signUpController: signUpController)
        }
        else{
            ZStack{
                Rectangle()
                .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                               .ignoresSafeArea()
                VStack{
                   
                    switch viewState{
                    case .landingPage:
                        
                        
                        VStack{
                            LandingPageLogo(offsetValue: $offsetValue, scale: $scale, isMealJournalTitleShowing: $isMealJournalTitleShowing)
                                .padding(.bottom, 60)
                         
                            Button(action: {
                                viewState = .createUserAccountView
                                offsetValue = -125
                                scale -= 0.50
                                isMealJournalTitleShowing = true
                            }){
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
                                            }
                            
                            
                               Button(action: {
                                   viewState = .signUpController
                                   offsetValue = -125
                                   scale -= 0.50
                                   isMealJournalTitleShowing = true
                               }){
                                   Text("Login").fontWeight(.bold)
                                       .frame(minWidth: 0, maxWidth: 200)
                                       .padding(10)
                                       .foregroundColor(.white)
                                       
                                   //draw rectange around buttons
                                       .overlay( RoundedRectangle(cornerRadius: 25)
                                       .stroke(Color.gray, lineWidth: 3)
                                   )}
                               .padding(.top, 10) // << button padding from top
                                
                        }
                        .frame(height: 500)
                        
                    case .createUserAccountView:
                        VStack{
                            LandingPageLogo(offsetValue: $offsetValue, scale: $scale, isMealJournalTitleShowing: $isMealJournalTitleShowing)
                                .frame(height:10)
                            createUserAccount()
                                .transition(.slide)
                               
                                
                        }
                    case .signUpController:
                            VStack{
                                LandingPageLogo(offsetValue: $offsetValue, scale: $scale, isMealJournalTitleShowing: $isMealJournalTitleShowing)
                                    .frame(height:10)
                                userLogin(signUpController: signUpController)
                                    .transition(.slide)
                            }
                    }
                        
                }
                .animation(.linear(duration: 0.25), value: viewState)
                        .frame(height: 500)
                        
            }
//
                    .onAppear {
                        DispatchQueue.main.async {
                            withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                                self.progress = 1.0
                                
                           }
                        }
//
                    }
                   
            }
            
        }
    }



   
struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
