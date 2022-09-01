//
//  NutrionalPieChart.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/24/22.
//

import SwiftUI

struct NutrionalPieChart: View {
    var pieSliceData: PieSliceData
    
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
                if pieSliceData.text == "0%"{ // << if 0%, don't show in piechart
                    Text("")
                }
                else{
                    Text(pieSliceData.text).bold() // << text inside piechart
                        .position(
                            x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.60 * cos(self.midRadians)),
                            y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.60 * sin(self.midRadians))
                        )
                        .foregroundColor(Color.white)
                        .font(.body)
                }   
            }
        }
        .aspectRatio(1, contentMode: .fit)
        
    }
        
}

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}



struct NutrionalPieChart_Previews: PreviewProvider {
    static var previews: some View {
        NutrionalPieChart(pieSliceData: PieSliceData(startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 220.0), text: "65%", color: Color.black))
    }
}