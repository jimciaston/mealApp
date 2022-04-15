//
//  RecipeEntryPicture.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/15/22.
//

import SwiftUI

struct RecipeEntryPicture: View {
    var body: some View {
        Image("ExampleRecipePicture")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width:200, height: 100)
            .offset(y:-200)
    }
}

struct RecipeEntryPicture_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEntryPicture()
    }
}
