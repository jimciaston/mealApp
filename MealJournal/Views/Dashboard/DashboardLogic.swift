//
//  File.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/1/22.
//

import Foundation

class DashboardLogic: ObservableObject {
    @Published var userModel: UserModel?
    
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
            
            self.userModel = .init(data: data)
            
        }
    }
}

