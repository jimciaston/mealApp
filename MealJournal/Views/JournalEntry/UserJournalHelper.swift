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
    let container = NSPersistentContainer(name: "JournalEntryModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print( "core data failed to load: \(error.localizedDescription)")
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
    func saveJournalEntry (entryName: String, mealTiming: String, dayOfWeekCreated: String ,context: NSManagedObjectContext, entryCalories: Int16, entryProtein: Int16, entryFat: Int16, entryCarbs: Int16, totalCalories: String) {
        let entry = JournalEntry(context: context)
        entry.date = Date()
        //TTL - time until journal entry is removed (unless saved by user)
        entry.timeToLive = calendarHelper.timeToLiveDate(entryCreatedAt: Date())
        entry.id = UUID()
        entry.entryName = entryName
        entry.mealTiming = mealTiming
        entry.createdDate = calendarHelper.currentDate()
        entry.dayOfWeekCreated = dayOfWeekCreated
        entry.entrySaved = false
        entry.mealCalories = Int16(entryCalories)
        entry.mealProtein = Int16(entryProtein)
        entry.mealFat = Int16(entryCarbs)
        entry.mealCarbs = Int16(entryFat)
        
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
   
    static func saveEntryToFirestore(
        mealName:   String,
        mealFat:    Int,
        mealCarbs:  Int,
        mealProtein: Int,
        mealCalories: Int,
        mealSaved: Bool,
        mealServing: Int,
        mealTiming: String,
        dayOfWeek: String,
        dateCreated: String,
        totalCalories: String
    ){
        let dateString = String(dateCreated)
        let dateStringDashesRemoved = dateString.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
       
        //grab user ID
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        let journalEntryInfo = [
            "mealName" : mealName,
            "mealFat" : mealFat,
            "mealCarbs" : mealCarbs,
            "mealProtein" : mealProtein,
            "mealCalories" : mealCalories,
            "timeCreated" : mealCarbs,
            "saved" : mealSaved,
            "mealTiming": mealTiming,
            "mealServings" : mealServing,
            "dayOfWeek" : dayOfWeek,
            "dateCreated" : dateCreated
            
        ] as [String : Any]
        
        let additionalEntryInfo = [
            "totalCalories" : totalCalories
        ]

        FirebaseManager.shared.firestore.collection("users")
            .document(uid)
            .collection("userJournalEntrys")
            .document(dateStringDashesRemoved)
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
            .document(dateStringDashesRemoved)
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
                                    "mealProtein" : mealCarbs,
                                    "mealCalories" : mealCarbs,
                                    "timeCreated" : mealCarbs,
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
