//
//  JournalEntry.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/15/22.
//

import SwiftUI





struct JournalEntryMain: View {
    @StateObject var mealEntrys = MealEntrys()
    
    @Environment(\.dismiss) var dismiss
  //will be set to variable
    @State private var foodName = ""
    @State private var isUserSearching = false
    var body: some View {
    NavigationView{
        VStack{
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.body)
                    .foregroundColor(.black)
            }
            .padding()
            .padding(.leading, 250)
        
    //search bar - sets foodname to foodname
        MealSearchBar(isUserDoneSearching: $isUserSearching)//when user is completed searching
            
            if(!isUserSearching){
                List {
                    Section(header: Text(Sectionheader(secHead: "Breakfast"))
                                .foregroundColor(.black),
                            footer:Button("Edit"){
                                //do something
                                })
                    {
                        if(mealEntrys.mealEntrysBreakfast.isEmpty){
                            Text("")
                    }
                        ForEach(mealEntrys.mealEntrysBreakfast) { meal in
                                EntryRow(meal: meal)
                        }
                    }
                    Section(header: Text("Lunch"),
                            footer: Button("Add Meal"){
                        //do something later
                    }){
                        if(mealEntrys.mealEntrysLunch.isEmpty){
                            Text("")
                        }
                        ForEach(mealEntrys.mealEntrysLunch){ meal in
                            EntryRow(meal:meal)
                        }
                    }
                    Section(header:Text("Dinner"),
                            footer: Button("Add Meal"){
                        //do something later
                    }){
                        if(mealEntrys.mealEntrysDinner.isEmpty){
                            Text("")
                        }
                        ForEach(mealEntrys.mealEntrysDinner, id: \.self){ meal in
                           EntryRow(meal:meal)
                           
                       }
                        
                    }
                   
                }
                //list stylings
                            .listStyle(GroupedListStyle())
                            .foregroundColor(.black)
            }
           
                        
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
       
        }
    .environmentObject(mealEntrys) //references meal entry
    }
   



func Sectionheader(secHead: String) -> String {
    return secHead
}

struct JournalEntryMain_Previews: PreviewProvider {
    static var previews: some View {
        JournalEntryMain()
    }
}
}
