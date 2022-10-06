//
//  FetchCustomFoodItem.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/28/22.
//

import Foundation
import SwiftUI


class CustomFoodLogic: ObservableObject {
    @Published var customFoodItems = [Meal]()
    
    init() {
        grabCustomFoodItems()
    }
    
    func grabCustomFoodItems(){
        //grab current user
         guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
             return
         }
         FirebaseManager.shared.firestore
             .collection("users")
             .document(uid)
             .collection("userCustomFoodItems")
             .addSnapshotListener { (snapshot, err) in
                 guard let documents = snapshot?.documents else{
                     print("no documents present")
                     return
                 }
                 
                 self.customFoodItems = documents.map { (querySnapshot) -> Meal in
                     let data = querySnapshot.data()
                     let calories = data ["calories"] as? Int ?? 0
                     let carbs = data ["carbs"] as? Int ?? 0
                     let fat = data ["fat"] as? Int ?? 0
                     let foodName = data ["foodName"] as? String ?? "Unavailable"
                     let protein = data ["protein"] as? Int ?? 0
                    
                    
                     let foodItem = Meal(id: UUID(), brand: "Custom", mealName: foodName, calories: calories, quantity: 0, amount: "amount", protein: protein, carbs: carbs, fat: fat, servingSize: 0.0, servingSizeUnit: "")
                     
                     return foodItem
                     
                 }
             }
         }
}


