//
//  ReminderPickerPopUp.swift
//  MealJournal
//
//  Created by Jim Ciaston on 8/27/23.
//

import SwiftUI
import UserNotifications






struct BubbleView: View {
    
    @State var isSelected = false
    @State var letter: String
    @Binding var savedDaysOfWeek: Set<Int>
    @State var index: Int
    var body: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundColor(isSelected ? .orange : Color("ButtonTwo"))
            .overlay(
                Text(letter)
                    .font(.headline)
                    .foregroundColor(.white)
            )
            .onTapGesture {
                isSelected.toggle()
                if isSelected {
                    savedDaysOfWeek.insert(index)
                }
                else{
                    savedDaysOfWeek.remove(index)
                }
            }
        }
    }



struct ReminderPickerPopUp: View {
    func convertIntsToStrings(_ selectedInts: Set<Int>) -> [String] {
        let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        var selectedDays: [String] = []

        for dayInt in selectedInts {
            if let dayIndex = daysOfWeek.indices.first(where: { daysOfWeek[$0].hasPrefix(daysOfWeek[dayInt]) }) {
                selectedDays.append(daysOfWeek[dayIndex])
            }
        }
        
        // Sort the selectedDays array in day-of-week order
        selectedDays.sort {
            let day1Index = daysOfWeek.firstIndex(of: $0) ?? 0
            let day2Index = daysOfWeek.firstIndex(of: $1) ?? 0
            return day1Index < day2Index
        }

        return selectedDays
    }
   


    func scheduleLocalNotification(at scheduledTime: Date, onDayOfWeek day: Int, mealNote: String) {
        let notificationCenter = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Macro Reminder"
        content.body = mealNote
        content.sound = .default
        content.userInfo = [:]
        let creationDate = Date()
        let savedDays = convertIntsToStrings(selectedBubbles)
        content.userInfo = [
                "SavedDays": savedDays
            ]
        let calendar = Calendar.current
        var components = calendar.dateComponents([.hour, .minute], from: scheduledTime)
        components.weekday = day + 1 // added 1 to offset bug where days weren't appearing correctly
        //ie. If I clicked monday, by adding day it is monday and not tuesday

        guard let nextOccurrence = calendar.nextDate(after: scheduledTime, matching: components, matchingPolicy: .nextTime) else {
            return
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute, .weekday], from: nextOccurrence), repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        let notificationModel = NotificationModel(
              creationDate: creationDate,
              identifier: request.identifier,
              content: content,
              trigger: trigger,
              body: mealNote,
              notificationIdentifier: mealNote + savedDays.joined(separator: ","),
              savedDays: savedDays
          )
        notificationManager.addNotification(notificationModel)
    }
    @State var showOverlay = false
    
    @State var nameEmptyOverlay = false
    @State var selectedTime = Date()
    @State var mealReminderName = ""
    @State var selectedBubbles:  Set<Int> = []
    @Binding var isDatePickerVisible: Bool
    @State var notificationManager: NotificationManager
    @State var dateEmptyOverlay = false
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    private func formattedTime(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.timeStyle = .short // You can customize the time style here
            return formatter.string(from: date)
        }
    
    
    var body: some View {
        VStack {
            HStack{
              Text("Cancel")
                    .font(.title3)
                    .offset(x: 15)
                    .foregroundColor(Color("LandingPage1"))
                    .onTapGesture{
                        isDatePickerVisible = false
                    }
                Spacer()
                Text("Set Reminder")
                    .font(.title2)
                    .onTapGesture{
                        print(selectedBubbles)
                    }
                Spacer()
               Text("Save")
                    .font(.title3)
                    .padding(.trailing, 15)
                    .onTapGesture{
                        if selectedBubbles.isEmpty {
                            print("No day selected")
                            showOverlay = true
                            dateEmptyOverlay = true
                            nameEmptyOverlay = false
                        } else if mealReminderName == "" {
                            print("No name saved")
                            showOverlay = true
                            dateEmptyOverlay = false
                            nameEmptyOverlay = true
                        }
                        else{
                            for notification in selectedBubbles.sorted() {
                                scheduleLocalNotification(at: selectedTime, onDayOfWeek: Int(notification) ?? 0, mealNote: mealReminderName)
                            }
                            isDatePickerVisible = false
                        }
                    }
               
            }
            .padding(.top, 25)
            .padding(.bottom, 50)
            Spacer()
            TextField("Enter Reminder Name", text: $mealReminderName)
                .submitLabel(.done)
                .padding(.leading, 25)
                .padding(.bottom, 25)
            
            VStack{
                DatePicker("Select a Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    
                
                Text("Selected time: \(formattedTime(selectedTime))")
                    .font(.title3)
                    .padding(.bottom, 15)
                    .onTapGesture {
                        // Add your onTapGesture logic here
                    }
                    .padding(.top, 25)
                HStack(spacing: 10) {
                    ForEach(daysOfWeek.indices, id: \.self) { index in
                        BubbleView(
                            letter: daysOfWeek[index],
                            savedDaysOfWeek: $selectedBubbles,
                            index: index
                        )
                    }
                }
                .overlay(
                    ZStack {
                        Text(!nameEmptyOverlay ? "Please set a day for your reminder" : "Please provide a name for alert")
                            .foregroundColor(.black)
                            // Start styling the popup...
                            .padding(.all, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                            .offset(x: 15, y: -100) // Move the view above the button
                            //valid overlay
                            .opacity(showOverlay ? 1.0 : 0)
                            .frame(width: 250, height: 70)
                            .padding(.trailing, 20)
                            .multilineTextAlignment(.center)
                        if showOverlay {
                            Color.clear
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation {
                                            showOverlay = false
                                            nameEmptyOverlay = false
                                            dateEmptyOverlay = false
                                        }
                                    }
                                }
                        }
                    }
                )
               
                Spacer()
              
            }
            
           
        }
        
      
        }
    
}

//struct ReminderPickerPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderPickerPopUp( isDatePickerVisible: .constant(true))
//    }
//}
