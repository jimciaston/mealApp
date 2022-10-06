//
//  MealJournalApp.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/2/22.
//app delegate

import SwiftUI
import CoreData
import Foundation
import Firebase

//must keep for firebase to run
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct MealJournalApp: App {
   
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init(){
        FirebaseApp.configure()
    }
    @StateObject var mealEntrys = MealEntrys()
    @StateObject private var dataController = DataController()
    var body: some Scene {
        //load and ready coredata
        WindowGroup{
            ContentView()
                .environmentObject(mealEntrys)
                .environment(\.managedObjectContext, DataController.container.viewContext)
        }
    }
}
/*
 Client id : 8223cbe075c0470d8d4ac95313d18b86
 Client Secret: dac3b78ec3724ffbaff6addc8eab4c9b
 
 
 */
