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
    func searchFood(userItem: String){
       ///IMPROVE API FUNCTION LATER ON DURING LAUNCH
      
        let urlEncoded = userItem.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
           guard
                let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?&api_key=bRbzV0uKJyenEtd1GMgJJNh4BzGWtDvDZVOy8cqG&query=\(urlEncoded!)") else {return}
                URLSession.shared.dataTask(with: url) { (data, _,_) in
                    let searchResults = try! JSONDecoder().decode(FoodData.self, from: data!)
                    DispatchQueue.main.async { [self] in
                        var counter = 0
                            for item in searchResults.foods ?? []{
                                if (counter < 5){
                                    self.userSearchResults.append(Meal(
                                        id: UUID(),
                                        brand: item.brandOwner?.lowercased().firstCapitalized ?? "Brand Unavailable",
                                        mealName: item.lowercaseDescription?.firstCapitalized ?? "food invalid",
                                        calories: String(Double(round(item.foodNutrients?[3].value! ?? 0.00)).removeZerosFromEnd()),
                                        quantity: Int(item.servingSize ?? 2.00),
                                        amount: item.servingSizeUnit ?? "Invalid Amount",
                                        protein: Int(Double(round(item.foodNutrients?[0].value! ?? 0.00)).removeZerosFromEnd()),
                                        carbs: Int(Double(round(item.foodNutrients?[2].value! ?? 0.00)).removeZerosFromEnd()),
                                        fat: Int(Double(round(item.foodNutrients?[1].value! ?? 0.00)).removeZerosFromEnd())
                                    ))
                                    counter += 1
                                }
                        else{return}
                    }
                       
                }
            }
            .resume()
        }
   
    }


