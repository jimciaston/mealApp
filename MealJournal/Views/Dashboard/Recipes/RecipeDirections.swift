//
//  RecipeDirections.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/21/22.
//

import SwiftUI

struct RecipeDirections: View {
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack{
            List{
                HStack{
                    Text("1")
                        .font(.title)
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                    Text("Marinate chicken breast for 2 hours upon cooking")
                        .font(.body)
                        .padding()
                }
                
                HStack{
                    Text("2")
                        .font(.title)
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                    Text("Boil water and throw pasta in the pot")
                        .font(.body)
                        .padding()
                }
                
                HStack{
                    Text("3")
                        .font(.title)
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                    Text("Pan Fry chicken for approx 25 mins, flipping each side every 5 mins")
                        .font(.body)
                        .padding()
                }
                
            }
            .listStyle(SidebarListStyle())
            
            }
        }
    }

struct RecipeDirections_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDirections()
    }
}
