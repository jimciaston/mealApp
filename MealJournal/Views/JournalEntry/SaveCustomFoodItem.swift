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
    let itemID = UUID().uuidString
    //save recipes when edited
    func saveFoodItem(foodName: String, calories: Int ,protein: Int, fat: Int, carbs: Int){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .collection("userCustomFoodItems")
            .document(itemID)
            .setData([
                "foodName" : foodName,
                "calories" : calories,
                "protein": protein,
                "fat" : fat,
                "carbs": carbs,
                "itemID": itemID
        ], merge: true)
    }
}
