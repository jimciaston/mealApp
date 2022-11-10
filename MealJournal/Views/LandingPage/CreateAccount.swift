//create user account
import SwiftUI
import UIKit
import CoreData
import Firebase

// enum for create account page
enum CreateAccountViewState {
    case createAccount // << stay on page
    case login // << proceed to login page
}

struct createUserAccount: View {
    
    //transition for fitness form
    let transition: AnyTransition = .asymmetric(insertion: .move(edge:.trailing), removal: .move(edge: .leading))
    //Stores form info as userInfo, stored in userModel
    @ObservedObject var userInformation = FormViewModel()
    //moves up stuff in view if keyboard is out
    @ObservedObject var keyboardResponder = KeyboardResponder()
    //calls signUpController
    @StateObject var signUpController = SignUpController()
   
    
    @State private var showFitnessForm = false
    @State private var emailAlreadyInUse = false // << email in use logic
    
    @Environment (\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) var allUsers: FetchedResults <User> // grab all users
    
    @State private var viewState: CreateAccountViewState = .createAccount //viewState of page
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    @State private var isPWSecured = true
    
    //for anim
    @State private var offset: CGFloat = 1.0
    var body: some View {
        
    switch viewState{
        case .createAccount:
            ZStack{
                Form{
                    Section(){
                        TextField("Name", text: $userInformation.name)
                            .padding(.leading, 20)
                        TextField("Email", text: $userInformation.email)
                            .padding(.leading, 20)
                        //email promp letting user know to type valid email
                            if userInformation.emailPrompt != "" {
                                Text(userInformation.emailPrompt)
                                    .font(.caption).italic().foregroundColor(.red)
                            }
                        //if email is alreqdy in use prompt
                        else if emailAlreadyInUse {
                            Text("This email already exists")
                                .font(.caption).italic().foregroundColor(.red)
                        }
                        HStack{
                            if isPWSecured {
                                SecureField("Password", text: $userInformation.password)
                                    .padding(.leading, 20)
                            }
                            else {
                                TextField("Password", text: $userInformation.password)
                                    .padding(.leading, 20)
                            }
                            Button(action: {
                                isPWSecured.toggle()
                            }){
                                Image(systemName: self.isPWSecured ? "eye.slash" : "eye")
                            .accentColor(.gray)
                            .padding(.trailing, 10)
                            }
                            
                        }
                        if userInformation.passwordPrompt != "" {
                           Text(userInformation.passwordPrompt)
                               .font(.caption).italic().foregroundColor(.red)
                       }
                    }
                            .listRowBackground(Color.clear)
                            .padding()
                            .navigationBarTitle(Text("Lets Get Started"))
                            .navigationBarTitleDisplayMode(.automatic)
                            .font(.system(size:18))
                            .listStyle(GroupedListStyle())
                           
                        }
                                Button("Continue"){
                                    Auth.auth().createUser(withEmail: userInformation.email, password: userInformation.password ) { user, error in
                                       if let x = error {
                                          let err = x as NSError
                                           switch err.code {
                                           case AuthErrorCode.invalidEmail.rawValue:
                                               print("invalid email")
                                               
                                           case AuthErrorCode.emailAlreadyInUse.rawValue:
                                               emailAlreadyInUse = true
                                               print("Email already is use")
                                               
                                           default:
                                               print("Uknown error: \(err.localizedDescription)")
                                           }
                                           //return
                                       } else {
                                          //continue to app
                                           dismiss()
                                           showFitnessForm = true
                                       }
                                    }}
                
                                    .frame(width: 150, height: 30)
                                    //.padding(.top, 20)
                                    .foregroundColor(.white)
                                //    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .leading, endPoint: .bottom))
                                    .font(.title3)
                                    .background(.clear)
                                    .cornerRadius(5)
                                    .padding(.top, 150)
                                    .opacity(userInformation.isSignUpComplete ? 1 : 0.5)
                                    .offset(y: keyboardResponder.currentHeight*2)
                                    .disabled(!userInformation.isSignUpComplete)
                                   
                
                                    .fullScreenCover(isPresented: $showFitnessForm){
                                        FitnessForm(
                                           name: $userInformation.name,
                                           userEmailAddress: $userInformation.email,
                                           userLoginPassword: $userInformation.password)
                                            .transition(transition)
                                            
                                    }
                                    .animation(Animation.easeInOut(duration: 0.30), value: showFitnessForm)
                                    
                            HStack{
                                Text("Already a User?").italic().font(.callout)
                                Button(action: {
                                    viewState = .login
                                }){
                                    Text("Login")
                                        .foregroundColor(.pink).font(.callout)
                                }
                            }
                            
                .offset(y:120) // << adds separation from continue button
                .offset(y: keyboardResponder.currentHeight * 2)
               
            }
            
        case .login:
            VStack{
                userLogin(signUpController: signUpController)
                    .transition(.slide)
            }
            .animation(.linear(duration: 0.25), value: viewState)
      
           
        }
           
        
    }
}

struct createUserAccount_Previews: PreviewProvider {
    static var previews: some View {
        createUserAccount()
    }
}

