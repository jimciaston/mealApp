//
//  Test.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/2/22.
//

import SwiftUI

struct Castaways{
    
        let id = UUID()
        let name: String
    
}

struct Test: View {
    @State private var castaways: [Castaways] = [
            Castaways(name: "Locke"),
            Castaways(name: "Jack"),
            Castaways(name: "Sawyer")
        ]
    
    var body: some View {
            List(castaways, id: \.id){ person in
                Text(person.name)
            }
        }
    }

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
