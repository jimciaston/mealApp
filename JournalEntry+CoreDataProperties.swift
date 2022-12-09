//
//  JournalEntry+CoreDataProperties.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/7/22.
//
//

import Foundation
import CoreData


extension JournalEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }

    @NSManaged public var entryName: String?
    @NSManaged public var mealTiming: String?
    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var createdDate: String?
    @NSManaged public var entrySaved: Bool
    @NSManaged public var dayOfWeekCreated: String?
    @NSManaged public var timeToLive: String?

}

extension JournalEntry : Identifiable {

}
