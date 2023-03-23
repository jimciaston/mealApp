//
//  HomePageExercisePills_NonUser.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/23/23.
//

import SwiftUI

struct HomePageExercisePills_NonUser: View {
 var exercisePreferences: [String]
    var exerciseColorSelector = ExercisePreferenceForUser()
    var body: some View {
        HStack{
            ForEach (exercisePreferences, id: \.self)  { exercise in
                ZStack {
                    Text(exercise)
                        .padding([.leading, .trailing], 5)
                        .font(.caption)
                        .foregroundColor(.white)
                        .background(
                               RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(exerciseColorSelector.exerciseSelectionColor(exercise))
                           )
                        }
                    }
                }
      
       
            }
        }
//struct HomePageExercisePills_NonUser_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePageExercisePills_NonUser(exercisePreferences: ["Bodybuilding", "calibouenru"])
//    }
//}
