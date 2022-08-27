//
//  File.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/1/22.
//

import Foundation
import SwiftUI

class DashboardLogic: ObservableObject, Identifiable {
    @Published var userModel: UserModel?
    @Published var privateUserModel: privateUserModel?
    @Published var isUserDataLoading = true
    @Published var allUsers = [UserModel]() //<< all users appended
    //grab users
    init(){
        self.fetchCurrentUser()
        self.grabAllUsers()
    }
    func grabAllUsers(){
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { documentSnapshot, error in
               if let error = error {
                   print("Error no users were returned")
                   return
               }
               documentSnapshot?.documents.forEach({ snapshot in
                   let data = snapshot.data()
                   let user = UserModel(data: data)

                   if user.uid != FirebaseManager.shared.auth.currentUser?.uid { // << if current user, don't show in search results
                       self.allUsers.append(.init(data: data)) // <<save users to array
                      
                   }
               })
           }
        }
     
    
    func fetchCurrentUser () {
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
                    self.isUserDataLoading = false
                }
                
        }
        //save to private database
        FirebaseManager.shared.firestore
            .collection("users").document(uid)
            .collection("privateUserInfo")
            .document("private")
            .getDocument { snapshot, error in
                if let error = error {
                    print("Unable to grab from database")
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

