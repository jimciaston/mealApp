//
//  SavedJournalsList.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/11/22.
//

import SwiftUI

struct SavedJournalsList: View {
    var body: some View {
        VStack (alignment: .leading){
                    Text("2700 Total Calories").bold()
                .padding(.leading, 15)
                    HStack{
                        Text("200 Carbs")
                            .foregroundColor(.gray)
                        Text("250 Protein")
                            .foregroundColor(.gray)
                        Text("100 Fat")
                            .foregroundColor(.gray)
                    }
                    .padding(.all, 5)
                    .frame(maxWidth: .infinity)
                  
               
            }
        
        .frame(width: 300, height: 125)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: Color("LighterGray"), radius: 5, x: 0, y: 8)
    }
}

struct SavedJournalsList_Previews: PreviewProvider {
    static var previews: some View {
        SavedJournalsList()
    }
}
