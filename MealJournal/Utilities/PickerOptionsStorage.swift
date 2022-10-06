//
//  PickerOptionsStorage.swift
//  MealJournal
//
//  Created by Jim Ciaston on 7/20/22.
//

import Foundation

public func pickerGramCounter() -> [Int]{
    let x = (1...200)
    var gramStorage = [0]
    for num in x {
        
        gramStorage.append(num)
    }
    return gramStorage
}
public func calorieCounter() -> [Int]{
    let x = (1...1000)
    var calStorage = [0]
    for num in x {
        
        calStorage.append(num)
    }
    return calStorage
}
