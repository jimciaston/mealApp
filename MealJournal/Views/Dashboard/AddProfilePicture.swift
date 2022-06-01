//
//  ProfilePictureController.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/30/22.
//

import Foundation
import FirebaseStorage
import Firebase
import SwiftUI

//class addProfilePicture {
//    private func persistImageToStorage(userProfileImage: Image) {
//        
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
//            else { return }
//        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
//        guard let imageData = self.image?.jpegData(compressionQuality: 0.5)
//            else { return}
//        ref.putData(imageData, metadata: nil){ metadata, err in
//            if let err = err {
//                self.loginStatusMessage =  "failed to save image"
//                return
//            }
//            
//            self.loginStatusMessage = "success stored image"
//        }
//        
//    }
//    
//    
//    
//    
//}
