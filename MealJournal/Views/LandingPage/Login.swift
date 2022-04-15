//
//  Login.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/8/22.
//

import SwiftUI

struct userLogin: View {
    
  @State private var show = false //can delete after done testing
    @State var userEmail: String = "";
    @State var userPassword: String = "";
   
    @ObservedObject var keyboardResponder = KeyboardResponder()
    var body: some View {
       
            VStack{
                Text("Sign In")
                    .font(.title)
                    .fontWeight(.medium)
                HStack{
                    Image(systemName: "lock")
                        .padding(15)
                        .foregroundColor(.orange)
                    TextField("Email", text: $userEmail)
                        .font(.title2)
                        .frame(width:200, height:50)
                    }
                    .overlay( RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray, lineWidth: 3))
                    .offset(y:15)
                    .padding(.bottom, 20)
                VStack{
                    HStack{
                        Image(systemName: "lock")
                            .padding(15)
                            .foregroundColor(.orange)
                        TextField("Password", text: $userPassword)
                        .font(.title2)
                        .frame(width:200, height:50)
                    } .overlay( RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray, lineWidth: 3)
                            )
                    .offset(y:15)
                    .onTapGesture{
                        hide_UserKeyboard()
                    }
                    NavigationLink(destination: JournalEntryMain() .navigationBarHidden(true)){
                        Text("Forgot Password?").font(.subheadline).italic()
                    }
                    .foregroundColor(.gray)
                    .padding(.leading, 100)
                    .offset(y:20)
                    }
                
                NavigationLink (destination: UserDashController().navigationBarHidden(true)){
                    Text("Login").font(.title2)
                }
                    .foregroundColor(.black)
                    .frame(width:250, height:50)
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(LinearGradient(
                            colors: [.orange, .yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                    )
               
                .offset(y:50)
            }
            .offset(y:-100)
            .offset(y: keyboardResponder.currentHeight/20)
        }
       
       
        
    }
    


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        userLogin()
    }
}
    
