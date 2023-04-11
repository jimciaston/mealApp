//
//  ForgotPasswordView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/10/23.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    @Binding var loginPageViewState: LoginEnum
    @State private var email = ""
    @State private var emailDoesNotExist = false
    @State private var emailResetSuccess = false
    var body: some View {
        VStack{
            VStack {
                Text("Reset Password")
                    .font(.custom("OpenSans-Regular", size: 24))
                ZStack(alignment: .leading) {
                                TextField("Email", text: $email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 300)
                                    .padding()
                                    Text("It appears this email does not exist")
                                        .foregroundColor(.red)
                                        .font(.system(size: 14))
                                        .padding(.leading)
                                        .offset(y: 50)
                                        .padding(.leading, 5)
                                        .opacity(emailDoesNotExist ? 1 : 0.0)
                                
                            }
                
                Button(action: {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                     
                        if let error = error {
                            print("error")
                            emailDoesNotExist = true
                            emailResetSuccess = false
                        } else {
                            print("saved")
                            emailDoesNotExist = false
                            emailResetSuccess = true
                        }
                    }
                }) {
                    Text("Reset Password")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color("defaultColorForExercise"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 25)
                }
                .padding()
                
                Text("Go Back")
                    .onTapGesture{
                        loginPageViewState = .loginPage
                    }
                
            }
            .opacity(emailResetSuccess ? 0.0 : 1)
            ZStack{
                GeometryReader { geometry in
                    if emailResetSuccess {
                        
                            //oringllay shown: #showsuccess button don't know how to incorporation
                        PasswordResetSuccess(showSuccessMsg: $emailResetSuccess)
                           // allow view to leave after 2 seconds
                            .frame(width:geometry.size.width, height: geometry.size.height / 5)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) { // Adjust the duration here
                                  
                                    loginPageViewState = .loginPage
                               }
                           }
                       }
                }

            }
        }
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(loginPageViewState: .constant(.loginPage))
    }
}
