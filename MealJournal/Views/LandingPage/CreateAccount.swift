//create user account
import SwiftUI
import UIKit
import CoreData

struct createUserAccount: View {
    //Stores form info as userInfo, stored in userModel
    @ObservedObject var userInformation = FormViewModel()
    @ObservedObject var keyboardResponder = KeyboardResponder()
    @State private var showFitnessForm = false

    @Environment (\.managedObjectContext) var moc //calls managed Object context (datacore)
    @Environment (\.dismiss) var dismiss
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
  
    var body: some View {
      
            ZStack{
                Form{
                    Section(){
                        TextField("FirstName", text: $userInformation.firstname)
                        TextField("LastName", text: $userInformation.lastname)
                        TextField("Email", text: $userInformation.email)
                            if userInformation.emailPrompt != "" {
                                Text(userInformation.emailPrompt)
                                    .font(.caption).italic().foregroundColor(.red)
                            }
                        SecureField("Passsword", text: $userInformation.password
                                    ).autocapitalization(.none)
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
                                    let newUser = User(context: moc)
                                    newUser.id = UUID()
                                    newUser.firstName = userInformation.firstname
                                    newUser.lastName = userInformation.lastname
                                    newUser.email = userInformation.email
                                    newUser.password = userInformation.password
                                    showFitnessForm.toggle()
                                    dismiss()
                                }
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
                
                                    .fullScreenCover(isPresented: $showFitnessForm){
                                        FitnessForm(
                                            userFirstName: $userInformation.firstname,
                                            userLastName: $userInformation.lastname,
                                            userEmailAddress: $userInformation.email,
                                            userLoginPassword: $userInformation.password
                                        )
                                            .ignoresSafeArea(.all)
                                    }
              
                           
                            HStack{
                                Text("Already a User?").italic().font(.callout)
                                NavigationLink(destination: userLogin() .navigationBarHidden(true)){
                                    Text("Login")
                                        .foregroundColor(.pink).font(.callout)
                                }
                            }
                .offset(y:80)
                .offset(y: keyboardResponder.currentHeight*2)
               
            }
            
       
    }
}
struct createUserAccount_Previews: PreviewProvider {
    static var previews: some View {
        createUserAccount()
    }
}

