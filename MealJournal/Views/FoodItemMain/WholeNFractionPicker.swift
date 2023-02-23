//
//  Test.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/2/22.
//

import SwiftUI

struct MultiPicker: View  {
    let data: [ (String, [String]) ]
    @Binding var selection: [String]
    @Binding var isOpen: Bool // << toggle select size button
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack {
                    ForEach(0..<self.data.count) { column in
                        Picker(self.data[column].0, selection: self.$selection[column]) {
                            ForEach(0..<self.data[column].1.count) { row in
                                Text(verbatim: self.data[column].1[row])
                                    .font(.title3)
                                    .tag(self.data[column].1[row])
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .clipped()
                    }
                }
                .padding(.top, -45)
              
                Spacer()
                Button(action: {
                    print(selection)
                     isOpen = false
                }){
                    Text("Select Size")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .frame(maxWidth: .infinity)
                .background(.green)
                
            }
        }
    }
}

struct WholeNFractionPicker: View {
    @Binding var isOpen: Bool
    @Binding var selection: [String]
    @State var data: [(String, [String])] = [
        ("Whole Number", Array(0...100).map { "\($0)" }),
        ("Fractional Number", ["1/8", "1/4" , "1/3" , "3/8" , "1/2" , "5/8" , "2/3" , "3/4" , "7/8"]), 
        ]
    
    var body: some View {
        VStack(alignment: .center) {
            MultiPicker(data: data, selection: $selection, isOpen: $isOpen)
                .frame(height: 250)
          
              }
        .background(Color("ListBackgroundColor"))

        }
    }

//struct Test_Previews: PreviewProvider {
//    static var previews: some View {
//        WholeNFractionPicker(isOpen: .constant(true), selection: ["",""])
//    }
//}
