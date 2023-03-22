//
//  ExercisePreferencesSettings.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/20/23.
//

import SwiftUI

struct ExercisePreferenceSettingsTab: View {
    var tags: [String]
    var exercisePreferenceForUser = ExercisePreferenceForUser()
    @Binding var selectedExercises: [String]
    @State private var totalHeight
        = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
     
        .frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
       
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
               
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .onTapGesture {
                       
                        if selectedExercises.contains(tag) {
                            selectedExercises.removeAll { $0 == tag }
                                }
                        else {
                            if selectedExercises.count < 3{
                                selectedExercises.append(tag)
                            }
                        }
                    }
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                           {
                               width = 0
                               height -= d.height
                           }
                        let result = width
                        
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String) -> some View {
        HStack {
            ZStack{
                Text(text)
                    .padding([.leading, .trailing], 10)
                    .font(.body)
                    .background(selectedExercises.contains(text) ?
                        .gray :
                        Color("UserProfileCard2")
                    )
                    .foregroundColor(Color.white)
                    .cornerRadius(5)

                Spacer()
                if selectedExercises.contains(text){
                    Button(action: {
                        selectedExercises.removeAll(where: { $0 == text })
                    }) {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .symbolVariant(.circle)
                            .foregroundStyle(.white, .gray)
                            
                    }
                    .frame(width:10, height: 10)
                    .offset(x: 20, y: -15)
                }
              
            }
            .padding(.vertical, 2)
           
            }
           
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}


struct FitnessInterestsSettingsTab: View {
    @Binding var selectedExercises: [String]
    var exercises: [String]
    
    var body: some View {
        VStack{
            ExercisePreferenceSettingsTab(tags: exercises, selectedExercises: $selectedExercises)
        }
    }
}

//struct ExercisePreferenceSettingsTab_Previews: PreviewProvider {
//    static var previews: some View {
//        let selectedSkills = Binding<[String]>(
//            get: { ["Skill A"] },
//            set: { _ in }
//        )
//        return FitnessInterests( selectedExercises: .constant(["f"]), exercises: [
//      "Bodybuilding",
//      "Bodyweight",
//      "Bootcamp",
//      "Boxing",
//      "Calisthenics",
//      "Casual",
//      "Circuit training",
//      "CrossFit",
//      "Cycling",
//      "Dance",
//      "HIIT",
//      "Kickboxing",
//      "Martial arts",
//      "Olympic weightlifting",
//      "Pilates",
//      "Plyometrics",
//      "Running",
//      "Sports Training",
//      "Strength training",
//      "Swimming",
//      "TRX training",
//      "Water aerobics",
//      "Yoga",
//      "Zumba"])
//    }
//}
