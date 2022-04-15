//
//  CapitalFirstLetter.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/14/22.
//

import Foundation

extension StringProtocol {
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
