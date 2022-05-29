//
//  SignUpController.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/23/22.
//

import Foundation
import Firebase
import SwiftUI

class SignUpController: ObservableObject  {
    @Published var userIsLoggedIn = false
    @AppStorage("signedIn") var signedIn = false
    
    //create new user account
    func createNewUserAccount(userEmail: String, userPassword: String) {
        Auth.auth().createUser(withEmail: userEmail, password: userPassword){ result, err in
            if let err = err {
                print("Failed to Create User " , err)
                self.userIsLoggedIn = false
                return
            }
            print("Succesfully created user: \(result?.user.uid ?? "")")
            self.userIsLoggedIn = true
            self.signedIn = true //appStorage
        }
    }
    
    //log in user
    
    func loginUser ( userEmail: String, userPassword: String ) {
        Auth.auth().signIn(withEmail:userEmail, password: userPassword ){
            result, err in
            if let err = err {
                print("Failed to login", err)
                return
            }
            
            self.userIsLoggedIn = true
            self.signedIn = true
            print(self.userIsLoggedIn)
        }
    }
    
    //log out user
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            print("userSignedOut")
            self.signedIn = false
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
