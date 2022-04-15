//
//  DataController.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/8/22.
//

import SwiftUI
import CoreData
import Foundation
//controls coreData
class DataController: ObservableObject {
    static let container = NSPersistentContainer(name: "UserData")
    
    init(){
        DataController.container.loadPersistentStores { description, error in
               if let error = error {
                   print("Core Data failed to load: \(error.localizedDescription)")
               }
           }
            
        }
    }
    

