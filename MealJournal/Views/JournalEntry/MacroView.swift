//
//  MacroView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/27/22.
//

import SwiftUI

struct MacroView: View {
    var body: some View {
        let macroCount = DailyMacrosCounter()
        VStack{
            Text("Daily Macros")
                .font(.title2)
            HStack{
                VStack{
                    Text(macroCount.getCarbs())
                    Text("Carbs")
                        .padding(-5)
                }
                .padding(30)
                VStack{
                    Text(macroCount.getFat())
                        Text("Fat")
                        .padding(-5)
                }
                .padding(30)
                VStack{
                    Text(macroCount.getProtein())
                       Text("Protein")
                        .padding(-5)
                }
                .padding(30)
            }
            .padding(.top, -15)
        }
        .foregroundColor(.black)
    }
}

struct MacroView_Previews: PreviewProvider {
    static var previews: some View {
        MacroView()
    }
}
