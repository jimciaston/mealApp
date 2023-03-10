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
            Image(systemName: "sun.dust")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            Text("Recipe Saved!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
            Button("OK") {
                showSuccessMessage = false
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color("SuccessButtonColor"))
            .cornerRadius(10)
        }
        .padding(20)
        .background(Color.blue)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
//
//struct RecipeSuccessPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeSuccessPopUp(shown: Binding.constant(true))
//    }
//}
