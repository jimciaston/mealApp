//
//  DashboardRouter.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/14/22.
//

import Foundation
import SwiftUI

enum DashboardTab{
    case home
    case journal
    case recipes
    case searchUsers
    case addRecipes
    case addMeal
}
//Tab Router for Application
class DashboardRouter: ObservableObject{
    @Published var currentTab: DashboardTab = .home
    @Published var isPlusMenuOpen = false
    
   
}
