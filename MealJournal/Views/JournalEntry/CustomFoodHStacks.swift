//
//  CustomFoodHStacks.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/25/22.
//

import SwiftUI

struct CustomFoodHStacks: View {
    @Binding var macroAmount: Int
    @State var macroName: String
    @State private var timer: Timer?
    @State var isLongPressing = false
    
    var body: some View {
        let releaseGesture = DragGesture(minimumDistance: 0) // << detects finger release
            .onEnded { _ in
                self.timer?.invalidate()
            }
        
        
        let longPressGesture = LongPressGesture(minimumDuration: 0.2)
            .onEnded { _ in
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                    macroAmount += 1
                })
            }
        let combined = longPressGesture.sequenced(before: releaseGesture)
        HStack{
            Text(macroName + " " + String(macroAmount) + "g")
                .frame(width:50, height:50)
            
            Image(systemName: "plus.circle.fill")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("SuccessButtonColor"))
                .onTapGesture{
                    macroAmount += 1
                }
                .gesture(combined)
            Image(systemName: "minus.circle.fill")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("SuccessButtonColor"))
             
                .onTapGesture{
                    if macroAmount != 0{
                        macroAmount -= 1
                    }
                }
                
        }
    }
}
//
//struct CustomFoodHStacks_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomFoodHStacks()
//    }
//}
