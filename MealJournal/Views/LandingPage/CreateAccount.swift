//create user account
import SwiftUI
import UIKit
import CoreData
import Firebase

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
    @State private var emailAlreadyInUse = false
    @Environment (\.managedObjectContext) var moc //calls managed Object context (datacore)
    @Environment (\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) var allUsers: FetchedResults <User>
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    @State private var isPWSecured = true
    
    //for anim
    @State private var offset: CGFloat = 1.0
    var body: some View {
            ZStack{
                Form{
                    Section(){
                        TextField("FirstName", text: $userInformation.firstname)
                        TextField("LastName", text: $userInformation.lastname)
                        TextField("Email", text: $userInformation.email)
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
                              
                            }
                            else {
                                TextField("password", text: $userInformation.password)
                               
                            }
                            Button(action: {
                                isPWSecured.toggle()
                            }){
                                Image(systemName: self.isPWSecured ? "eye.slash" : "eye")
                                                    .accentColor(.gray)
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
//                                    let newUser = User(context: moc)
//                                    newUser.id = UUID()
//                                    newUser.firstName = userInformation.firstname
//                                    newUser.lastName = userInformation.lastname
//                                    newUser.email = userInformation.email
//                                    newUser.password = userInformation.password
                                    
                                    //authenticate user email
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
                                           showFitnessForm.toggle()
                                       }
                                    }}
                
                                    .frame(width: 150, height: 20)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .leading, endPoint: .bottom))
                                    .font(.title3)
                                    .background(.clear)
                                    .cornerRadius(5)
                                    .offset(y:30)
                                    .opacity(userInformation.isSignUpComplete ? 1 : 0.5)
                                    .offset(y: keyboardResponder.currentHeight*2)
                                    .disabled(!userInformation.isSignUpComplete)
                                    .frame(height: 300)
                
                                    .fullScreenCover(isPresented: $showFitnessForm){
                                        FitnessForm(
                                           userFirstName: $userInformation.firstname,
                                           userLastName: $userInformation.lastname,
                                           userEmailAddress: $userInformation.email,
                                           userLoginPassword: $userInformation.password
                                           )  .transition(transition)
                                            
                                    }
                                    .animation(Animation.easeInOut(duration: 0.30), value: showFitnessForm)
                
                            HStack{
                                Text("Already a User?").italic().font(.callout)
                                NavigationLink(destination: userLogin(signUpController: signUpController) .navigationBarHidden(true)){
                                    Text("Login")
                                        .foregroundColor(.pink).font(.callout)
                                }
                            }
                .offset(y:80)
                .offset(y: keyboardResponder.currentHeight*2)
               
            }
        //display fitnessform
//            .overlay(
//                VStack{
//                    .fullScreenCover(isPresented: $test){
//                        UserDashboardView()
//                    }
//                    if showFitnessForm{
//                        UserDashboardView()
////                        FitnessForm(
////                        userFirstName: $userInformation.firstname,
////                        userLastName: $userInformation.lastname,
////                        userEmailAddress: $userInformation.email,
////                        userLoginPassword: $userInformation.password
////                        )
//                            .transition(transition)
//                    }
//                }
//                    .animation(Animation.easeInOut(duration: 0.30), value: showFitnessForm)
//            )
    }
}

struct createUserAccount_Previews: PreviewProvider {
    static var previews: some View {
        createUserAccount()
    }
}

