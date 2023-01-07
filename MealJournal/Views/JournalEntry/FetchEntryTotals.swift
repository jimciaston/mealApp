//
//  fetchEntryTotals.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/12/22.
//

import Foundation
import SwiftUI

class FetchEntryTotals: ObservableObject{
    
    @Published var totalCalories = 0
    @Published var totalFat = 0
    @Published var totalProtein = 0
    @Published var totalCarbs = 0
    
    func fetchCalorieTotals(journalEntrys: FetchedResults<JournalEntry>, dayOfWeek: String) {
        totalCalories = 0
        for entry in journalEntrys {
            if entry.dayOfWeekCreated == dayOfWeek {
                totalCalories += Int(entry.mealCalories!)
            }
        }
    }
    func fetchProteinTotals(journalEntrys: FetchedResults<JournalEntry>, dayOfWeek: String) {
        totalProtein = 0
        for entry in journalEntrys {
            if entry.dayOfWeekCreated == dayOfWeek {
                totalProtein += Int(entry.mealProtein!)
            }
        }
    }
    func fetchCarbTotals(journalEntrys: FetchedResults<JournalEntry>, dayOfWeek: String) {
        totalCarbs = 0
        for entry in journalEntrys {
            if entry.dayOfWeekCreated == dayOfWeek {
                totalCarbs += Int(entry.mealCarbs!)
            }
        }
    }
    func fetchFatTotals(journalEntrys: FetchedResults<JournalEntry>, dayOfWeek: String) {
        totalFat = 0
        for entry in journalEntrys {
            if entry.dayOfWeekCreated == dayOfWeek {
                totalFat += Int(entry.mealFat!)
            }
        }
    }
}



