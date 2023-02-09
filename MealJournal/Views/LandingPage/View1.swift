//
//  View1.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/6/23.
//

import SwiftUI

enum CreateAccountViewState_Test {
    case createAccount_TEST // << stay on page
    case login_TEST // << proceed to login page
}
enum LoginEnum_Test{
    case loginPage
    case createAccount // <<will be forgot passwrod once ready to setup
}
struct View1: View {
    @State private var viewState: CreateAccountViewState_Test = .createAccount_TEST //viewState of page
    @State var name = ""
    var body: some View {
        switch viewState{
        case .createAccount_TEST:
            Section(){
                TextField("Name", text: $name)
                    .padding(.leading, 50)
                
            }
            Button(action: {
                viewState = .login_TEST
            }){
                Text("Login")
                    .foregroundColor(.pink).font(.callout)
            }
        case .login_TEST:
            VStack{
                View2()
                    .transition(.slide)
            }
            .animation(.linear(duration: 0.25), value: viewState)
            
        }
    }
}
struct View2: View {
    @State private var loginPageViewState: LoginEnum_Test = .loginPage
    var body: some View {
        switch loginPageViewState {
        case .loginPage:
            Text("Hello")
            Button(action: {
                loginPageViewState = .createAccount
            }){
                Text("click me to go back")
            }
        case .createAccount:
            View1()
        }
    }
}

struct View1_Previews: PreviewProvider {
    static var previews: some View {
        View1()
    }
}
