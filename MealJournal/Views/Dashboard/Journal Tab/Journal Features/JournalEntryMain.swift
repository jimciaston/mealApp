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
    
    
    func favoriteJournalEntry(){
        var totalCals = 0
        var totalProtein = 0
        var totalCarbs = 0
        var totalFat = 0
        for entry in fetchedJournalEntrys {
            if(entry.dayOfWeekCreated == dayOfWeek  ){
                if entry.entrySaved == false {
                    totalCals += Int(entry.mealCalories ?? 0)
                    totalProtein += Int(entry.mealProtein ?? 0)
                    totalCarbs += Int(entry.mealCarbs ?? 0)
                    totalFat  += Int(entry.mealFat ?? 0)
                    
                   UserJournalHelper.saveEntryToFirestore(mealName: entry.entryName!, mealFat: entry.mealFat!, mealCarbs: entry.mealCarbs!, mealProtein: entry.mealProtein!, mealCalories: entry.mealCalories!, mealSaved: true, mealServing: 0, mealTiming: entry.mealTiming!, dayOfWeek: dayOfWeek, dateCreated: entry.createdDate!,
                      totalCalories: String(totalCals),
                      totalProtein: String(totalProtein),
                      totalCarbs: String(totalCarbs),
                      totalFat: String(totalFat)
                   )
    //save entry
                    entry.entrySaved = true
                    do{
                        try managedObjectContext.save()
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
                else{
                    isUserFavoritingEntry = false // << so star doesn't fill
                    overlayShowing = true
                    favoriteAlreadySaved = true
                }
            }
        }
    }
   
    var body: some View {
                VStack{
                    MacroView(fetchEntryTotals: fetchEntryTotals)
                        .environmentObject(mealEntrys) //references meal entry
                    //fetch calorie totals
                        .onAppear{
                            fetchEntryTotals.fetchCalorieTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                            fetchEntryTotals.fetchProteinTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                            fetchEntryTotals.fetchCarbTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
                            fetchEntryTotals.fetchFatTotals(journalEntrys: fetchedJournalEntrys, dayOfWeek: dayOfWeek)
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
                            }){
                                Image(systemName: "arrow.left")
                            }
                            if dayOfWeekPermanent == weekdayAsString(date: calendarHelper.currentDay) {
                                Text("Today")
                            }
                            else{
                                Text(weekdayAsString(date: calendarHelper.currentDay)) // << display current day of week
                            }
                            
                            
                            Button(action: {
                                if dayOfWeekPermanent == dayOfWeek {
                                    showSearchBar = true
                                    isDeletable = true
                                }
                                else{
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
                                }
                                
                            }){
                                Image(systemName: "arrow.right")
                                    .opacity(showSearchBar ? 0 : 1)
                                   
                                
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .center) //<< center
                        .opacity(isUserSearching ? 0 : 1.0 )
                        
                        // USER FAVORITING ENTRY, Star feature
                        
                        Button(action: {
                            if (dayOfWeekPermanent == weekdayAsString(date: calendarHelper.currentDay)){
                                //favorite not valid
                                withAnimation {
                                    overlayShowing = true
                                }
                               
                            }
                            else{
                                if !favoriteNotValid {
                                    self.animateStar = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration, execute: {
                                        isUserFavoritingEntry = true
                                        self.animateStar = false
                                    })
                                   
                                    //save logic
                                   favoriteJournalEntry()
                                }
                            }
                          
                        }){
                            Image(systemName:isUserFavoritingEntry ? "star.fill" : "star")
                                .resizable()
                                .frame(width:25, height: 25)
                                .opacity(isUserSearching ? 0 : 1.0 )
                                .padding(.trailing, 65)
                                .foregroundColor(isUserFavoritingEntry ? .yellow : .black)
                            //animate shadow separately
                                .shadow(color: .yellow.opacity(animateStar ? 0 : 1) , radius: isUserFavoritingEntry ? 1 : 0)
                                .scaleEffect(animateStar ? animateStarScale : 1)
                                .animation(.easeInOut(duration: animationDuration))
                            
                            //pop up if user tries to favorite current day
                                .overlay(
                                    FavoriteInvalidPopUp(validOrSaved: $favoriteAlreadySaved)
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
                                    )
                                }
                        ///Keep at 1, no idea why day of week doesn't center without this
                        .frame(width: 1)
                      
                        
                    }
                    
                    if(!isUserSearching){
                        EntryList(dayOfWeek: dayOfWeek, fetchEntryTotals: fetchEntryTotals, isDeletable: $isDeletable)
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
                                            // if time to live from cb matches current date (7 days)
                                            if mealEntry.timeToLive == calendarHelper.currentDate() {
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

