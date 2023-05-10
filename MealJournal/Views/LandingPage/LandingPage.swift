//
//  LandingPage.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/2/22.
//

import SwiftUI
import SwiftUIX
import Firebase

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
    @Environment (\.colorScheme) var colorScheme
    @State private var isPressed = false
    @Environment (\.dismiss) var dismiss
   
    @StateObject var signUpController = LandingPageViewModel()
    @StateObject var vm = DashboardLogic()
    
    @State private var progress: CGFloat = 0
    //colors for background on landing page
    let gradient1 = Gradient(colors: [Color("LandingPage1"), Color("LandingPage2")])
    let gradient2 = Gradient(colors: [.orange, Color("LandingPage3")])
    
    @State private var animateGradient = false
    @State var scale: CGFloat = 1.0
    @State var offsetValue: CGFloat = -60 // << image
    @State var isMealJournalTitleShowing = false
    
    @State private var viewState: ViewState = .landingPage
    @State var showingPopup = false
    
    @ViewBuilder
    var body: some View {
        if(signedIn){
            UserDashboardView(vm: vm, signUpController: signUpController, dashboardRouter: DashboardRouter())
                .onAppear{
                    vm.fetchCurrentUser()
                }
        }
        else{
            ZStack{
                Rectangle()
                .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                               .ignoresSafeArea()
                
                VStack{
                //using switch to control views, so background stays persistent
                //during signup
                    
                switch viewState{
                    case .landingPage:
                        VStack{
                            LandingPageLogo(offsetValue: $offsetValue, scale: $scale, isMealJournalTitleShowing: $isMealJournalTitleShowing)
                                .padding(.bottom, 100)
                         
                            Button(action: {
                                viewState = .createUserAccountView
                              //  offsetValue = -200
                                scale -= 0.50
                                isMealJournalTitleShowing = true
                            }){
                                Text("Get Started").fontWeight(.bold)
                                    .frame(minWidth: 0, maxWidth: 200)
                                    .padding(10)
                                    .foregroundColor(.white)
                                    
                                //draw rectange around buttons
                                      .overlay( RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("getStartedButton"), lineWidth: 4)
                                   )
                                      .shadow(color: colorScheme != .dark ? Color("LightWhite") : .white, radius: 4, x: 0, y: 3)
                            }
                            
                               Button(action: {
                                   viewState = .signUpController
                                   scale -= 0.50
                                   isMealJournalTitleShowing = true
                               }){
                                   Text("Login")
                                       .frame(minWidth: 0, maxWidth: 200)
                                       .padding(10)
                                       .foregroundColor(.white)
                                       
                                   //draw rectange around buttons
                                     }
                               .padding(.top, 10) // << button padding from top
                                
                        }
                        .frame(height: 500)
                        
                    case .createUserAccountView:
                        VStack{
                            LandingPageLogo(offsetValue: $offsetValue, scale: $scale, isMealJournalTitleShowing: $isMealJournalTitleShowing)
                                .frame(height:10)
                            createUserAccount()
                             
                               
                        }
                    case .signUpController:
                            VStack{
                                LandingPageLogo(offsetValue: $offsetValue, scale: $scale, isMealJournalTitleShowing: $isMealJournalTitleShowing)
                                    .frame(height:10)
                                userLogin(signUpController: signUpController)
                                   
                            }
                    }
                        
                }
                .animation(.linear(duration: 0.25), value: viewState)
                        .frame(height: 500)
                        
            }
                    .onAppear {
                        //animation for background colors
                        DispatchQueue.main.async {
                            withAnimation(.linear(duration: 4.0).repeatForever(autoreverses: true)) {
                                self.progress = 1
                                
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
