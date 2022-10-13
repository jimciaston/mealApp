//
//  Login.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/8/22.
//

import SwiftUI

struct userLogin: View {
    @State private var userLoginSuccess: Bool = false
    @State var userEmail: String = "";
    @State var userPassword: String = "";
    @State  var isPWSecured = true
    @State var success = false //binded with loginUser function
    @State var userAttemptedToLogin = false
    
    @StateObject var vm = DashboardLogic()
    @ObservedObject var userInformation = FormViewModel()
    @ObservedObject var keyboardResponder = KeyboardResponder()
    @ObservedObject var signUpController: SignUpController
   
    
    var body: some View {
            VStack{
                Text("Sign In")
                    .font(.title)
                    .fontWeight(.medium)
                HStack{
                    Image(systemName: "mail")
                        .padding(15)
                        .foregroundColor(.orange)
                    
                    TextField("Email", text: $userEmail)
                        .font(.title3)
                        .frame(width:240, height:50)
                    
                    }
                .padding(.trailing, 25) //evens out email width with password
        
                    .overlay( RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray, lineWidth: 3)
                        )
                        .offset(y:15)
                        .padding(.bottom, 20)
                
                VStack{
                    HStack{
                        Image(systemName: "lock")
                            .padding(10)
                            .foregroundColor(.orange)
                        
                        HStack{
                            if isPWSecured {
                                SecureField("Password", text: $userPassword)
                                    .font(.body)
                                    .frame(width:220, height:50)
                            }
                            else {
                                TextField("Password", text: $userPassword)
                                    .font(.body)
                                    .frame(width:220, height:50)
                            }
                            Button(action: {
                                isPWSecured.toggle()
                            }){
                                Image(systemName: self.isPWSecured ? "eye.slash" : "eye")
                                                    .accentColor(.gray)
                                                    .padding(.trailing, 25)
                            }
                        }

                    }
                    
                    .overlay( RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray, lineWidth: 3)
                        )
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
                    HStack{
                        
                        NavigationLink(destination: JournalEntryMain() .navigationBarHidden(true)){
                                Text("Forgot Password?").font(.subheadline).italic()
                        }
                        .foregroundColor(.gray)
                        .offset(y:20)
                        
                        NavigationLink(destination: createUserAccount() .navigationBarHidden(true)){
                                Text("Create account").font(.subheadline).italic()
                        }
                        .foregroundColor(.black)
                        .offset(y:20)
                    }
                    
                        
                }
                
                //user Login button
                Button(action: {
                    userAttemptedToLogin = true
                    signUpController.loginUser(userEmail: userEmail, userPassword: userPassword)
                    
                    if (signUpController.userIsLoggedIn){
                        success = true
                    }
                   
                }){
                    
                    NavigationLink("", destination: UserDashboardView(vm: vm, signUpController: signUpController)
                                    
                                   , isActive: $signUpController.userIsLoggedIn)
                    
                   
                    Text("Login")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width:250, height:50)
                        .background(RoundedRectangle(cornerRadius: 25)
                            .fill(LinearGradient(
                                colors: [.orange, .yellow],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                        )
                  
                }
                .offset(y:50)
                
                .onAppear{
                    print(success)
                }
            }
            .offset(y:-100)
            .offset(y: keyboardResponder.currentHeight/20)
        }
       
    }
    


//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        userLogin(userEmail: "jim", userPassword: 111, isPWSecured: true, success: false, userAttemptedToLogin: true, userInformation: FormViewModel(), keyboardResponder: <#T##KeyboardResponder#>, signUpController: <#T##SignUpController#>)
//    }
//}
//
