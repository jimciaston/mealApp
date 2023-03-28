//
//  MacroSelectHstack.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/25/23.
//

import SwiftUI

struct MacroSelectHstack: View {
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
        
        HStack {
            Text("\(macroName): ")
                .frame(width: 60, alignment: .leading)
                .padding(.trailing, 15)
                
            Image(systemName: "minus")
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .padding(3)
                .background(Rectangle().fill(Color("UserProfileCard2")))
                .onTapGesture{
                    macroAmount -= 1
                }
            Text("\(macroAmount)g")
                .foregroundColor(.black)
                .frame(width:60)
                .padding([.leading, .trailing], -5)
            
           
                Image(systemName: "plus")
                .frame(width: 15, height: 15)
                    .foregroundColor(.white)
                    .padding(3)
                    .background(Rectangle().fill(Color("UserProfileCard2")))
                    .onTapGesture{
                        macroAmount += 1
                    }
            .gesture(combined)
            Spacer()
        }
       

    }
}

struct MacroSelectHstack_Previews: PreviewProvider {
    static var previews: some View {
        MacroSelectHstack(macroAmount: .constant(2), macroName: "Fat")
    }
}
