//
//  RecipeSuccessPopUp.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/15/22.
//

import SwiftUI

struct RecipeSuccessPopUp: View {
   
    @Binding var showSuccessMessage:  Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Image("recipeSuccessImage")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            Text("Recipe Saved!")
                .font(.title2)
                .padding([.leading, .trailing], 50)
                .foregroundColor(Color.black)
            
        }
        .padding(20)
        .background(Color("LighterWhite"))
        .cornerRadius(20)
        .shadow(radius: 10, y: 10)
        .frame(width:350, height:100)
    }
}

struct RecipeSuccessPopUp_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSuccessPopUp(showSuccessMessage: Binding.constant(true))
    }
}
