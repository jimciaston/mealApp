//
//  RecipeSuccessPopUp.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/15/22.
//

import SwiftUI

struct RecipeSuccessPopUp: View {
    @Binding var shown:  Bool
    @ObservedObject var recipeClass: Recipe
    @Environment(\.dismiss) var dismiss
    var onDismiss: (() -> Void)?
    @Binding var showSuccessMessage:  Bool
    var body: some View {
        VStack {
            Image(systemName:"sun.dust").resizable()
                .frame(width: 50, height: 50).padding(.top, 10)
                Spacer()
            
            Text("Recipe Saved!")
                .foregroundColor(Color.white)
                .font(.title)
                Spacer()
            
            HStack {
                Button("Ok") {
                    showSuccessMessage = false
                    shown = false
                    onDismiss?()
                    dismiss()
                }
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width, height: 40)
                .background(Color("SuccessButtonColor"))
              }
            }
            .frame(width: UIScreen.main.bounds.width-50, height: 200)
            .background(Color.blue)
            .cornerRadius(25)
            .clipped()
    }
}
//
//struct RecipeSuccessPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeSuccessPopUp(shown: Binding.constant(true))
//    }
//}
