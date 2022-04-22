//
//  USDAFoodData.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/19/22.
//

import Foundation

class USDAFoodData{
    
    enum NetworkError: Error{
        case badURL
        case badID
    }
    
    func FoodSearch (userItem: String){
        let urlEncoded = userItem.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        //constructing URL
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nal.usda.gov/fdc/v1/foods/search"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "bRbzV0uKJyenEtd1GMgJJNh4BzGWtDvDZVOy8cqG"),
            URLQueryItem(name: "query", value: userItem)
        ]
        
        let searchResults = try! JSONDecoder().decode(FoodData.self, from: data!)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
            throw NetworkError.badID
        }
        
        let foodResponse = try? JSONDecoder().decode(FoodData.self, from: data)
        return foodResponse
    }
}
