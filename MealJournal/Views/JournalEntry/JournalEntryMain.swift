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
    
    
    
   // @State var currentWeekday = 0
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
    /*
     
     
     create separate pop up for if day is saved already
     
     
     
     */
    func favoriteJournalEntry(){
        for entry in fetchedJournalEntrys {
            if(entry.dayOfWeekCreated == dayOfWeek  ){
                if entry.entrySaved == false {
                    UserJournalHelper.saveEntryToFirestore(mealName: entry.entryName!, mealFat: 0, mealCarbs: 0, mealProtein: 0, mealCalories: 0, mealSaved: true, mealServing: 0, mealTiming: entry.mealTiming!, dayOfWeek: dayOfWeek, dateCreated: entry.createdDate!)
                    
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
    NavigationView{
        VStack{
            MacroView()
                .environmentObject(mealEntrys) //references meal entry
           
            //search bar - sets foodname to foodname
        MealSearchBar(isUserDoneSearching: $isUserSearching)//when user is completed searching
            HStack(spacing: 0){
                HStack(spacing: 0){
                    Button(action: {
                        calendarHelper.decrementDate()
                        dayOfWeek = weekdayAsString(date: calendarHelper.currentDay)
                        isUserFavoritingEntry = false
                        overlayShowing = false // << clear overlay if showing
                        //takes msg away if not valid
                        favoriteNotValid = false
                    }){
                        Image(systemName: "arrow.left")
                    }
                    
                    Text(weekdayAsString(date: calendarHelper.currentDay)) // << display current day of week
                    
                    Button(action: {
                        calendarHelper.incrementDate()
                        dayOfWeek = weekdayAsString(date: calendarHelper.currentDay)
                        isUserFavoritingEntry = false
                        overlayShowing = false // << clear overlay if showing
                        //if msg showing, takes away on next day
                        favoriteNotValid = false
                    }){
                        Image(systemName: "arrow.right")
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center) //<< center
                .opacity(isUserSearching ? 0 : 1.0 )
                
                // USER FAVORITING ENTRY
                Button(action: {
                    if (dayOfWeekPermanent == weekdayAsString(date: calendarHelper.currentDay)){
                        //favorite not valid
                        withAnimation {
                            overlayShowing = true
                        }
                       
                    }
                    else{
                        if !favoriteNotValid {
                            isUserFavoritingEntry = true
                            //save logic
                            favoriteJournalEntry()
                        }
                    }
                  
                }){
                    Image(systemName:isUserFavoritingEntry ? "star.fill" : "star")
                        .resizable()
                        .frame(width:25, height: 25)
                        .opacity(isUserSearching ? 0 : 1.0 )
                        .padding(.trailing, 45)
                        .foregroundColor(isUserFavoritingEntry ? .yellow : .black)
                    //pop up if user tries to favorite current day
                        .overlay(
                            FavoriteInvalidPopUp(validOrSaved: $favoriteAlreadySaved)
                                 // Start styling the popup...
                                .padding(.all, 10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                                .offset(x: -120, y: -40) // Move the view above the button
                               .opacity(overlayShowing ? 1.0 : 0)
                                .frame(width: 250, height: 70)
                                        .padding(.trailing, 20)
                            )
                        }
                ///Keep at 1, no idea why day of week doesn't center without this
                .frame(width: 1)
              
                
            }
            
            if(!isUserSearching){
                EntryList(dayOfWeek: dayOfWeek)
                    .onAppear{
                        dayOfWeek = weekdayAsString(date: calendarHelper.currentDay)
                        dayOfWeekPermanent = weekdayAsString(date: calendarHelper.currentDay)
                       
//                                for mealEntry in existingJournalEntrys {
//                                    if mealEntry.createdDate == "05/12/2022" {
//                                        UserJournalHelper().deleteJournalEntry(entry: mealEntry, context: managedObjContext)
//                                    }
//                                        
//                                }
                            
                    }
                }
        
        }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    .environmentObject(mealEntrys) //references meal entry
        
        
        
            // Grab all entrys for given day
            
            // when time strikes midnight, save down
            
            //throw on finishing touches animatin
            
            //done. you did it.
        
}
        
 


struct JournalEntryMain_Previews: PreviewProvider {
    static var previews: some View {
        JournalEntryMain(dayOfWeek: "Tuesday").environmentObject(MealEntrys())
    }
}
}
