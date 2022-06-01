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
            
            let uid = data["uid"] as? String ?? "Unavailable"
            let email = data["email"] as? String ?? "Unavailable"
            let firstName = data["firstName"] as? String ?? "Unavailable"
            let lastName = data["lastName"] as? String ?? "Unavailable"
            let gender = data["gender"] as? String ?? "Unavailable"
            let height = data["height"] as? String ?? "Unavailable"
            let weight = data["weight"] as? String ?? "Unavailable"
            let agenda = data["agenda"] as? String ?? "Unavailable"
            let profilePictureURL = data ["profilePicture"] as? String ?? "Unavailable"
            
            self.userModel = UserModel(uid: uid, email: email, firstName: firstName, lastName: lastName, gender: gender, height: height, weight: weight, agenda: agenda, profilePictureURL: profilePictureURL)
        }
    }
}

