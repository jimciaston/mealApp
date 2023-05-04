//
//  JournalEntry.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/15/22.
//

import SwiftUI
import CoreData








//func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }


struct JournalEntryMain: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: JournalEntry.entity(), sortDescriptors: []) var fetchedJournalEntrys: FetchedResults<JournalEntry>
    @StateObject var userJournalHelper = UserJournalHelper()
    @StateObject var fetchEntryTotals = FetchEntryTotals()
    @State var isDeletable = false // makes sure can't delete previous day entrys
   // @State var currentWeekday = 0
    //remove journal entry
    func removeJournalEntry(at offsets: IndexSet) {
        mealEntrys.mealEntrysLunch.remove(atOffsets: offsets)
    }
   
    @EnvironmentObject var mealEntrys: MealEntrys
    //interchangeable, updates when we toggle calendar
    @State var dayOfWeek = ""
    // grabs current weekday and DOES NOT update on toggle
    @State var dayOfWeekPermanent = ""
    @Environment(\.dismiss) var dismiss
    @State private var foodName = ""
    @State var isUserSearching = false
    @State var isUserFavoritingEntry = false
    //if favoriting on current day, throw true
    @State private var favoriteNotValid = false
    //if favorite is already saved
    @State private var favoriteAlreadySaved = false
    //Calendar help class
    @StateObject var calendarHelper = CalendarHelper()// << User Date information
    @State var overlayShowing = false
    //search bar State
    @State private var showSearchBar = true
    
   
    //animation variables for Star icon
    private let animationDuration: Double = 0.1
    private var animateStarScale: CGFloat {
        isUserFavoritingEntry ? 0.9: 1.3
    }
    @State private var animateStar = false
    
    @State var journalSaved = false
    @State var attemptedSameDaySave = false
    @State var journalSavedAlready = false
    @State var isExistingJournalEntrysEmpty = false
    @State var intC = 0 // << count if we go six days back
    @State var calendarDate = Date()
    
    //format date to xxxx-xx-xx
    func dateString(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
            return dateFormatter.string(from: date)
        }
    
    
    func favoriteJournalEntry(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        var totalCals = 0
        var totalProtein = 0
        var totalCarbs = 0
        var totalFat = 0
       
        //same day save not valid
        if dayOfWeek == dayOfWeekPermanent {
            print("day of week")
            attemptedSameDaySave = true
        }
        
        else{
          
            attemptedSameDaySave = false
            //check firestore for existenece
                FirebaseManager.shared.firestore.collection("users").document(uid).collection("userJournalEntrys").document(dateString(calendarDate)).getDocument { (snapshot, error) in
                    if let error = error {
                        print("Error getting document: \(error)")
                        return
                    }
                    if snapshot?.exists == true {
                        print("Journal Exists already")
                       journalSavedAlready = true
                    } else {
                      
                        journalSavedAlready = false
                        let dateString = String(dateString(calendarDate))
                        let dateStringDashesRemoved = dateString.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
                        //Need to now reverse day and month dates
                        let day = dateStringDashesRemoved.prefix(2)
                        
                        let monthStart = dateStringDashesRemoved.index(dateStringDashesRemoved.startIndex, offsetBy: 2)
                        let monthEnd = dateStringDashesRemoved.index(monthStart, offsetBy: 2)
                        let month = dateStringDashesRemoved[monthStart..<monthEnd]
                       
                        let yearStart = dateStringDashesRemoved.index(dateStringDashesRemoved.startIndex, offsetBy: 4)
                        let yearEnd = dateStringDashesRemoved.index(yearStart, offsetBy: 4)
                        let year = dateStringDashesRemoved[yearStart..<yearEnd]
                        let stringFormattedForCBMatch = String("\(month)/\(day)/\(year)")
                      
                        let predicate = NSPredicate(format: "createdDate CONTAINS %@", stringFormattedForCBMatch )
                        let filteredJournalEntries = fetchedJournalEntrys.filter { predicate.evaluate(with: $0) }
                       
                        for entry in filteredJournalEntries {
                           
                           totalCals += Int(entry.mealCalories ?? 0)
                           totalProtein += Int(entry.mealProtein ?? 0)
                           totalCarbs += Int(entry.mealCarbs ?? 0)
                           totalFat  += Int(entry.mealFat ?? 0)
                            userJournalHelper.saveEntryToFirestore(mealName: entry.entryName!, mealFat: entry.mealFat!, mealCarbs: entry.mealCarbs!, mealProtein: entry.mealProtein!, mealCalories: entry.mealCalories!, mealSaved: true, mealServing: 0, mealTiming: entry.mealTiming!, dayOfWeek: dayOfWeek, dateCreated: entry.createdDate!,
                                       totalCalories: String(totalCals),
                                       totalProtein: String(totalProtein),
                                       totalCarbs: String(totalCarbs),
                                       totalFat: String(totalFat)
                                    )
                            print("journal saved okay!")
                         journalSaved = true
                        }
                       
                    }
                }
        }

        
       overlayShowing = true
    }
   
    var body: some View {
                VStack{
                    if !isUserSearching{
                        MacroView(fetchEntryTotals: fetchEntryTotals)
                            .environmentObject(mealEntrys) //references meal entry
                        //fetch calorie totals
                            .onAppear{
                                fetchEntryTotals.fetchCalorieTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchEntryTotals.fetchProteinTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchEntryTotals.fetchCarbTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchEntryTotals.fetchFatTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                            }
                            
                    }
                   
                    //search bar
                   
                    if dayOfWeekPermanent == dayOfWeek {
                            MealSearchBar(isUserDoneSearching: $isUserSearching)
                            .opacity(showSearchBar ? 1 : 0)
                            .animation(.easeInOut(duration: 0.25), value: showSearchBar)
                            //dispaear search bar if not on "today"
                            
                               
                        //sets it automatically to show on appear
                                .onAppear{
                                    showSearchBar = true
                                    isDeletable = true
                                }
                            }
                       
                    HStack(spacing: 0){
                        HStack(spacing: 0){
                            Button(action: {
                                // if date resets back to curent day (today) it will also chane the date
//                                if calendarHelper.currentDay == 6 {
//                                    calendarDate = Date()
//                                }
                                    calendarDate = Calendar.current.date(byAdding: .day, value: -1, to: calendarDate)!
                                
                                isDeletable = false
                                calendarHelper.decrementDate()
                                dayOfWeek = weekdayAsString(date: calendarHelper.currentDay)
                             
                                isUserFavoritingEntry = false
                                overlayShowing = false // << clear overlay if showing
                                //takes msg away if not valid
                                favoriteNotValid = false
                                showSearchBar = false
                                fetchEntryTotals.fetchCalorieTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchEntryTotals.fetchProteinTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchEntryTotals.fetchCarbTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchEntryTotals.fetchFatTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                intC -= 1
                            
                            }){
                                Image(systemName: intC == -6 ? "" : "arrow.left")
                                    .foregroundColor(Color("ButtonTwo"))
                            }
                            .disabled(intC == -6)
                            if dayOfWeekPermanent == weekdayAsString(date: calendarHelper.currentDay) {
                                Text("Today")
                                    .frame(width: 100)
                            }
                            else{
                                Text(weekdayAsString(date: calendarHelper.currentDay)) // << display current day of week
                                    .frame(width: 100)
                            }
                            
                            
                            Button(action: {
                                if dayOfWeekPermanent == dayOfWeek {
                                    showSearchBar = true
                                    isDeletable = true
                                }
                                else{
//
                                    intC += 1
                                    isDeletable = false
                                    showSearchBar = false
                                    calendarHelper.incrementDate()
                                    dayOfWeek = weekdayAsString(date: calendarHelper.currentDay)
                                    isUserFavoritingEntry = false
                                   
                                    overlayShowing = false // << clear overlay if showing
                                    //if msg showing, takes away on next day
                                    favoriteNotValid = false
                                   // Fetch the entry totals for each
                                    fetchEntryTotals.fetchCalorieTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                    fetchEntryTotals.fetchProteinTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                    fetchEntryTotals.fetchCarbTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                    fetchEntryTotals.fetchFatTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                    
                                    calendarDate = Calendar.current.date(byAdding: .day, value: 1, to: calendarDate)!
                                }
                                
                            }){
                                Image(systemName: "arrow.right")
                                    .foregroundColor(Color("ButtonTwo"))
                                    .opacity(showSearchBar ? 0 : 1)
                                   
                            }
                            
                        }
                      
                        .frame(maxWidth: .infinity, alignment: .center) //<< center
                        .opacity(isUserSearching ? 0 : 1.0 )
                      
                        
                        Button(action: {
                                favoriteJournalEntry()
                        }){
                            Image(systemName:isUserFavoritingEntry && !journalSavedAlready ? "star.fill" : "star")
                                .resizable()
                                .frame(width:25, height: 25)
                                .opacity(isUserSearching ? 0 : 1.0 )
                                .padding(.trailing, 65)
                                .foregroundColor(isUserFavoritingEntry && !journalSaved && journalSavedAlready ? .yellow : .black)
                            //animate shadow separately
                              //  .shadow(color: .yellow.opacity(animateStar  && !journalSavedAlready ? 0 : 1) , radius: isUserFavoritingEntry ? 1 : 0)
                                .scaleEffect(animateStar  && !journalSavedAlready ? animateStarScale : 1)
                                .animation(.easeInOut(duration: animationDuration))
                            
                            //pop up if user tries to favorite current day
                                .overlay(
                                    ZStack {
                                        FavoriteInvalidPopUp(journalSavedAlready: $journalSavedAlready, attemptedSameDaySave: $attemptedSameDaySave, journalSaved: $journalSaved, isExistingJournalEntrysEmpty: $isExistingJournalEntrysEmpty)
                                            // Start styling the popup...
                                            .padding(.all, 10)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                                            .offset(x: -120, y: -40) // Move the view above the button
                                            //valid overlay
                                            .opacity(overlayShowing ? 1.0 : 0)
                                            .frame(width: 250, height: 70)
                                            .padding(.trailing, 20)
                                        if overlayShowing {
                                            Color.clear
                                                .onAppear {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                                        withAnimation {
                                                            overlayShowing = false
                                                        }
                                                    }
                                                }
                                        }
                                    }
                                )
                            
                            
//                                .onAppear {
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                        overlayShowing = false
//                                    }
//                                }
                                }
                        ///Keep at 1, no idea why day of week doesn't center without this
                        .frame(width: 1)
                      
                        
                    }
                    
                    if(!isUserSearching){
                        EntryList(dayOfWeek: dayOfWeek, fetchEntryTotals: fetchEntryTotals, isDeletable: $isDeletable, isExistingJournalEntrysEmpty: $isExistingJournalEntrysEmpty)
                            .deleteDisabled(isDeletable)
                     
                            .onAppear{
                               isDeletable = true // << current day is true
                            
                               dayOfWeekPermanent = dayOfWeek
                                   
                                fetchEntryTotals.fetchCalorieTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchEntryTotals.fetchProteinTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchEntryTotals.fetchFatTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchEntryTotals.fetchCarbTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                                fetchSavedJournals()
                                dayOfWeek = weekdayAsString(date: calendarHelper.currentDay)
                                dayOfWeekPermanent = weekdayAsString(date: calendarHelper.currentDay)
                               //delete if time to live
                                        for mealEntry in fetchedJournalEntrys {
                                            print(type(of: calendarHelper.currentDate()))
                                            print(calendarHelper.currentDate())
                                            // if time to live from cb matches current date (7 days)
                                            if mealEntry.timeToLive! <= calendarHelper.currentDate() {
                                                UserJournalHelper().deleteJournalEntry(entry: mealEntry, context: managedObjectContext)
                                               
                                            }

                                        }   
                            }
                        
                        }
                  
                }
                .onAppear{
                    isDeletable = true // make sure can't delete past entrys
                }
            .environmentObject(mealEntrys) //references meal entry
    
          
}
        
}


struct JournalEntryMain_Previews: PreviewProvider {
    static var previews: some View {
        JournalEntryMain(dayOfWeek: "Tuesday").environmentObject(MealEntrys())
    }
}

