//
//  View1.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/6/23.
//

import SwiftUI

class Ema: ObservableObject {
    @Published var recipeName = ""
}


struct View1: View {
   @State var recipeName = ""
    @ObservedObject var ema = Ema()
    @State var EditMode = false
    var body: some View {
        TextField(recipeName, text: $recipeName)
            .foregroundColor(!EditMode ? Color.black : Color.red)
            .font(.title2)
            .multilineTextAlignment(.center)
            .padding()
        
        .onChange(of: recipeName, perform: { _ in
            ema.recipeName = recipeName
        })
    }
}


struct View1_Previews: PreviewProvider {
    static var previews: some View {
        View1()
    }
}
