//
//  Search_Food_Model.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/2/22.
//

import Foundation
import SwiftUI
struct APISearchResults: Codable {
    let totalHits, currentPage, totalPages: Int?
    let pageList: [Int]?
    let foodSearchCriteria: FoodSearchCriteria?
    let foods: [Food]?
    let aggregations: Aggregations?
}

// MARK: - Aggregations
struct Aggregations: Codable {
    let dataType: DataType?
    let nutrients: Nutrients?
}

// MARK: - DataType
struct DataType: Codable {
    let branded, srLegacy, surveyFNDDS, foundation: Int?
    let experimental: Int?

    enum CodingKeys: String, CodingKey {
        case branded = "Branded"
        case srLegacy = "SR Legacy"
        case surveyFNDDS = "Survey (FNDDS)"
        case foundation = "Foundation"
        case experimental = "Experimental"
    }
}

// MARK: - Nutrients
struct Nutrients: Codable {
}

// MARK: - FoodSearchCriteria
struct FoodSearchCriteria: Codable {
    let query: String?
    let pageNumber, numberOfResultsPerPage, pageSize: Int?
    let requireAllWords: Bool?
}

// MARK: - Food
struct Food: Codable {
    let fdcID: Int?
      let foodDescription, lowercaseDescription, dataType, gtinUpc: String?
      let publishedDate, brandOwner, ingredients, marketCountry: String?
      let foodCategory, modifiedDate, dataSource, servingSizeUnit: String?
      let servingSize: Double?
      let householdServingFullText, allHighlightFields: String?
      let score: Double?
      let foodNutrients: [FoodNutrient]?
      let finalFoodInputFoods, foodMeasures, foodAttributes: [JSONAny]?
      let foodAttributeTypes: [FoodAttributeType]?
      let foodVersionIDS: [JSONAny]?
      let brandName: String?
 
    enum CodingKeys: String, CodingKey {
        case fdcID = "fdcId"
        case foodDescription = "description"
        case lowercaseDescription, dataType, gtinUpc, publishedDate, brandOwner, ingredients, marketCountry, foodCategory, modifiedDate, dataSource, servingSizeUnit, servingSize, householdServingFullText, allHighlightFields, score, foodNutrients, finalFoodInputFoods, foodMeasures, foodAttributes, foodAttributeTypes
        case foodVersionIDS = "foodVersionIds"
        case brandName
    }
}

// MARK: - FinalFoodInputFood
struct FinalFoodInputFood: Codable {
    let foodDescription: String?
    let portionCode, portionDescription, unit: String?
    let rank, srCode, value: Int?
}

// MARK: - FoodAttributeType
struct FoodAttributeType: Codable {
    let name, foodAttributeTypeDescription: String?
    let id: Int?
    let foodAttributes: [FoodAttribute]?

    enum CodingKeys: String, CodingKey {
        case name
        case foodAttributeTypeDescription = "description"
        case id, foodAttributes
    }
}

// MARK: - FoodAttribute
struct FoodAttribute: Codable {
    let value: String?
    let id, sequenceNumber: Int?
    let name: String?
}

// MARK: - FoodMeasure
struct FoodMeasure: Codable {
    let disseminationText: String?
    let gramWeight, id: Double?
    let modifier: String?
    let rank: Int?
    let measureUnitAbbreviation, measureUnitName: String?
    let measureUnitID: Int?

    enum CodingKeys: String, CodingKey {
        case disseminationText, gramWeight, id, modifier, rank, measureUnitAbbreviation, measureUnitName
        case measureUnitID = "measureUnitId"
    }
}

// MARK: - FoodNutrient
struct FoodNutrient: Codable {
    let nutrientID: Int?
    let nutrientName, nutrientNumber: String?
    //let unitName: UnitName?
    let value: Double?
    let rank, indentLevel, foodNutrientID: Int?

    enum CodingKeys: String, CodingKey {
        case nutrientID = "nutrientId"
        case nutrientName, nutrientNumber, value, rank, indentLevel
        case foodNutrientID = "foodNutrientId"
    }
}

extension URL {

    /// Adds a query item to a URL
    public func queryItem(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
    
    /// Retrieves the query items of a URL
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
            return queryItems.reduce(into: [String: String]()) { (result, item) in
                result[item.name] = item.value
            }
    }

}

class FoodApiSearch: ObservableObject{
    @Published var userSearchResults: [Meal] = Array()
    @Published var foodUnit = ""
    @Published var calories = ""
    @Published var brand = ""
    
    //will search for user Input
    func searchFood(userItem: String){
       ///IMPROVE API FUNCTION LATER ON DURING LAUNCH
        ///
        let urlEncoded = userItem.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
           guard
                let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?&api_key=bRbzV0uKJyenEtd1GMgJJNh4BzGWtDvDZVOy8cqG&query=\(urlEncoded!)") else {return}
                URLSession.shared.dataTask(with: url) { (data, _,_) in
                    let searchResults = try! JSONDecoder().decode(APISearchResults.self, from: data!)   
                    DispatchQueue.main.async { [self] in
                        var counter = 0
                            for item in searchResults.foods ?? []{
                                if (counter < 5){
                                    self.userSearchResults.append(Meal(
                                        id: UUID(),
                                        brand: item.brandOwner?.lowercased().firstCapitalized ?? "Brand Unavailable",
                                        mealName: item.lowercaseDescription?.firstCapitalized ?? "food invalid",
                                        calories: String(Double(round(item.foodNutrients?[3].value! ?? 0.00)).removeZerosFromEnd()),
                                        quantity: 2,
                                        amount: "test",
                                        protein: 2,
                                        carbs: 2,
                                        fat: 2)
                                    )
                                    counter += 1
                                }
                                else{return}
                }
                   
            }
        }
        .resume()
    }
   
}

