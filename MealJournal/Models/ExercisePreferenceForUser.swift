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
        "Bodybuilding",
        "Bodyweight",
        "Boxing",
        "BJJ",
        "Casual",
        "Circuit",
        "CrossFit",
        "Cycling",
        "Dance",
        "Gymnastics",
        "HIIT",
        "Kickboxing",
        "Martial Arts",
        "Olympic",
        "Pilates",
        "Plyometrics",
        "Running",
        "Sports Training",
        "Strength",
        "Swimming",
        "Water Aerobics",
        "Walking",
        "Yoga",
        "Zumba"
 ]
    func exerciseSelectionColor(_ exerciseTypeSelection: String) -> Color {
        switch exerciseTypeSelection {
                case "Bodybuilding":
                    return Color("UserProfileCard2")
                case "Bodyweight":
                    return Color("UserProfileCard2")
                
                case "BJJ":
                    return Color("UserProfileCard2")
                case "Gymnastics":
            return Color("UserProfileCard2")
                case "Boxing":
                    return Color("UserProfileCard2")
                case "Calisthenics":
                    return Color("UserProfileCard2")
                case "Casual":
                    return Color("UserProfileCard2")
                case "Circuit training":
                    return Color("UserProfileCard2")
                case "CrossFit":
                    return Color("UserProfileCard2")
                case "Cycling":
                    return Color("UserProfileCard2")
                case "Kickboxing":
                    return Color("UserProfileCard2")
                case "Dance":
                    return Color("UserProfileCard2")
                case "Functional fitness training":
                    return Color("UserProfileCard2")
                case "HIIT":
                    return Color("UserProfileCard2")
                case "Martial arts":
                    return Color("UserProfileCard2")
                case "Olympic":
                    return Color("UserProfileCard2")
                case "Pilates":
                    return Color("UserProfileCard2")
                case "UserProfileCard2":
                    return Color("UserProfileCard2")
                case "Running":
                    return Color("UserProfileCard2")
                case "Sports Training":
                    return Color("UserProfileCard2")
                case "Strength Training":
                    return Color("UserProfileCard2")
                case "Swimming":
                    return Color("UserProfileCard2")
            
                case "Water Aerobics":
                    return Color("UserProfileCard2")
                case "Yoga":
                    return Color("UserProfileCard2")
                case "Zumba":
                    return Color("UserProfileCard2")
                default:
                    return Color("UserProfileCard2")
            
        }
    }
    
}
