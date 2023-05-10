//
//  NutrionalPieChartView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/24/22.
//

import SwiftUI

struct NutrionalPieChartView: View {
    @Environment (\.colorScheme) var colorScheme
    @EnvironmentObject var mealEntryObj: MealEntrys
    var dailyMacrosCounter = DailyMacrosCounter()
    public let totalCalories: Double
    public var meals: String {
        get{
            (dailyMacrosCounter.getCarbTotals(
                breakfast: mealEntryObj,
                lunch: mealEntryObj,
                dinner: mealEntryObj, snack: mealEntryObj))
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
        var counter = 0
       
        for (i, value) in values.enumerated(){
            if value != 0.0 {
                      counter += 1
                  }
            
            let degrees: Double = value * 360 / sum
                tempSlices.append(
                    PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees),
                           text: String(format:"%.0f%%", value * 100 / sum ), color: colors[i], value: value, counter: counter))
                endDeg += degrees
        }
        return tempSlices
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<self.values.count){ i in
                        NutrionalPieChart(pieSliceData: self.slices[i], totalCalories: totalCalories)
                    }
                    //adjust size
                    .frame(width: geometry.size.width - 70, height: 250)
                  
                }
               

                //rows at bottom of piechart
                    PieChartHelperRows(
                        colors: self.colors,
                        names: self.names,
                        values: self.values.map { String(format: "%.0f", $0) + "g" },
                        percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) })
                   
                
                .background(self.backgroundColor)
                .foregroundColor(colorScheme == .dark ? .gray : .black)
     
            }
        }
    }
   
}


///NOTICED BUG WHEN FOOD HAS 0%. WILL CORRECT LATER UPDATE

//struct NutrionalPieChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        NutrionalPieChartView(values: [05,5,10], colors: [Color.PieChart1, Color.green, Color.orange], names: ["Protein", "Carbohydrates", "Fats"], backgroundColor: .white)
//    }
//}
