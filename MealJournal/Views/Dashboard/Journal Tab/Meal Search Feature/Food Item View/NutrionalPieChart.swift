//
//  NutrionalPieChart.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/24/22.
//

import SwiftUI



struct NutrionalPieChart: View {
    var pieSliceData: PieSliceData
    var totalCalories: Double
    @State var convertCaloriesToString = ""
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    
                    path.move(to: center)
                    
                    path.addArc(
                        center: center,
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                        clockwise: false)
                    
                }
                .fill(pieSliceData.color)
                
                //TOUCH GFFLOAT TO UPDATE POSITION OF PERCENTAGES IN CIRCLE
                if pieSliceData.value == 0.0 { // << if 0, don't show in piechart
                    Text("")
                }
                else{
                    Circle()
                       .stroke(lineWidth: 4)
                       .frame(width: 110, height: 110)
                       .foregroundColor(.white)
                    //display calories in middle of circle
                    Text("Calories: \(String(Int(totalCalories)))")
                        .font(.title3)
                        .bold()
                        .frame(width:170, height: 170)
                        .background(Circle().fill(Color.white))
                        
                }   
            }
        }
        .aspectRatio(1, contentMode: .fit)
        
        .onAppear{
            convertCaloriesToString = String(String(totalCalories).split(separator: ".")[0])
        }
    }
        
}

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
    var value: Double // << grabs grams of food to display in pie chart
    var counter: Int // << keep track of how many values are present in a Food Item
}


//
//struct NutrionalPieChart_Previews: PreviewProvider {
//    static var previews: some View {
//        NutrionalPieChart(pieSliceData: PieSliceData(startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 220.0), text: "65%", color: Color.black, value: 3.0, counter: 2))
//    }
//}
