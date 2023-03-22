//
//  PillBoxExercise.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/20/23.
//not used in app as of yet

import SwiftUI

struct PillBoxExercise: View {
    var exercisePreferences: [String]
    var body: some View {
        HStack (spacing: -10){
           
            ForEach(exercisePreferences, id: \.self){ exercise in
                GeometryReader { geometry in
                    ZStack {
                        Text(exercise)
                            .padding([.leading, .trailing], 10)
                            .font(.caption)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("graySettingsPillbox"))
                            )

                        Button(action: {
                            // Handle delete button action here
                            // You can remove the exercise from the model or display a confirmation dialog, for example
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding(5)
                        })
                        .frame(width: 7, height: 7)
                        .background(Color("graySettingsPillbox"))
                        .clipShape(Circle())
                        .position(x: geometry.size.width/1.3, y: geometry.size.height / 6.0)
                       
                    }
                    
                }
              
            }
           
                .padding(0)
        }
      
    }
}

struct PillBoxExercise_Previews: PreviewProvider {
    static var previews: some View {
        PillBoxExercise(exercisePreferences: ["Bodybuilding", "Dancing", "Casual"])
    }
}
