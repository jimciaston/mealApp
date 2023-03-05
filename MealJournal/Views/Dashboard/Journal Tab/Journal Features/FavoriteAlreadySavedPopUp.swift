//
//  FavoriteAlreadySavedPopUp.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/9/22.
//

import SwiftUI

struct FavoriteAlreadySavedPopUp: View {
    var body: some View {
        Text("Journal can only be saved once day completes")
            .font(.body)
            .foregroundColor(.black)
            
    }
}

struct FavoriteAlreadySavedPopUp_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteAlreadySavedPopUp()
    }
}
