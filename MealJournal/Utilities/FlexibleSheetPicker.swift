//
//  FlexibleSheetPicker.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/10/22.
//

import SwiftUI

import SwiftUI

enum SheetOptions {
    case none
    case quarter
}

struct FlexibleSheetPicker<Content: View>: View {
    let content: () -> Content
    var SheetOptions: Binding<SheetMode>
    
    init(SheetOptions: Binding<SheetMode>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.SheetOptions = SheetOptions
    }
    
    private func calculateOffset() -> CGFloat {
        
        switch SheetOptions.wrappedValue {
            case .none:
                return UIScreen.main.bounds.height
            case .quarter:
                return UIScreen.main.bounds.height - 550 //450 default
        case .mealTimingSelection:
            return UIScreen.main.bounds.height
        }
        
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
          //  .animation(.spring())
            .edgesIgnoringSafeArea(.all)
    }
}

struct FlexibleSheetPicker_Previews: PreviewProvider {
    static var previews: some View {
        FlexibleSheetPicker(SheetOptions: .constant(.none)) {
            VStack {
               //leaving as nothing, bug where previews crashes without a view will come back at a later date and correct
            }
        }
    }
}

