//
//  UserModel.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/10/22.
//

import SwiftUI
import CoreData

final class FormViewModel: ObservableObject {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var allUsers: FetchedResults <User>
    
    @Published var name = ""
    @Published var email = ""
    @Published var gender = ""
    @Published var password = ""
   // @Published var isValid = false
    
    

    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES%@", "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
        return passwordTest.evaluate(with: password)
    }
    func isEmailValid() -> Bool {
        var isValid = false
        let emailTest = NSPredicate(format: "SELF MATCHES%@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }

    var emailPrompt: String {
        if isEmailValid() || email == "" {
            return ""
        } else {
            return "*Please enter a valid email address"
        }
        
    }
    
    var passwordPrompt: String {
        if isPasswordValid() || password == ""{
            return ""
        } else {
            return "*Password must be 8-15 letters, with atleast one uppercase and one number"
        }
    }
    
    var isSignUpComplete: Bool {
        if !isPasswordValid() || !isEmailValid() || name == "" {
            return false
        }
        return true
    }
    
    
}





