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
                    return Color("olympic")
                case "Bodyweight":
                    return .blue
                
                case "BJJ":
                    return Color("sports")
                case "Gymnastics":
            return Color("gymnastics")
                case "Boxing":
                    return Color("boxing")
                case "Calisthenics":
                    return .green
                case "Casual":
                    return Color("sports")
                case "Circuit training":
                    return .yellow
                case "CrossFit":
                    return Color("crossfit")
                case "Cycling":
                    return .blue
                case "Kickboxing":
                    return Color("boxing")
                case "Dance":
                    return .purple
                case "Functional fitness training":
                    return Color("running")
                case "HIIT":
                    return .orange
                case "Martial arts":
                    return .black
                case "Olympic":
                    return .yellow
                case "Pilates":
                    return Color("yoga")
                case "Plyometrics":
                    return Color("running")
                case "Running":
                    return Color("cardio")
                case "Sports Training":
                    return Color("sports")
                case "Strength Training":
                    return Color("olympic")
                case "Swimming":
                    return Color("water")
            
                case "Water Aerobics":
                    return Color("water")
                case "Yoga":
                    return Color("yoga")
                case "Zumba":
                    return .purple
                default:
                    return Color("defaultColorForExercise")
            
        }
    }
    
}
