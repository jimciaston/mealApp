//
//  LandingButtonPress.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/21/22.
//

import SwiftUI

struct LandingButtonPress: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View{
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}

extension View {
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(LandingButtonPress(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}
