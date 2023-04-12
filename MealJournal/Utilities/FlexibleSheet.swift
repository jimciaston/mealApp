//
//  testmodal.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/21/22.
//

import SwiftUI

enum SheetMode {
    case none
    case quarter
    case mealTimingSelection
}

struct FlexibleSheet<Content: View>: View {
    let content: () -> Content
    var sheetMode: Binding<SheetMode>
    
    init(sheetMode: Binding<SheetMode>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.sheetMode = sheetMode
    }
    
    private func calculateOffset() -> CGFloat {
        
        switch sheetMode.wrappedValue {
            case .none:
                return UIScreen.main.bounds.height
            case .quarter:
                return UIScreen.main.bounds.height - 500 //450 default
        case .mealTimingSelection:
            return UIScreen.main.bounds.height - 650
                
        }
        
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
          //  .animation(.spring())
            .edgesIgnoringSafeArea(.all)
    }
}

struct FlexibleSheet_Previews: PreviewProvider {
    static var previews: some View {
        FlexibleSheet(sheetMode: .constant(.none)) {
            VStack {
               //leaving as nothing, bug where previews crashes without a view will come back at a later date and correct
            }
        }
    }
}
