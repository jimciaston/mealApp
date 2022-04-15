//
//  Search_Food_Model.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/2/22.
//

import Foundation
import SwiftUI

//main structure of food structs
struct APISearchResults: Codable {
    let totalHits, currentPage, totalPages: Int
    let pageList: [Int]
    //let foodSearchCriteria: FoodSearchCriteria
    let foods: [FoodCoreInfo]
}

// MARK: - FoodSearchCriteria
//struct FoodSearchCriteria: Codable {
//    let dataType: [Any]
//    let query, generalSearchInput: String
//    let pageNumber, numberOfResultsPerPage, pageSize: Int
//    let requireAllWords: Bool
//}

// MARK: - Food
struct FoodCoreInfo: Codable {
    let fdcID: Int
    let foodDescription, lowercaseDescription, commonNames, additionalDescriptions: String?
    let dataType: String
    let ndbNumber: Int?
    let publishedDate, foodCategory, allHighlightFields: String
    let score: Double
    let foodNutrients: [FoodNutrientInformation]

    enum CodingKeys: String, CodingKey {
        case fdcID = "fdcId"
        case foodDescription = "description"
        case lowercaseDescription, commonNames, additionalDescriptions, dataType, ndbNumber, publishedDate, foodCategory, allHighlightFields, score, foodNutrients
    }
}

// MARK: - FoodNutrient
struct FoodNutrientInformation: Codable {
    let nutrientID: Int?
    let nutrientName, nutrientNumber, unitName, derivationCode: String
    let derivationDescription: String?
    let derivationID: Int?
    let value: Double?
    let foodNutrientSourceID: Int?
    let foodNutrientSourceCode, foodNutrientSourceDescription: String?
    let rank, indentLevel, foodNutrientID, dataPoints: Int?

    enum CodingKeys: String, CodingKey {
        case nutrientID = "nutrientId"
        case nutrientName, nutrientNumber, unitName, derivationCode, derivationDescription
        case derivationID = "derivationId"
        case value
        case foodNutrientSourceID = "foodNutrientSourceId"
        case foodNutrientSourceCode, foodNutrientSourceDescription, rank, indentLevel
        case foodNutrientID = "foodNutrientId"
        case dataPoints
    }
}


class FoodApiSearch: ObservableObject{
    @Published var foodDescription = ""
    @Published var foodUnit = ""
    @Published var calories = ""
    
    //will search for user Input
    func searchFood(userItem: String){
       //calls api search
        guard let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(userItem)&dataType=&pageSize=1&pageNumber=1&api_key=bRbzV0uKJyenEtd1GMgJJNh4BzGWtDvDZVOy8cqG") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _,_) in
            let searchResults = try! JSONDecoder().decode(APISearchResults.self, from: data!)
            
            DispatchQueue.main.async {
                for item in searchResults.foods{
                    self.foodDescription = item.lowercaseDescription?.firstCapitalized ?? "food not valid"
                    self.calories = String(Double(round(item.foodNutrients[3].value!)).removeZerosFromEnd())
                   
                      //  print(self.foodDescription)
                    print(item.foodNutrients[0].nutrientName)
                    print(item.foodNutrients[1].nutrientName)
                    print(item.foodNutrients[2].nutrientName)
                    print(item.foodNutrients[3].nutrientName)
                   
                    }
               
                }
        }
        .resume()
    }
}

