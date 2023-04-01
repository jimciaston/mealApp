//
//  GrabCurrentDate.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/28/22.
//

import Foundation
import SwiftUI

extension Date {
    var currentDay: Int {
           return Calendar.current.component(.weekday, from: self)
       }
}
enum Weekday: String, CaseIterable {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}
 func weekdayAsString(date: Int ) -> String {
    switch date {
        case 0:
            return "Sunday"
            
        case 1:
            return "Monday"
            
        case 2:
            return "Tuesday"
            
        case 3:
            return "Wednesday"
           
        case 4:
            return "Thursday"
           
        case 5:
            return "Friday"
           
        case 6:
            return "Saturday"
         
        default:
            return ""
    }
}

class CalendarHelper: ObservableObject {
    @Published private(set) var currentDay = Date().currentDay - 1
    @Published var dateHitMaxPrev = false
    var permDate = Date().currentDay
    var currentWeekday: Weekday {
          Weekday.allCases[currentDay]
      }
      
    
    func decrementDate(){
        if permDate != currentDay {
            if currentDay > 0{
                currentDay -= 1
            }
            else{
                currentDay = 6 // go back to Saturday
                
            }
        }
        
    }
    //lock date so can't go to a future date (no reason for user to do so)
    func incrementDate(){
        if permDate - 1 != currentDay {
            if currentDay < 6 {
                currentDay += 1
            }
            else{
                ///if saturday, go back to sunday
                dateHitMaxPrev = true
            }
        }
        
    }
    
    func test(entry1: Date, entry2: String){
        //date that entry is created
        let startDate = entry1
        //TTL of date (7 days from creation
        let endDateString = entry2

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"

        if let endDate = formatter.date(from: endDateString) {
            let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
            print(components.day!)
        } else {
            print("\(endDateString) can't be converted to a Date")
        }
         // This will return the number of day(s) between dates
    }
    
    //remove hourly time stamp from core data data field
    public func removeTimeStamp(cbDate: NSDate) -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
       //return when we should delete past journal entry
        var dateString = dateFormatter.string(from: cbDate as Date)
        print(dateString)
        return dateString
    }
    //grab current date, then TTL to 7 days
    func timeToLiveDate(entryCreatedAt: Date) -> String{
        let endDate = Calendar.current.date(byAdding: .day, value: +7, to: entryCreatedAt)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
       //return when we should delete past journal entry
        var dateString = dateFormatter.string(from: endDate! as Date)
        return dateString
    }
    //grab current date as string
    func currentDate() -> String {
        let date = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var dateString = dateFormatter.string(from: date as Date)
       //return when we should delete past journal entry
        return dateString
//
//        let date = Date()
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day], from: date)
////just leaving this here if we need year, time, and day
//        let year =  components.year
//        let month = components.month
//        let day = components.day
////format time
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//           let dateString = formatter.string(from: Date())
//        print(dateFormatterGet.dateFormat)
       // currentDay = Date().dayNumberOfWeek()!
        
    }
}
