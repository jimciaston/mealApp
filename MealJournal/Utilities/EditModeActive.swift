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
    @Published var updatedIngredients: [String: String] = [:]
}
