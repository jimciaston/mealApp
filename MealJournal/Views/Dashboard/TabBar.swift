//
//  TabBar.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/23/22.
//

import SwiftUI

struct TabBarIcon: View {
    let width, height: CGFloat
    let iconName, tabName: String
    
    var body: some View {
        VStack {
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width, height: height)
                        .padding(.top, 10)
                    Text(tabName)
                        .font(.footnote)
                    Spacer()
                }
                    .padding(.horizontal, -4)
                   
                    
    }
}

//struct TabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBar()
//    }
//}
