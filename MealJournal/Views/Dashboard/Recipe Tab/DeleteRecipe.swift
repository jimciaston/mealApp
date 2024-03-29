//
//  DeleteRecipe.swift
//  MealJournal
//
//  Created by Jim Ciaston on 7/19/22.
//

import SwiftUI
import UIKit

struct DeleteRecipe: View {
    @StateObject var rm = RecipeLogic()
    @ObservedObject var ema = EditModeActive()
    @State var currentRecipeID: String
    @State private var showAlert = false
    @Environment (\.dismiss) var dismiss
    
    var onDelete: (() -> Void)?
    var body: some View {
        
        Text("Delete Recipe")
           
            .foregroundColor(.red)
           
        //delete recipe
            .onTapGesture{
                showAlert = true
            }
        //display standard ios alert
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Are you sure you want to delete this recipe?"),
                      primaryButton: Alert.Button.default(Text("Cancel"), action: {
                   //no action needed, back to recipe
                         }),
                      secondaryButton: Alert.Button.destructive(Text("Yes, I'm Sure"), action: {
                    //delete recipe
                    rm.deleteRecipe(selectedRecipeID: currentRecipeID)
                    onDelete?() // << closure that "closes" alert when user clicks yes
                 })
             )
           }
            
    }
}
//
//struct DeleteRecipe_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteRecipe()
//    }
//}
