//
//  DeleteAccountLogic.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/11/22.
//

import Foundation
import Firebase
import SwiftUI

class DeleteAccountLogic: ObservableObject{
    
   
    //@AppStorage("signedIn") var signedIn: Bool = true
    func deleteAccount(deleteSuccess: Bool){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        //grab currentUser
        let user = Auth.auth().currentUser
        //delete from private storage
        FirebaseManager.shared.firestore
            .collection("users").document(uid).collection("privateUserInfo").document("private").delete() { err in
                if let err = err {
                    print("error deleting user")
                }else{
                    return
                }
            }
        //delete public doc information
        FirebaseManager.shared.firestore
            .collection("users").document(uid).delete() { err in
                if let err = err {
                    print("error deleting user")
                }else{
                    //delete user auth (email and password)
                    user?.delete { error in
                      if let error = error {
                       print(error)
                      } else {
                          var deleteSuccess = deleteSuccess
                          deleteSuccess = false
                          
                      }
                    }
                }
            }
        
    }
}
