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

class LandingPageViewModel: ObservableObject  {
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
        }
    }
    
    //log out user
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            self.signedIn = false
            UserDefaults.standard.set(false, forKey: "signedIn")
            self.userIsLoggedIn = false
        }
        
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    static func storeUserInfomation(
        uid:            String,
        email:          String,
        name:           String,
        height:         String,
        weight:         String,
        gender:         String,
        agenda:         String,
        dateJoined:     String,
        exercisePreferences: [String],
        healthSettingsPrivate:  String // << if weight and height are public
    ){
        //grab user ID
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let publicUserData = [
            "uid" :             uid,
            "name":             name,
            "height":           height,
            "weight":           weight,
            "gender":           gender,
            "agenda" :          agenda ,
            "dateJoined":       dateJoined,
            "exercisePreferences":   exercisePreferences,
            "healthSettingsPrivate": healthSettingsPrivate
            
        
        ] as [String : Any]
            
        
        let privateUserData = [
            "email" : email ] as [String: Any]
        
        
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(publicUserData) { err in
                if let err = err {
                    print(err)
                    return
                }
            }
        
        //save to private storage in firestore
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).collection("privateUserInfo").document("private").setData(privateUserData)
        
    }
    
    
    
}
