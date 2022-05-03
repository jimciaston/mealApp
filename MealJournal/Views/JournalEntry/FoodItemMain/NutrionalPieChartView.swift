//
//  NutrionalPieChartView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/24/22.
//

import SwiftUI

struct NutrionalPieChartView: View {
    var dailyMacrosCounter = DailyMacrosCounter()
    @EnvironmentObject var mealEntryObj: MealEntrys
    
   public var a: String {
        get{
            (dailyMacrosCounter.getCarbTotals(
                breakfast: mealEntryObj,
                lunch: mealEntryObj,
                dinner: mealEntryObj))
        }
    }
    public let values: [Double]
    public var colors: [Color]
    public let names: [String]
    
    public var backgroundColor: Color
    
    let macroCount = DailyMacrosCounter()
    
    var slices: [PieSliceData]{
        let sum = values.reduce(0,+)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated(){
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format:"%.0f%%", value * 100 / sum ), color: colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<self.values.count){ i in
                        NutrionalPieChart(pieSliceData: self.slices[i])
                    }
                    //adjust size
                    .frame(width: geometry.size.width - 80, height: geometry.size.width)
                }
                
                    PieChartHelperRows(
                        colors: self.colors,
                        names: self.names,
                        values: self.values.map { String($0) },
                        percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) })
                
                
                .background(self.backgroundColor)
                .foregroundColor(Color.black)
            }
        }
    }
   
}

struct NutrionalPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        NutrionalPieChartView(values: [05,5,10], colors: [Color.blue, Color.green, Color.orange], names: ["Protein", "Carbohydrates", "Fats"], backgroundColor: .white)
    }
}
