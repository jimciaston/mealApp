//
//  favoriteInvalidPopUp.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/8/22.
//

import SwiftUI

struct FavoriteInvalidPopUp: View {
    @Binding var validOrSaved: Bool
    @Binding var journalSaved: Bool
    var body: some View {
        if(journalSaved){
            Text("Journal Saved")
                .font(.body)
                .foregroundColor(.black)
        }
        Text(!validOrSaved ? "Journal can only be saved once day completes" : "Journal has already been saved")
            .font(.body)
            .foregroundColor(.black)
            
    }
}

//struct FavoriteInvalidPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteInvalidPopUp()
//    }
//}
