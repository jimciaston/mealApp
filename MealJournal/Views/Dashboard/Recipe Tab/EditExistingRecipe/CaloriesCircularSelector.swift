//
//  CaloriesCircularSelector.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/26/23.
//

import SwiftUI

struct CaloriesCircularSelector: View {
    @Environment (\.colorScheme) var colorScheme
    @State var calorieValue: CGFloat = 0.0
    @State var angleValue: CGFloat = 0.0
    @State private var isDragging = false
    @State private var stopGesture = false
    @State var prevCalorieValue: CGFloat = 0.0
    @State private var reachedMaxAngle = false
    @State var movingForward = false
    @State var movingBackwards = false
    @State var previousValueYLocation: CGFloat = 0.0
    
    @Binding var selectedCalories: Int
    @Binding var showingCircularSelector: Bool
    let config = ConfigCircular(
                minimumValue: 0.0,
                maximumValue: 1499.0,
                totalValue: 1500.0,
                knobRadius: 15.0,
                radius: 125.0)
    var body: some View {
        VStack{
            ZStack {
                
                Circle()
                    .fill(Color("LighterWhite"))
                    .frame(width: config.radius * 2, height: config.radius * 2)
                    .scaleEffect(1.2)
                 
                Circle()
                    .trim(from: 0.0, to: calorieValue/config.totalValue)
                    .stroke(Color("PieChart1"), lineWidth: 15)
                    .frame(width: config.radius * 2, height: config.radius * 2)
                    .rotationEffect(.degrees(-90))
                
                Circle()
                    .fill(isDragging ? Color("UserProfileCard2") : Color("ButtonTwo"))
                    .frame(width: config.knobRadius * 2, height: config.knobRadius * 2)
                    .padding(10)
                    .offset(y: -config.radius)
                    .rotationEffect(Angle.degrees(Double(angleValue)))
                    .gesture(
                       DragGesture(minimumDistance: 0.2)
                           .onChanged { value in
                               isDragging = true // Set isDragging to true when the user starts dragging
                               
                               if !reachedMaxAngle && prevCalorieValue <= calorieValue {
                                   change(location: value.location) // << controls movement of knob
                                   
                                   let generator = UIImpactFeedbackGenerator(style: .soft)
                                                                     generator.impactOccurred()
                               }
                               else if previousValueYLocation < value.location.y {
                                   change(location: value.location) // << controls movement of knob
                                   
                                  
                               }
                               previousValueYLocation = value.location.y // << track prev location
                              
                           }
                           .onEnded { _ in
                               isDragging = false // Set isDragging to false when the user stops dragging
                           }
                   )
                
                Text(!reachedMaxAngle ? "\(String.init(format: "%.0f", calorieValue)) cals" : "1500+ cals")
                    .font(.custom("Montserrat-Regular", size: 40))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                
            }
            .onChange(of: self.calorieValue) { newValue in
                       
                
                // Check if the user is moving forward or backward
                           if newValue > prevCalorieValue {
                               movingForward = true
                               movingBackwards = false
                               print("Moving forward")
                           } else if newValue < prevCalorieValue {
                               movingForward = false
                               reachedMaxAngle = false
                               movingBackwards = true
                               print("Moving backward")
                           }
                           prevCalorieValue = newValue
                    }
            Button(action: {
              selectedCalories = Int(reachedMaxAngle ? 1500 : calorieValue.rounded())
            showingCircularSelector = false
            }){
                Text("Calories Confirmed")
                    .font(.title3)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .frame(width: 200, height: 50)
                    .overlay( RoundedRectangle(cornerRadius: 10)
                      .stroke(Color("GetStartedPopUpBackground"), lineWidth: 2)
                 )
                   
            }
            .padding(.top, 50)
        }
                
    }
    
    private func change(location: CGPoint) {
       // creating vector from location point
       let vector = CGVector(dx: location.x, dy: location.y)

       let angle = atan2(vector.dy - (config.knobRadius + 10), vector.dx - (config.knobRadius + 10)) + .pi/2.0

       let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle

       let value = fixedAngle / (2.0 * .pi) * config.totalValue

       if value >= config.minimumValue && value <= config.maximumValue {
           // Check if the angleValue is about to cross 200 degrees
           let newAngleValue = fixedAngle * 180 / .pi
           if newAngleValue >= 345 && movingForward {
               reachedMaxAngle = true
               return
           }
               calorieValue = value
               angleValue = newAngleValue
           
           // Update the calorieValue and angleValue
          
       }
   }
}

struct ConfigCircular {
    let minimumValue: CGFloat
    let maximumValue: CGFloat
    let totalValue: CGFloat
    let knobRadius: CGFloat
    let radius: CGFloat
}

//struct CaloriesCircularSelector_Previews: PreviewProvider {
//    static var previews: some View {
//        CaloriesCircularSelector()
//    }
//}
