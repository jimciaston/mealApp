//
//  practice.swift
//  MealJournal
//
//  Created by Jim Ciaston on 9/9/22.
//

import SwiftUI

struct practice: View {
    var body: some View {
            EqualIconWidthDomain {
                VStack(alignment: .leading) {
                    Label("People", systemImage: "person.3")
                    Label("Star", systemImage: "star")
                    Label("This is a plane", systemImage: "airplane")
                }
            }
        }
}

fileprivate struct IconWidthKey: PreferenceKey {
    static var defaultValue: CGFloat? { nil }

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let next = nextValue() else { return }
        if let current = value {
            value = max(current, next)
        } else {
            value = next
        }
    }
}

extension IconWidthKey: EnvironmentKey { }

extension EnvironmentValues {
    fileprivate var iconWidth: CGFloat? {
        get { self[IconWidthKey.self] }
        set { self[IconWidthKey.self] = newValue }
    }
}

fileprivate struct IconWidthModifier: ViewModifier {
    @Environment(\.iconWidth) var width

    func body(content: Content) -> some View {
        content
            .background(GeometryReader { proxy in
                Color.clear
                    .preference(key: IconWidthKey.self, value: proxy.size.width)
            })
            .frame(width: width)
    }
}

struct EqualIconWidthLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon.modifier(IconWidthModifier())
            configuration.title
        }
    }
}
struct EqualIconWidthDomain<Content: View>: View {
    let content: Content
    @State var iconWidth: CGFloat? = nil

    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .environment(\.iconWidth, iconWidth)
            .onPreferenceChange(IconWidthKey.self) { self.iconWidth = $0 }
            .labelStyle(EqualIconWidthLabelStyle())
    }
}

struct practice_Previews: PreviewProvider {
    static var previews: some View {
        practice()
    }
}
