//
//  File.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/1/22.
//

import Foundation

class DashboardLogic: ObservableObject {
   @Published var firstName = ""
    
    init(){
        fetchCurrentUser()
    }

    private func fetchCurrentUser () {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print ("Could not find UID")
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print ("failed to fetch user \(error)")
                return
            }
            
            guard let data = snapshot?.data() else {
                print ("no data found for user")
                return
            }
            
            self.firstName = data["firstName"] as? String ?? "def"
        }
    }
}

