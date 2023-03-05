//
//  addToolbar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/14/22.
//

import SwiftUI

struct AddToolbar: View {
    @ObservedObject var calendarHelper = CalendarHelper()
    @Binding var showAddOptions: Bool
    @State var showMealView = false
    
    var body: some View {
        
        HStack{
            VStack{
                Button(action: {
                    showMealView.toggle()
                }){
                    VStack{
                Image(systemName: "square.and.pencil")
                    .font(.title)
                    .foregroundColor(.black)
                    .background(Circle()
                        .fill(.gray)
                        .frame(width:50, height:50))
                    .padding(3)
                
                Text("Meal")
                    .foregroundColor(.black)
                    }
                }.fullScreenCover(isPresented: $showMealView){
                    JournalEntryMain(dayOfWeek: weekdayAsString(date: calendarHelper.currentDay))
                }
            }
            VStack{
                Image(systemName: "text.book.closed")
                    .foregroundColor(.black)
                    .font(.title)
                    .background(Circle()
                        .fill(.gray)
                        .frame(width:50, height:50))
                    .padding(3)
                
                Text("Recipe")
                    .foregroundColor(.black)
                }
            .offset(y: -50)
            }
        .frame(height:150)
        }
    }

struct AddToolbar_Previews: PreviewProvider {
    static var previews: some View {
        AddToolbar(showAddOptions: Binding.constant(true))
    }
}
