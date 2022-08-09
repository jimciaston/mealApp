//
//  RecipeFullListView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/25/22.
//

import SwiftUI

struct RecipeFullListView: View {
    
    @ObservedObject var rm = RecipeLogic()
    @State private var isActive = false
    @State private var active: Int? = nil
    
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            VStack{
                Text("Recipes").bold()
                    .padding(.bottom, 20)
                FullListOfRecipes(allRecipes: rm.recipes)
                
            }

        }
    }
}
       


struct RecipeFullListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFullListView()
    }
}
