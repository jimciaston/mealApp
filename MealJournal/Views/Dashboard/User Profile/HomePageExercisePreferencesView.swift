//
//  HomePageExercisePreferencesView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/19/23.
//

import SwiftUI

struct HomePageExercisePreferencesView: View {
 var exercisePreferences: [String]
    var exerciseColorSelector = ExercisePreferenceForUser()
    var body: some View {
        HStack{
            ForEach (exercisePreferences, id: \.self)  { exercise in
                ZStack {
                    Text(exercise)
                        .padding([.leading, .trailing], 10)
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

//struct HomePageExercisePreferencesView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePageExercisePreferencesView()
//    }
//}
