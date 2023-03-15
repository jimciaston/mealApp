//
//  SettingsView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/2/22.
//

import SwiftUI

//All exercise selections a user can make
class ExercisePreferenceForUser {
    let exercises = [
        "Barre",
        "Bodybuilding",
        "Bodyweight training",
        "Bootcamp-style training",
        "Boxing or kickboxing fitness classes",
        "Calisthenics",
        "Casual",
        "Circuit training",
        "CrossFit",
        "Cycling",
        "Dance",
        "Functional fitness training",
        "HIIT",
        "Martial arts",
        "Olympic weightlifting",
        "Pilates",
        "Plyometrics",
        "Running",
        "Sports Training",
        "Strength training",
        "Swimming",
        "TRX training",
        "Water aerobics",
        "Yoga",
        "Zumba"
 ]
    func exerciseSelectionColor(_ exerciseTypeSelection: String) -> Color {
        switch exerciseTypeSelection {
            case "Barre":
                    return .pink
                case "Bodybuilding":
                    return .red
                case "Bodyweight training":
                    return .blue
                case "Bootcamp-style training":
                    return .orange
                case "Boxing or kickboxing fitness classes":
                    return .purple
                case "Calisthenics":
                    return .green
                case "Casual":
                    return .gray
                case "Circuit training":
                    return .yellow
                case "CrossFit":
                    return .red
                case "Cycling":
                    return .blue
                case "Dance":
                    return .purple
                case "Functional fitness training":
                    return .green
                case "HIIT":
                    return .orange
                case "Martial arts":
                    return .black
                case "Olympic weightlifting":
                    return .yellow
                case "Pilates":
                    return .pink
                case "Plyometrics":
                    return .red
                case "Running":
                    return .blue
                case "Sports Training":
                    return .purple
                case "Strength training":
                    return .green
                case "Swimming":
                    return .blue
                case "TRX training":
                    return .yellow
                case "Water aerobics":
                    return .blue
                case "Yoga":
                    return .pink
                case "Zumba":
                    return .purple
                default:
                    return .gray
            
        }
    }
    
}
