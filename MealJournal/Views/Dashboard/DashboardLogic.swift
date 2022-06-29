//
//  File.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/1/22.
//

import Foundation
import SwiftUI

class DashboardLogic: ObservableObject {
    @Published var userModel: UserModel?
    @Published var privateUserModel: privateUserModel?
    
    init(){
        fetchCurrentUser()
    }

    private func fetchCurrentUser () {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        guard let email = FirebaseManager.shared.auth.currentUser?.email else {
            print("could not locate email")
            return
        }
        
        FirebaseManager.shared.firestore
            .collection("users").document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    print ("failed to fetch user \(error)")
                    return
                }
            
            guard let data = snapshot?.data() else {
                print ("no data found for user")
                return
            }
                DispatchQueue.main.async {
                    self.userModel = .init(data: data)
                }
                
        }
        //save to private database
        FirebaseManager.shared.firestore
            .collection("users").document(uid)
            .collection("privateUserInfo")
            .document("private")
            .getDocument { snapshot, error in
                if let error = error {
                    print("oh no we messed up")
                    return
                }
                //save snapshot of database from firestore
                guard let userEmail = snapshot?.data() else {
                    return
                }
                
                DispatchQueue.main.async{
                    self.privateUserModel = .init(data:userEmail)
                }
                
            }
        
    }
}

