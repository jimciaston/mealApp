//
//  PieChartHelperRows.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/24/22.
//

import SwiftUI

struct PieChartRow: View {
    var index: Int
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]

    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 5.0)
                .fill(self.colors[index])
                .frame(width: 20, height: 20)
                .padding(.leading, 20)

            Text(self.names[index])
                .padding(.leading, 10)

            Spacer()

            HStack{
                Text(self.values[index]) // << in grams
                    .alignmentGuide(.leading) { _ in 5}
                   
                Text(self.percents[index]) // << in percentage
                    .foregroundColor(Color.gray)
                    .alignmentGuide(.leading) { d in d[.leading] }
                    //.padding(.leading, 15)
                    .frame(width:60)
                   
                   
            }
           
            .padding(.trailing, 25)
        }
    }
}

struct PieChartHelperRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        VStack{
            ForEach(0..<self.values.count, id: \.self) { i in
                PieChartRow(index: i, colors: self.colors, names: self.names, values: self.values, percents: self.percents)
            }
        }
    }
}







//struct PieChartHelperRows_Previews: PreviewProvider {
//    static var previews: some View {
//        PieChartHelperRows()
//    }
//}
