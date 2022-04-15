//
//  RecipeDashHeader.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/20/22.
//

import SwiftUI

struct RecipeDashHeader: View {
    @State var recipeName = ""
    
    var body: some View {
        VStack{
            Text(recipeName)
                .font(.title2)
                .padding()
            HStack{
                Image(systemName: "clock")
                    .foregroundColor(.green)
                Text("30 Mins")
            }
        }
        .frame(width:250, height:95)
        .background(Color.white)
        .cornerRadius(15)
    }
}

//struct RecipeDashHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDashHeader()
//    }
//}
