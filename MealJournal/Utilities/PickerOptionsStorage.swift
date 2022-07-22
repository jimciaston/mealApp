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
