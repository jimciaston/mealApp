//
//  TabBarIconPlus.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/25/22.
//

import SwiftUI

struct TabBarIconPlus: View {
    let width, height: CGFloat
    let iconName, tabName: String
    
    var body: some View {
        VStack {
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width, height: height)
                        .padding(.top, 10)
                   
                    Spacer()
                }
                    .padding(.horizontal, -4)
                   
                    
    }
}


//struct TabBarIconPlus_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarIconPlus()
//    }
//}
