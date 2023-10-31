//
//  Login.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/8/22.
//

import SwiftUI

enum LoginEnum{
    case loginPage
    case createAccount // <<will be forgot passwrod once ready to setup
    case forgotPassword
    case journalEntryMain // switch name createAccoutn when ready
}


struct userLogin: View {
    @StateObject var calendarHelper = CalendarHelper()
    @State private var userLoginSuccess: Bool = false
    @State var userEmail: String = "";
    @State var userPassword: String = "";
    @State  var isPWSecured = true
    @State var success = false //binded with loginUser function
    @State var userAttemptedToLogin = false
    
    @StateObject var vm = DashboardLogic()
 
    @ObservedObject var keyboardResponder = KeyboardResponder()
    @ObservedObject var signUpController: LandingPageViewModel
    @State var loginPageViewState: LoginEnum = .loginPage
    
    var body: some View {
        
    switch loginPageViewState{
        case .loginPage:
            VStack{
//                Text("Sign In")
//                    .font(.custom("Montserrat-Regular", size: 21))
//                    .fontWeight(.medium)
//
                HStack{
//                    Image(systemName: "mail")
//                        .padding(15)
//                        .foregroundColor(Color("sports"))
//
                    TextField("", text: $userEmail)
                        .placeholder(when: userEmail.isEmpty) {
                            Text("Email").foregroundColor(Color(.white))
                                .font(.custom("Montserrat-Regular", size: 20))
                                                    .fontWeight(.medium)
                        }
                        .padding(15)
                       .padding(.leading, 65)
                        .submitLabel(.done)
                      
                    }
                .foregroundColor(.white)
               // .padding(.trailing, 25) //evens out email width with password
                .padding(.bottom, -10)
//
//                    .overlay( RoundedRectangle(cornerRadius: 25)
//                                .stroke(Color("LighterGray"), lineWidth: 1)
//                        )
//                        .offset(y:15)
//                        .padding(.bottom, 20)
                
                VStack{
                    HStack{
//                        Image(systemName: "lock")
//                            .padding(15)
//                            .foregroundColor(Color("sports"))
//
                        HStack{
                            if isPWSecured {
                                   SecureField("", text: $userPassword)
                                       .placeholder(when: userPassword.isEmpty) {
                                           Text("Password").foregroundColor(Color(.white))
                                               .font(.custom("Montserrat-Regular", size: 20))
                                               .fontWeight(.medium)
                                              
                                       }
                                       .padding(15)
                                       .padding(.leading, 65)
                                       .submitLabel(.done)
                                       .foregroundColor(Color(.white))
                               } else {
                                   TextField("", text: $userPassword)
                                       .placeholder(when: userPassword.isEmpty) {
                                           Text("Password").foregroundColor(Color(.white))
                                               .font(.custom("Montserrat-Regular", size: 20))
                                               .fontWeight(.medium)
                                             
                                       }
                                       .padding(15)
                                       .padding(.leading, 65)
                                       .submitLabel(.done)
                                       .foregroundColor(Color(.white))
                                      
                               }
                           
                        }
                        Button(action: {
                            isPWSecured.toggle()
                        }){
                            Image(systemName: self.isPWSecured ? "eye.slash" : "eye")
                                    .accentColor(.gray)
                                   
                        }
                        .padding(.leading, -140)
                        .frame(width:10)
                    }
//
//                    .overlay( RoundedRectangle(cornerRadius: 25)
//                        .stroke(Color("LighterGray"), lineWidth: 1)
//                        )
                          .offset(y:15)
                    
                    .onTapGesture{
                        hide_UserKeyboard()
                    }
                    
                    if userAttemptedToLogin {
                        if(!signUpController.failedMessage.isEmpty){
                            Text(signUpController.failedMessage)
                                    .font(.caption).italic().foregroundColor(.red)
                                    .padding(.top, 25)
                                    .padding(.trailing, 60)
                        }
                        
                        
                    }
                    VStack(alignment: .trailing){
                        Button(action: {
                            loginPageViewState = .forgotPassword
                        })
                        {
                            Text("Forgot Password?")
                                .font(.subheadline)
                                .italic()
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing, 80)
                                .padding(.top, 10)
                        }
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.gray)
                 
                        
                        Button(action: {
                            loginPageViewState = .createAccount
                        })
                        {
                            Text("Create Account")
                                .font(.body)
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, -15)
                                .padding(.top, 45)
                        }
                        .ignoresSafeArea(.keyboard)
                
                        .foregroundColor(.black)
                        .offset(y:20)
                    }
                    .padding(.top, 20)
                        
                }
                
                //user Login button
                Button(action: {
                    userAttemptedToLogin = true
                    signUpController.loginUser(userEmail: userEmail, userPassword: userPassword)
                    
                    if (signUpController.userIsLoggedIn){
                        success = true
                    }
                   
                }){
                    
                    NavigationLink("", destination: UserDashboardView(vm: vm, signUpController: signUpController, dashboardRouter: DashboardRouter())
                                    
                                   , isActive: $signUpController.userIsLoggedIn)
                    
                   
                    Text("Login")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width:250, height:50)
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(
                                colors: [Color("GetStartedBtn"), Color("LandingPage_LoginBtn")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                        )
                  
                }
                .ignoresSafeArea(.keyboard)
                .offset(y:50)
              
            }
        
            .offset(y: keyboardResponder.currentHeight/20)
            
        case .createAccount:
                createUserAccount() // << will be forgot password
           
        case .journalEntryMain:
            JournalEntryMain(dayOfWeek: weekdayAsString(date: calendarHelper.currentDay)) // << will be create
            
    case .forgotPassword:
        ForgotPasswordView(loginPageViewState: $loginPageViewState)
        }
    }
            
        
       
}
    


struct LoginPreview: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                userLogin(signUpController: LandingPageViewModel())
            }
            .previewDevice("iPhone 12 Pro")
            
            NavigationView {
                userLogin(signUpController: LandingPageViewModel())
            }
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 Pro")
        }
    }
}




//
