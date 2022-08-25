//
//  PieChartHelperRows.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/24/22.
//

import SwiftUI

struct PieChartHelperRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        ForEach(0..<self.values.count){ i in
            HStack{
                RoundedRectangle(cornerRadius: 5.0)
                    .fill(self.colors[i])
                    .frame(width: 20, height: 20)
                    .padding(.leading, 20)
                
                Text(self.names[i])
                    .padding(.leading, 10)
                
                Spacer()
                
                VStack(alignment: .trailing){
                    Text(self.values[i])
                    Text(self.percents[i])
                        .foregroundColor(Color.gray)
                        
                }
                .padding(.trailing, 25)
            }
        }
    }
}

//struct PieChartHelperRows_Previews: PreviewProvider {
//    static var previews: some View {
//        PieChartHelperRows()
//    }
//}
