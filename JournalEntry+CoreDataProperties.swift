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
    @NSManaged public var totalCalories: String?
    
    public var mealCalories: Int16?
    {
        get {
            self.willAccessValue(forKey: "mealCalories")
            let value = self.primitiveValue(forKey: "mealCalories") as? Int
            self.didAccessValue(forKey: "mealCalories")

            return (value != nil) ? Int16(value!) : nil
        }
        set {
            self.willChangeValue(forKey: "mealCalories")

            let value : Int? = (newValue != nil) ? Int(newValue!) : nil
            self.setPrimitiveValue(value, forKey: "mealCalories")

            self.didChangeValue(forKey: "mealCalories")
        }
    }
    public var mealCarbs: Int16?
    {
        get {
            self.willAccessValue(forKey: "mealCarbs")
            let value = self.primitiveValue(forKey: "mealCarbs") as? Int
            self.didAccessValue(forKey: "mealCarbs")

            return (value != nil) ? Int16(value!) : nil
        }
        set {
            self.willChangeValue(forKey: "mealCarbs")

            let value : Int? = (newValue != nil) ? Int(newValue!) : nil
            self.setPrimitiveValue(value, forKey: "mealCarbs")

            self.didChangeValue(forKey: "mealCarbs")
        }
    }
    public var mealProtein: Int16?
    {
        get {
            self.willAccessValue(forKey: "mealProtein")
            let value = self.primitiveValue(forKey: "mealProtein") as? Int
            self.didAccessValue(forKey: "mealProtein")

            return (value != nil) ? Int16(value!) : nil
        }
        set {
            self.willChangeValue(forKey: "mealProtein")

            let value : Int? = (newValue != nil) ? Int(newValue!) : nil
            self.setPrimitiveValue(value, forKey: "mealProtein")

            self.didChangeValue(forKey: "mealProtein")
        }
    }
    public var mealFat: Int16?
    {
        get {
            self.willAccessValue(forKey: "mealFat")
            let value = self.primitiveValue(forKey: "mealFat") as? Int
            self.didAccessValue(forKey: "mealFat")

            return (value != nil) ? Int16(value!) : nil
        }
        set {
            self.willChangeValue(forKey: "mealFat")

            let value : Int? = (newValue != nil) ? Int(newValue!) : nil
            self.setPrimitiveValue(value, forKey: "mealFat")

            self.didChangeValue(forKey: "mealFat")
        }
    }
}

extension JournalEntry : Identifiable {

}
