//
//  GetWeight.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/4/22.
//

import SwiftUI

class getWeight{
    func weightArray() -> Array <String> {
        var arr = [90]
        for index in 80...500 {
            arr.append(index)
        }
        let newArr = arr.map {String($0)}
        return newArr
    }    
}
