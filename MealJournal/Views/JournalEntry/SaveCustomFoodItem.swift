//
//  SaveCustomFoodItem.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/27/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class SaveCustomFoodItem: ObservableObject {
   // @Published var recipes = [RecipeItem]()
    @State var saveSuccess = false
    //save recipes when edited
    func saveFoodItem(foodName: String, calories: Int ,protein: Int, fat: Int, carbs: Int, foodItemID: UUID){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userCustomFoodItems")
            .document(foodItemID.uuidString)
            .setData([
                "foodName" : foodName,
                "calories" : calories,
                "protein": protein,
                "fat" : fat,
                "carbs": carbs
        ], merge: true)
    }
}
