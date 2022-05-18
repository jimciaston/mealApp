//
//  Search_Food_Model.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/2/22.
//

import Foundation
import SwiftUI


class FoodApiSearch: ObservableObject{
    @Published var userSearchResults: [Meal] = Array()
   
    //will search for user Input
    func searchFood(userItem: String, showMoreResults: Bool){
       ///IMPROVE API FUNCTION LATER ON DURING LAUNCH
        var counter = 0
        let urlEncoded = userItem.addingPercentEncoding(withAllowedCharacters: .alphanumerics) //accounts for user spacing
           guard
                let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?&api_key=bRbzV0uKJyenEtd1GMgJJNh4BzGWtDvDZVOy8cqG&query=\(urlEncoded!)") else {return}
                URLSession.shared.dataTask(with: url) { (data, _,_) in
                    let searchResults = try! JSONDecoder().decode(FoodData.self, from: data!)
                    
                    DispatchQueue.main.async { [self] in
                       
                            for item in searchResults.foods ?? []{
                                        self.userSearchResults.append(Meal(
                                            id: UUID(),
                                            brand: item.brandOwner?.lowercased().firstCapitalized ?? "Generic",
                                            ///note padding on mealName cuts string off at 18 char, preventing sloppy UI if long meal name
                                            mealName: item.lowercaseDescription?.firstCapitalized.padding(toLength: 18, withPad: " ", startingAt: 0) ?? "food invalid",
                                            calories: String(Double(round(item.foodNutrients?[3].value! ?? 0.00)).removeZerosFromEnd()),
                                            quantity: Int(item.servingSize ?? 0.00),
                                            amount: item.servingSizeUnit ?? "Invalid Amount",
                                            protein: Int(Double(round(item.foodNutrients?[0].value! ?? 0.00)).removeZerosFromEnd()),
                                            carbs: Int(Double(round(item.foodNutrients?[2].value! ?? 0.00)).removeZerosFromEnd()),
                                            fat: Int(Double(round(item.foodNutrients?[1].value! ?? 0.00)).removeZerosFromEnd()),
                                            servingSize: item.servingSize,
                                            servingSizeUnit: item.servingSizeUnit
                                        ))

                        
                    }
                }
            }
            .resume()
        }
   
    }


