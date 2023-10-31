//
//  MealRemindersView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 8/25/23.
//

import SwiftUI
import UserNotifications



class NotificationManager: ObservableObject {
    @Published var notifications: [NotificationModel] = []
    
    // Add functions to add and remove notifications
    func addNotification(_ notification: NotificationModel) {
        DispatchQueue.main.async {
            self.notifications.append(notification)
        }
    }
    
    func removeNotification(withIdentifier identifier: String) {
        DispatchQueue.main.async {
            self.notifications.removeAll { $0.id == identifier }
        }
    }
}


extension Array where Element == NotificationModel {
    var uniqueByNotificationIdentifier: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(where: { $0.notificationIdentifier == item.notificationIdentifier }) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}

class NotificationModel: Identifiable, ObservableObject {
    @State var isToggled: Bool = true

    func toggleVisability() {
            isToggled.toggle()
        }
    let creationDate: Date
    let identifier: String
    let content: UNNotificationContent
    let trigger: UNNotificationTrigger
    let body: String
    var notificationIdentifier: String
    let savedDays: [String]

    init(creationDate: Date, identifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger, body: String, notificationIdentifier: String, savedDays: [String]) {
        self.creationDate = creationDate
        self.identifier = identifier
        self.content = content
        self.trigger = trigger
        self.body = body
        self.notificationIdentifier = notificationIdentifier
        self.savedDays = savedDays
    }
    var id: String {
            return identifier
        }
}




func processDaysOfWeek(_ daysOfWeek: [String]) -> String {
       let dayAbbreviations: [String: String] = [
           "Monday": "Mon",
           "Tuesday": "Tue",
           "Wednesday": "Wed",
           "Thursday": "Thu",
           "Friday": "Fri",
           "Saturday": "Sat",
           "Sunday": "Sun"
       ]

       // Create a dictionary to map day names to their indices
       let dayIndices: [String: Int] = {
           var indices = [String: Int]()
           for (index, day) in daysOfWeek.enumerated() {
               indices[day] = index
           }
           return indices
       }()

       // Sort the days of the week starting from Monday
       let sortedDays = daysOfWeek.sorted {
           let firstIndex = dayIndices[$0] ?? Int.max
           let secondIndex = dayIndices[$1] ?? Int.max
           return (firstIndex + 1) % 7 < (secondIndex + 1) % 7
       }

       // Abbreviate the days and join them with a separator
       let abbreviatedDays = sortedDays.map { dayAbbreviations[$0] ?? $0 }
       let result = abbreviatedDays.joined(separator: ", ")

       return result
   }



struct MealRemindersView: View {
    @StateObject private var notificationManager = NotificationManager()
    @StateObject var reminderLogic = ReminderLogic()
   // @State private var notifications: [NotificationModel] = []
    @State var mealName = ""
    @State var isToggleOn = true
    @State var didUserSaveMealReminders = true
    @State var selectedTime = Date()
    @State private var isDatePickerVisible = false
    private var bindingNotifications: [NotificationModel] {
           notificationManager.notifications
       }
       
       // Function to update notifications
       private func setBindingNotifications(_ newValue: [NotificationModel]) {
           notificationManager.notifications = newValue
       }
       
       // Use the computed property in your view
       func deleteNotification(identifier: String) {
           // Delete the notification with the given identifier
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
           
           // Remove the notification from the computed property
           if let index = bindingNotifications.firstIndex(where: { $0.id == identifier }) {
               var notifications = bindingNotifications
               notifications.remove(at: index)
               setBindingNotifications(notifications)
           }
       }
   
    
    var body: some View {
        VStack{
            HStack{
//              Text("Edit")
//                    .font(.title2)
//                    .offset(x: 15)
//                    .foregroundColor(Color("LandingPage1"))
                Spacer()
                Text("Meal Reminders")
                    .font(.title2)
                    .padding([.top, .bottom], 25)
                Spacer()
                Image(systemName: "plus")
                    .font(.title2)
                    .offset(x: -15)
                    .onTapGesture {
                        isDatePickerVisible = true
                    }
            }
            .sheet(isPresented: $isDatePickerVisible){
                ReminderPickerPopUp(isDatePickerVisible: $isDatePickerVisible,  notificationManager: notificationManager )
            }
            if didUserSaveMealReminders {
                VStack(alignment: .leading) {
                    ForEach(notificationManager.notifications.uniqueByNotificationIdentifier) { notification in
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(reminderLogic.formatNotificationTime(trigger: notification.trigger))
                                        .bold()
                                        .font(.title)
                                        .padding(.bottom, -5)
                                    Text(notification.body)
                                        .font(.title3)
                                        .padding(.top, 1)
                                        .foregroundColor(Color("accentUserText"))
                                    Text(notification.savedDays.joined(separator: ", "))
                                        .foregroundColor(Color("accentUserText"))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading) // Ensure consistent frame width and alignment

                                Spacer()

                                   
                                Button(action: {
                                    deleteNotification(identifier: notification.id)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }

                                Spacer()
                            }
                            .padding([.top, .bottom], 15) // Adjust padding as needed
                           // .border(Color.gray.opacity(0.5), width: 1)
                            .padding(.leading, 10)
                            Divider()
                             .frame(height: 1)
                             .padding(.horizontal, 30)
                             .background(Color.gray.opacity(0.5))
                        }
                    }
                }
            }
            else {
                Text("No current reminders scheduled")
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .padding(.top, 50)
            }
        }
        
        Spacer()
            .onAppear {
              
                reminderLogic.getAllScheduledNotifications { (notificationRequests) in
                    if let notificationRequests = notificationRequests {
                        for request in notificationRequests {
                            print("request: \(request.trigger)")
                            if let userInfo = request.content.userInfo as? [String: Any],
                               let savedDays = userInfo["SavedDays"] as? [String] {
                                let notificationModel = NotificationModel(
                                    creationDate: Date(),
                                    identifier: request.identifier,
                                    content: request.content,
                                    trigger: request.trigger!,
                                    body: request.content.body,
                                    notificationIdentifier: request.content.body + savedDays.joined(separator: ","),
                                    savedDays: savedDays
                                    
                                )
                             
                                notificationManager.addNotification(notificationModel)
                                let body = notificationModel.content.body
                              

                                
                            }
                        }
                    }
                }
            }
    }
}

//struct MealRemindersView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealRemindersView()
//    }
//}
