//
//  RecipeEditorBottomSheetView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/18/22.
//

import SwiftUI

struct RecipeEditorBottomSheetView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var ema: EditModeActive
    @StateObject var rm = RecipeLogic()
    @Binding var recipeID: String
    @Binding var showRecipeBottomSheet: Bool
    var body: some View {
        VStack{
            Text("What do you wish to do")
            
            HStack{
                Button(action: {
                    ema.editMode.toggle()
                    showRecipeBottomSheet = false
                    //if user is saving when complete is on the button
                  
                 //   showRecipeBottomSheet = false
                }){
                    Text("Edit Recipe")
                }
                Button(action: {
                    //   showRecipeBottomSheet = false
                }){
                    Text("Add to Meals")
                }
            }
        }
    }
}
//
//struct RecipeEditorBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEditorBottomSheetView( recipeID: .constant("JFkdj"))
//    }
//}
