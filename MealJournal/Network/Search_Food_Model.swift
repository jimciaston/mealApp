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
    @Published var isFoodSearchTimedOut = false
    var task: URLSessionDataTask? = nil // << handle url session
    var timer: Timer?
    
    //will search for user Input
    func searchFood(userItem: String, showMoreResults: Bool){
        if !customFoodSearch{
            isFoodSearchLoading = true
            self.isFoodSearchTimedOut = false
            self.foodResultsDisplayed = 0
            let urlEncoded = userItem.addingPercentEncoding(withAllowedCharacters: .alphanumerics) //accounts for user spacing
               guard let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?&api_key=bRbzV0uKJyenEtd1GMgJJNh4BzGWtDvDZVOy8cqG&query=\(urlEncoded!)") else {return}
            //acting as network timer, if 8 seconds passes, will stop loading
            self.timer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false){ timer in
                //if data does not load in 10 seconds, set foodSearchTimedOut to true
                self.isFoodSearchTimedOut = true
                self.isFoodSearchLoading = false // << stop displaying loader
            }
            
                task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                        //HANDLE ERROR
                        if let error = error {
                            DispatchQueue.main.async {
                                self.isFoodSearchLoading = false
                            }
                            
                            return
                        }
                        //if network timed out, stop fetching the api
                        if self.isFoodSearchTimedOut {
                            DispatchQueue.main.async {
                                self.isFoodSearchLoading = false
                            }
                            self.task!.cancel()
                           
                            return
                        }
                      
                        
                       let searchResults = try! JSONDecoder().decode(FoodData.self, from: data!)
                        
                        // << resets counter on search
                        DispatchQueue.main.async { [self] in
                            self.timer?.invalidate() // stop network timer
                                for item in searchResults.foods ?? []{
                                    if foodResultsDisplayed < 50 { // << show six foods on screen
                                       
                                        // if index out of value solution
                                        if item.foodNutrients!.count <= 0{
                                            isFoodSearchLoading = false
                                            return
                                        }
                                        // << if food nutrients is valid
                                            foodResultsDisplayed = 6 // << food to display
                                      
                                        //convert the macros
                                            let proteinConverted = convertMacros(macro: Double(round(item.foodNutrients?[0].value! ?? 0.00)), servingSize: item.servingSize ?? 1.00, unitSizing: item.servingSizeUnit)
                                            let carbsConverted = convertMacros(macro: Double(round(item.foodNutrients?[2].value! ?? 0.00)), servingSize: item.servingSize ?? 1.00, unitSizing: item.servingSizeUnit)
                                            
                                            
                                            let fatConverted = convertMacros(macro: Double(round(item.foodNutrients?[2].value! ?? 0.00)), servingSize: item.servingSize ?? 1.00, unitSizing: item.servingSizeUnit)
                                            
                                         
                                            let caloriesConverted = convertMacros(macro: Double(round(item.foodNutrients?[3].value! ?? 0.00)), servingSize: item.servingSize ?? 1.00, unitSizing: item.servingSizeUnit)
                                            
                                            if caloriesConverted > 5 {
                                               
                                                self.userSearchResults.append(Meal(
                                                    id: UUID(),
                                                    brand: item.brandOwner?.lowercased().firstCapitalized ?? "Generic",
                                                    //note padding on mealName cuts string off at 18 char, preventing sloppy UI if long meal name
                                                    mealName: item.foodDescription?.lowercased().firstCapitalized.padding(toLength: 18, withPad: " ", startingAt: 0) ?? "food invalid",
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
            task!.resume()
        }
        else{
            print("custom search")
        }
    }
   
}


