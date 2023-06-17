//
//  UserJournalHelper.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/30/22.
//

import Foundation
import SwiftUI
import CoreData

class UserJournalHelper: ObservableObject {
    @ObservedObject var calendarHelper = CalendarHelper()
    
   
    //prepare data model
     static var persistentContainer: NSPersistentContainer = {
              let container = NSPersistentContainer(name: "JournalEntryModel")
              container.loadPersistentStores { description, error in
                  if let error = error {
                       fatalError("Unable to load persistent stores: \(error)")
                  }
              }
              return container
          }()
 
    func checkIfDateExistsInFirestore(uid: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())

        FirebaseManager.shared.firestore.collection("users").document(uid).collection("userJournals").document(currentDate).getDocument { (snapshot, error) in
            if let error = error {
                print("Error getting document: \(error)")
                return
            }
            if snapshot?.exists == true {
                print("Current date exists in Firestore document")
            } else {
                print("Current date does not exist in Firestore document")
            }
        }
    }
    
    
    
    
    //save feature
    func coreDataSave (context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Yes Saved")
        }
        catch {
            print("Darn this didn't save")
        }
    }
    //actual save function
    func saveJournalEntry (entryBrand: String, entryName: String, mealTiming: String, dayOfWeekCreated: String ,context: NSManagedObjectContext, entryCalories: Int16, entryProtein: Int16, entryFat: Int16, entryCarbs: Int16, totalCalories: String) {
        let entry = JournalEntry(context: context)
        entry.date = Date()
        //TTL - time until journal entry is removed (unless saved by user)
        entry.timeToLive = calendarHelper.timeToLiveDate(entryCreatedAt: Date())
        entry.id = UUID()
        entry.mealBrand = entryBrand
        entry.entryName = entryName
        entry.mealTiming = mealTiming
        entry.createdDate = calendarHelper.currentDate()
        entry.dayOfWeekCreated = dayOfWeekCreated
        entry.entrySaved = false
        entry.mealCalories = entryCalories
        entry.mealProtein = entryProtein
        entry.mealFat = entryFat
        entry.mealCarbs = entryCarbs
        
        coreDataSave(context: context)
    }
    
    
    
   func deleteJournalEntry(entry: JournalEntry, context: NSManagedObjectContext){
       context.delete(entry)
       do{
           try context.save()
       }
       catch{
           print(error.localizedDescription)
       }
    }
   
    func saveEntryToFirestore(
        mealName:   String,
        mealFat:    Int16,
        mealCarbs:  Int16,
        mealProtein: Int16,
        mealCalories: Int16,
        mealSaved: Bool,
        mealServing: Int,
        mealTiming: String,
        dayOfWeek: String,
        dateCreated: String,
        totalCalories: String,
        totalProtein: String,
        totalCarbs: String,
        totalFat: String
    ){
        //core data date returns format month -- day -- year with hashes like so
        //05-01-2022
        //firestore doesn't accept these hyphens, removing them here
        let dateString = String(dateCreated)
        let dateStringDashesRemoved = dateString.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
        //Need to now reverse day and month dates
        let day = dateStringDashesRemoved.prefix(2)
        
        let monthStart = dateStringDashesRemoved.index(dateStringDashesRemoved.startIndex, offsetBy: 2)
        let monthEnd = dateStringDashesRemoved.index(monthStart, offsetBy: 2)
        let month = dateStringDashesRemoved[monthStart..<monthEnd]
       
        let yearStart = dateStringDashesRemoved.index(dateStringDashesRemoved.startIndex, offsetBy: 4)
        let yearEnd = dateStringDashesRemoved.index(yearStart, offsetBy: 4)
        let year = dateStringDashesRemoved[yearStart..<yearEnd]
       //after all individually grabbed, flip date
        let fireStoreDocName = String(month + day + year)
        
       
        //grab user ID
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
      
        
        let journalEntryInfo = [
            "mealName" : mealName,
            "mealFat" : Int(mealFat),
            "mealCarbs" : Int(mealCarbs),
            "mealProtein" : Int(mealProtein),
            "mealCalories" : Int(mealCalories),
            "timeCreated" : 0,
            "saved" : mealSaved,
            "mealTiming": mealTiming,
            "mealServings" : mealServing,
            "dayOfWeek" : dayOfWeek,
            "dateCreated" : dateCreated
            
        ] as [String : Any]
        
        let additionalEntryInfo = [
            "totalCalories" : totalCalories,
            "totalProtein" : totalProtein,
            "totalCarbs" : totalCarbs,
            "totalFat" : totalFat
        ]

        FirebaseManager.shared.firestore.collection("users")
            .document(uid)
            .collection("userJournalEntrys")
            .document(fireStoreDocName)
            .collection("items")
            .document(UUID().uuidString)
            .setData(journalEntryInfo, merge: true) { err in
                if let err = err {
                    print(err)
                    return
                }
            }
        
        FirebaseManager.shared.firestore.collection("users")
            .document(uid)
            .collection("userJournalEntrys")
            .document(fireStoreDocName)
            .setData(
                additionalEntryInfo, merge: true )
        }
        
    
    func fetchJournalEntrys (mealName: String, mealFat: String, mealCalories: Int ,mealProtein: Int, mealServing: Int, mealCarbs: Int,  timeCreated: Int, entrySaved: String){
        //grab user id
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userJournals")
            .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            FirebaseManager.shared.firestore
                                .collection("users")
                                .document(uid)
                                .collection("userJournals")
                                .document(document.documentID)
                                .updateData([
                                    "mealName" : mealName,
                                    "mealFat" : mealFat,
                                    "mealCarbs" : mealCarbs,
                                    "mealProtein" : mealProtein,
                                    "mealCalories" : mealCalories,
                                    "timeCreated" : timeCreated,
                                    "saved" : entrySaved,
                                    "mealServings" : mealServing,
                                ]
                                )
                                    
                            print("Updated macros Recipe")
                        }
                    }
                }
            }
}
