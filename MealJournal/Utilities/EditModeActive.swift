//
//  EditModeActive.swift
//  MealJournal
//
//  Created by Jim Ciaston on 7/9/22.
//

import Foundation
import SwiftUI

class EditModeActive: ObservableObject {
    @Published var editMode: Bool = false
        //user added ingredients during edit mode
    @Published var updatedIngredients: [String: String] = [:]
    //user added directions during edit mode
    @Published var updatedDirections: [String] = []
    //connects with recipeController
    @Published var isIngredientsActive = false
    //connects with recipeController
    @Published var isDirectionsActive = false
    
    //recipe macros and dash headers
    @Published var recipeTitle = ""
    @Published var recipePrepTime = ""
    @Published var recipeFatMacro = 0
    @Published var recipeCarbMacro = 0
    @Published var recipeProteinMacro = 0
    @Published var recipeImage = ""
    
    
}
