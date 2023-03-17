//
//  LandingPageLogo.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/29/22.
//

import SwiftUI


struct LandingPageLogo: View {
    @Binding var offsetValue: CGFloat
    @Binding var scale: CGFloat
    @Binding var isMealJournalTitleShowing: Bool
    var body: some View {
        VStack{
            Image("bodybuilding-1") // << main image
                .resizable()
                .scaledToFit()
                .frame(width:200, height:200)
                //.renderingMode(.template)
                .foregroundColor(Color("titleLogo"))
                .padding(.top, 200)
                .scaleEffect(scale)
        
        .offset(y:-25)
        }
        .frame(width: 500, height: 200)
        .offset(y: offsetValue)
    }
}

struct LandingPageLogo_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageLogo(offsetValue: .constant(250), scale: .constant(2), isMealJournalTitleShowing: .constant(true))
    }
}
