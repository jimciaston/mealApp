//
//  ReminderLogic.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/8/23.
//

import Foundation
import SwiftUI


class ReminderLogic: ObservableObject {
    // Function to calculate the next trigger date for a notification
    func calculateNextTriggerDate(_ trigger: UNNotificationTrigger) -> Date? {
        let now = Date()
        let calendar = Calendar.current

        if let calendarTrigger = trigger as? UNCalendarNotificationTrigger {
            let dateComponents = calendarTrigger.dateComponents

            if calendarTrigger.repeats {
                // Calculate the next occurrence after the current date
                let nextTriggerDate = calendar.nextDate(after: now, matching: dateComponents, matchingPolicy: .nextTime)

                return nextTriggerDate
            } else {
                // Non-repeating trigger, return the scheduled date if it's in the future
                if let scheduledDate = calendarTrigger.nextTriggerDate(), scheduledDate > now {
                    return scheduledDate
                }
            }
        }

        return nil
    }
  

  func formatNotificationDayOfWeeks(trigger: UNNotificationTrigger) -> [String] {
      var daysOfWeek: [String] = []

      if let calendarTrigger = trigger as? UNCalendarNotificationTrigger {
          let date = calendarTrigger.nextTriggerDate()  // Get the next trigger date
          let formatter = DateFormatter()
          formatter.dateFormat = "EEEE"
          
          if let formattedDate = date {
              daysOfWeek.append(formatter.string(from: formattedDate))
          }
      }
      
      // If no days are found, return "Unknown Day"
      if daysOfWeek.isEmpty {
          return ["Unknown Day"]
      }
      
      return daysOfWeek
  }


  func formatNotificationTime(trigger: UNNotificationTrigger) -> String {
      if let calendarTrigger = trigger as? UNCalendarNotificationTrigger {
          let dateComponents = calendarTrigger.dateComponents
          if let hour = dateComponents.hour, let minute = dateComponents.minute {
              let formatter = DateFormatter()
              formatter.timeStyle = .short
              return formatter.string(from: Calendar.current.date(from: dateComponents)!)
          }
      }
    
      return "Unknown Time"
  }
  

  
  func getAllScheduledNotifications(completion: @escaping ([UNNotificationRequest]?) -> Void) {
      let center = UNUserNotificationCenter.current()

      center.getPendingNotificationRequests { (requests) in
          completion(requests)
      }
  }
}

