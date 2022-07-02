//
//  RecipeDirections.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/21/22.
//

import SwiftUI

struct RecipeDirections: View {
    @ObservedObject var rm = RecipeLogic()
    @Binding var directions: [String]
    @State private var totalDirectionsCount = 0
//    init(){
//        UITableView.appearance().backgroundColor = .clear
//    }
   
    var body: some View {
        VStack{
            List{
                ForEach(Array(directions.enumerated()), id: \.offset){ index, recipe in
                    HStack{
                        Text(String(index + 1))
                            .font(.title)
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                        Text(recipe)
                            .font(.body)
                            .padding()
                    }
                }
            }
            .listStyle(SidebarListStyle())
        }
    }
}

//struct RecipeDirections_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDirections()
//    }
//}
