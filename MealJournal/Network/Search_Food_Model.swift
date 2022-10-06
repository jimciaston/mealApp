//
//  Search_Food_Model.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/2/22.
//

import Foundation
import SwiftUI

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

class FoodApiSearch: ObservableObject{
    @Published var userSearchResults: [Meal] = Array()
    @Published var userSearch: String = ""
    @Published var customFoodSearch: Bool = false // << if user is search custom food
    @Published var isFoodSearchLoading: Bool = false //<< will communicate with progressView
    @Published var foodResultsDisplayed = 0 // << counts total number of foods on screen
    //will search for user Input
    func searchFood(userItem: String, showMoreResults: Bool){
        if !customFoodSearch{
            isFoodSearchLoading = true
            self.foodResultsDisplayed = 0
            let urlEncoded = userItem.addingPercentEncoding(withAllowedCharacters: .alphanumerics) //accounts for user spacing
               guard let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?&api_key=bRbzV0uKJyenEtd1GMgJJNh4BzGWtDvDZVOy8cqG&query=\(urlEncoded!)") else {return}
            
                    URLSession.shared.dataTask(with: url) { (data, _, error) in
                        //HANDLE ERROR
                        if let error = error {
                            self.isFoodSearchLoading = false
                            print("error")
                            return
                        }
                       let searchResults = try! JSONDecoder().decode(FoodData.self, from: data!)
                           
                      
                        // << resets counter on search
                        DispatchQueue.main.async { [self] in
                                for item in searchResults.foods ?? []{
                                   
                                    if foodResultsDisplayed < 50 { // << show six foods on screen
                                        // if index out of value solution
                                        if item.foodNutrients!.count <= 0{
                                            isFoodSearchLoading = false
                                            return
                                        }
                                        if item.foodNutrients!.count > 0 { // << if food nutrients is valid
                                            foodResultsDisplayed = 6
                                            let proteinConverted = convertMacros(macro: Double(round(item.foodNutrients?[0].value! ?? 0.00)), servingSize: item.servingSize ?? 1.00)
                                            let carbsConverted = convertMacros(macro: Double(round(item.foodNutrients?[2].value! ?? 0.00)), servingSize: item.servingSize ?? 1.00)
                                            
                                            
                                            let fatConverted = convertMacros(macro: Double(round(item.foodNutrients?[2].value! ?? 0.00)), servingSize: item.servingSize ?? 1.00)
                                            
                                            let caloriesConverted = convertMacros(macro: Double(round(item.foodNutrients?[3].value! ?? 0.00)), servingSize: item.servingSize ?? 1.00)
                                            
                                            self.userSearchResults.append(Meal(
                                                id: UUID(),
                                                brand: item.brandOwner?.lowercased().firstCapitalized ?? "Generic",
                                                //note padding on mealName cuts string off at 18 char, preventing sloppy UI if long meal name
                                                mealName: item.lowercaseDescription?.firstCapitalized.padding(toLength: 18, withPad: " ", startingAt: 0) ?? "food invalid",
                                                calories: Int(caloriesConverted),
                                                quantity: Int(Double(round(item.servingSize ?? 0.00))),
                                                amount: item.servingSizeUnit ?? "Invalid Amount",
                                                protein: Int(proteinConverted) ,
                                                carbs: Int(carbsConverted),
                                                fat: Int(fatConverted),
                                                servingSize: item.servingSize,
                                                servingSizeUnit: item.servingSizeUnit
                                            ))
                                            foodResultsDisplayed += 1
                                        }
                                      
                                        
                                    }
                                }
                            
                            isFoodSearchLoading = false // << recipe results loaded successfully  
                    }
                }
                .resume()
        }
        else{
            print("custom search")
        }
        }
   
    }


