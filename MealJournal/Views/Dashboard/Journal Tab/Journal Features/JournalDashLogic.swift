//
//  JournalDashLogic.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/8/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct UserJournalEntry: Hashable, Identifiable, Codable{
    let id: String
    var mealName: String
    var mealFat, mealCarbs, mealProtein, mealCalories, MealServing: Int
    var mealSaved: Bool
    var mealTiming: String
    var dayOfWeek: String
   // var totalCalories: String
    var dateCreated: String
}
struct UserJournalEntryHalf: Identifiable, Codable{
    var id: String?
    var journalID: String?
    var totalCalories: String?
    var totalProtein: String?
    var totalCarbs: String?
    var totalFat: String?
}


class JournalDashLogic: ObservableObject {
    @Published var userJournals = [UserJournalEntry]()
    @Published var userJournalCount: Int = 0
    @Published var userJournalIDs = [String]()
    @Published var userJournalsHalf = [UserJournalEntryHalf]()
    init(){
        grabUserJournalCount()
      
    }
    
    func grabUserJournalCount(){
        let docID = "" // << store in journalHalfStruct
        //grab current user
         guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
             return
         }
         FirebaseManager.shared.firestore
             .collection("users")
             .document(uid)
             .collection("userJournalEntrys")
             .addSnapshotListener { (snapshot, err) in
                 guard let documents = snapshot?.documents else{
                     print("no documents present")
                     return
                 }
                 self.userJournalCount = documents.count
                 self.userJournalIDs = documents.map { document in
                     document.documentID
                 }
                 //grab information half
                 self.userJournalsHalf = documents.map { document in
                     
                     let journalID = document.documentID
                     let totalCalories = document.get("totalCalories") as? String
                     let totalProtein = document.get("totalProtein") as? String
                     let totalCarbs = document.get("totalCarbs") as? String
                     let totalFat = document.get("totalFat") as? String
                     return UserJournalEntryHalf(id: journalID, totalCalories: totalCalories, totalProtein: totalProtein, totalCarbs: totalCarbs,totalFat: totalFat)
                 }
                 
             }
       
         }
   
    func grabUserJournalsHalf(journalID: String){
        //grab current user
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userJournalEntrys")
            .document(journalID)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    let totalCalories = document.get("totalCalories") as! String
                    let totalProtein = document.get("totalProtein") as! String
                    let totalCarbs = document.get("totalCarbs") as! String
                    let totalFat = document.get("totalFat") as! String
                } else {
                    print("Document does not exist")
                }
            }
    }
    
    func grabUserJournals(journalID: String){
        //grab current user
         guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
             return
         }
      
         FirebaseManager.shared.firestore
             .collection("users")
             .document(uid)
             .collection("userJournalEntrys")
             .document(journalID)
             .collection("items")
             .getDocuments { (snapshot, err) in
                 guard let documents = snapshot?.documents else{
                     print("no documents present")
                     return
                 }
                 
                 //map to journal entry struct
                     self.userJournals = documents.map { (querySnapshot) -> UserJournalEntry in
                     let data = querySnapshot.data()
                      
                         let id = data ["dateCreated"] as? String ?? ""
                         let dateCreated = data ["dateCreated"] as? String ?? ""
                         let dayOfWeek = data ["dayOfWeek"] as? String ?? ""
                         let mealCalories = data ["mealCalories"] as? Int ?? 0
                         let mealCarbs = data ["mealCarbs"] as? Int ?? 0
                         let mealFat = data ["mealFat"] as? Int ?? 0
                         let mealName = data ["mealName"] as? String ?? ""
                         let mealProtein = data ["mealProtein"] as? Int ?? 0
                         let MealServing = data ["MealServing"] as? Int ?? 0
                         let mealSaved = data ["saved"] as? Bool ?? false
                         let mealTiming = data ["mealTiming"] as? String ?? ""
                    
                         let entry = UserJournalEntry(id: id, mealName: mealName, mealFat: mealFat, mealCarbs: mealCarbs, mealProtein: mealProtein, mealCalories: mealCalories, MealServing: MealServing, mealSaved: mealSaved, mealTiming: mealTiming, dayOfWeek: dayOfWeek, dateCreated: dateCreated)
                  
                     return entry
                     
                 }
             }
         }
    //delete journal entry logic
    func deleteJournalEntry(journalID: String){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userJournalEntrys")
            .document(journalID)
            .delete() { err in
                   if let err = err {
                       print("Error removing document: \(err)")
                   } else {
                       print("Document successfully removed!")
                   }
            }
        }
}

//grab id of journal entrys

