//
//  APITest.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/28/22.
//

import SwiftUI
import Foundation
// MARK: - Food
//struct Food: Codable {
//    let fdcID: Int
//    let foodDescription, publicationDate: String
//    let foodNutrients: [FoodNutrient]
//
//    enum CodingKeys: String, CodingKey {
//        case fdcID = "fdcId"
//        case foodDescription = "description"
//        case publicationDate, foodNutrients
//    }
//}
//
//// MARK: - FoodNutrient
//struct FoodNutrient: Codable {
//    let type: String
//    let nutrient: Nutrient
//}
//
//// MARK: - Nutrient
//struct Nutrient: Codable {
//    let id: Int
//    let number, name: String
//    let rank: Int
//    let unitName: String
//}
//
//class GetFoodApi {
//    func getFood (){
//        guard let url = URL(string: "https://api.nal.usda.gov/fdc/v1/food/748967?api_key=bRbzV0uKJyenEtd1GMgJJNh4BzGWtDvDZVOy8cqG") else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            let results = try! JSONDecoder().decode(Food.self, from: data!)
////            for item in posts.foodNutrients{
////                print(item.type)
////            }
//            
//            print(results)
//        }
//        .resume()
//    }
//    
//}



