//create user account
import SwiftUI
import UIKit
import CoreData
import Firebase

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


// enum for create account page
enum CreateAccountViewState {
    case createAccount // << stay on page
    case login // << proceed to login page
}

struct createUserAccount: View {
    @Environment (\.colorScheme) var colorScheme
    //transition for fitness form
    let transition: AnyTransition = .asymmetric(insertion: .move(edge:.trailing), removal: .move(edge: .leading))
    //Stores form info as userInfo, stored in userModel
   
    //moves up stuff in view if keyboard is out
    @ObservedObject var keyboardResponder = KeyboardResponder()
    //calls signUpController
    @StateObject var signUpController = LandingPageViewModel()
  
    
    @State private var showFitnessForm = false
    @State private var emailAlreadyInUse = false // << email in use logic
    
    @Environment (\.dismiss) var dismiss
   
    @State private var viewState: CreateAccountViewState = .createAccount //viewState of page
    @State var fullName = ""
    @State var userName = ""
    @State var userEmail = ""
    @State var userPassword = ""
    
    @State private var isPWSecured = true
    
    //for anim
    @State private var offset: CGFloat = 1.0
    
    @State private var isEmailValid = false
    @State private var isPWValid = false
    
    var passwordPrompt: String {
        if isPasswordValid(){
            return ""
        } else {
            return "*Password must be 8-15 letters, with atleast one uppercase and one number"
        }
    }
        func isPasswordValid() -> Bool {
            let passwordTest = NSPredicate(format: "SELF MATCHES%@", "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
            return passwordTest.evaluate(with: self.userPassword)
        }
    
    var isSignUpComplete: Bool {
        if isPasswordValid() && isEmailValid_Test() && userName != ""{
            return true
        }
        return false
    }
    //validate email
    func isEmailValid_Test() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES%@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: self.userEmail)
    }

    var emailPrompt: String {
        if isEmailValid_Test(){
            return ""
        } else {
            return "*Please enter a valid email address"
        }
    }
    
    
    var body: some View {
      
            switch viewState{
                case .createAccount:
                            Section(){
                                TextField("", text: $fullName)
                                    .placeholder(when: fullName.isEmpty) {
                                        Text("Full Name").foregroundColor(Color(.white))
                                            .font(.custom("Montserrat-Regular", size: 20))
                                                                .fontWeight(.medium)
                                    }
                                   
                                    .padding(.leading, 25)
                                    .submitLabel(.done)
                                TextField("", text: $userName)
                                    .placeholder(when: userName.isEmpty) {
                                        Text("User Name").foregroundColor(Color(.white))
                                            .font(.custom("Montserrat-Regular", size: 20))
                                                                .fontWeight(.medium)
                                    }
                                    .padding(.leading, 25)
                                    .submitLabel(.done)
                                TextField("", text: $userEmail)
                                    .placeholder(when: userEmail.isEmpty) {
                                        Text("Email").foregroundColor(Color(.white))
                                            .font(.custom("Montserrat-Regular", size: 20))
                                                                .fontWeight(.medium)
                                    }
                                    .padding(.leading, 25)
                                    .submitLabel(.done)
                                //email promp letting user know to type valid email
                                if userEmail != "" && !isEmailValid_Test(){
                                    
                                    Text(emailPrompt)
                                        .font(.body).italic().foregroundColor(.red)
                                        .padding(.leading, -80)
                                        .padding(.top, -25)
                                        .frame(height: 5)
                                      
                                }
                                //if email is alreqdy in use prompt
                                else if emailAlreadyInUse {
                                    Text("This email already exists")
                                        .font(.body).italic().foregroundColor(.red)
                                }
                                HStack{
                                    if isPWSecured {
                                        SecureField("", text: $userPassword)
                                            .placeholder(when: userPassword.isEmpty) {
                                                Text("Password").foregroundColor(Color(.white))
                                                    .font(.custom("Montserrat-Regular", size: 20))
                                                                        .fontWeight(.medium)
                                            }
                                            .submitLabel(.done)
                                    }
                                    else {
                                        TextField("", text: $userPassword)
                                            .placeholder(when: userPassword.isEmpty) {
                                                Text("Password").foregroundColor(Color(.white))
                                                    .font(.custom("Montserrat-Regular", size: 20))
                                                                        .fontWeight(.medium)
                                            }
                                            .submitLabel(.done)
                                    }
                                    Button(action: {
                                        isPWSecured.toggle()
                                    }){
                                        Image(systemName: self.isPWSecured ? "eye.slash" : "eye")
                                            .accentColor(.white)
                                    }
                                    .padding(.leading, -115)
                                }
                                .padding(.leading, 25)
                                if userPassword != "" && !isPasswordValid(){
                                   Text(passwordPrompt)
                                       .font(.body).italic().foregroundColor(.red)
                                       .frame(width:300)
                                       .padding(.leading, -80)
                                       .fixedSize(horizontal: false, vertical: true)
                                  
                               }
                            }
                
                            .padding(.leading, 50)
                                    .listRowBackground(Color.clear)
                                    .padding()
                                    .font(.system(size:18))
                                  
                                        Button("Create Account"){
                                            Auth.auth().createUser(withEmail: userEmail, password: userPassword ) { user, error in
                                               if let x = error {
                                                  let err = x as NSError
                                                   switch err.code {
                                                   case AuthErrorCode.invalidEmail.rawValue:
                                                       print("invalid email")
                                                       
                                                   case AuthErrorCode.emailAlreadyInUse.rawValue:
                                                       emailAlreadyInUse = true
                                                       print("Email already is use, please use a new email or sign in")
                                                       
                                                   default:
                                                       print("Uknown error: \(err.localizedDescription)")
                                                   }
                                                   //return
                                               } else {
                                                   emailAlreadyInUse = false
                                                  //continue to app
                                                   dismiss()
                                                   showFitnessForm = true
                                               }
                                            }}
                        
                                            .frame(width: 200, height: 50)
                                           
                                            .foregroundColor(colorScheme == .dark ? .black : .white)
                                            .background(Color("ButtonTwo"))
                                            .font(.title3)
                                            .background(.clear)
                                            .cornerRadius(5)
                                            .padding(.top, 100)
                                            .opacity(isSignUpComplete ? 1 : 0.5)
                                           // .offset(y: keyboardResponder.currentHeight)
                                            .disabled(!isSignUpComplete)
                        
                                            .fullScreenCover(isPresented: $showFitnessForm){
                                                FitnessForm(
                                                    fullName: $fullName,
                                                   name: $userName,
                                                   userEmailAddress: $userEmail,
                                                   userLoginPassword: $userPassword)
                                                    .transition(transition)
                                                    
                                            }
                                          //  .animation(Animation.easeInOut(duration: 0.30), value: showFitnessForm)
                                            
                                    HStack{
                                        Text("Already a user?").italic().font(.callout)
                                      
                                        Button(action: {
                                            viewState = .login
                                        }){
                                            Text("Login")
                                                .foregroundColor(Color("ButtonTwo"))
                                                .font(.custom("Montserrat-Regular", size: 18))
                                        }
                                    }
                                    
                        .offset(y:20) // << adds separation from continue button
                      //  .offset(y: keyboardResponder.currentHeight)
                       
                case .login:
                    VStack{
                        userLogin(signUpController: signUpController)
                        //    .transition(.slide)
                    }
                
              
                }
        
    
    }
}

struct createUserAccount_Previews: PreviewProvider {
    static var previews: some View {
        createUserAccount()
    }
}

