//
//  SignUpController.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/23/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

import SwiftUI

class SignUpController: ObservableObject  {
    @Published var userIsLoggedIn = false
    @Published var failedMessage = ""
    @AppStorage("signedIn") var signedIn = false
    
    //create new user account
    func createNewUserAccount(userEmail: String, userPassword: String) {
        FirebaseManager.shared.auth.createUser(withEmail: userEmail, password: userPassword){ result, err in
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
        FirebaseManager.shared.auth.signIn(withEmail:userEmail, password: userPassword ){
            result, err in
            if let err = err {
                print("Failed to login", err)
                self.failedMessage = "Email or password incorrect"
                return
            }
            
            self.userIsLoggedIn = true
            self.signedIn = true
            self.failedMessage = "" 
            print(self.userIsLoggedIn)
        }
    }
    
    //log out user
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            print("userSignedOut")
            self.signedIn = false
            self.userIsLoggedIn = false
        }
        
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    static func storeUserInfomation(
        email:          String,
        name:           String,
        height:         String,
        weight:         String,
        gender:         String,
        agenda:         String
    ){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = [
            "email" :           email,
            "name":             name,
            "height":           height,
            "weight":           weight,
            "gender":           gender,
            "agenda" :          agenda,
            "uid":              uid,
        
        ] as [String : Any]
        
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Account created in Database Successfully")
            }
        
    }
    
    
    
}
