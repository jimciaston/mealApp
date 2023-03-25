//
//  EditorDirections.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/12/22.
//

import SwiftUI
import UIKit

struct EditorDirections: View {
    @EnvironmentObject var recipeClass: Recipe
    
    @State private var isUserEditingDirections = false
    @State private var userDirection = ""
    @State private var userWantsNewDirection = false

    
    @State private var counter = 0
   
    func move(from source: IndexSet, to destination: Int) {
        recipeClass.directions.move(fromOffsets: source, toOffset: destination)
       }
    
    var body: some View {
      
            VStack{
                TextField("ex. Pour the flour", text: $userDirection)
                    .font(.body)
                    .padding(.leading, 45)
                    //Spacer()
                Button(action: {
                    if (userDirection != "" ){
                        let newDirection = Directions(description: userDirection)
                        recipeClass.directions.append(newDirection)
                            counter += 1
                            userDirection = ""
                    }
                }){
                    Image(systemName: "plus.circle.fill")
                        .opacity(!userDirection.isEmpty ? 1.0 : 0.5)
                        .foregroundColor(.blue)
                        .padding(.leading, 35)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        .background(.clear)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        Spacer()
                }
                .padding(.top, -10)
                .padding(.bottom, 10)
            
                List{
                    ForEach(Array(recipeClass.directions.enumerated()), id: \.offset){ (index, direction) in
                        HStack{
                            Text(String(index + 1))
                                .font(.title)
                                    .foregroundColor(Color("UserProfileCard1"))
                                    .fontWeight(.bold)
                            Text(direction.description)
                                .font(.body)
                                .padding()
                            }
                        }
                    
                    .onMove(perform: move)
                    
                    .onDelete(perform: { indexSet in
                        recipeClass.directions.remove(atOffsets: indexSet)
                    })
                }
                .listStyle(PlainListStyle())
                .padding(.top, -20)
            
            }
              
            
        }
        
    }



struct EditorDirections_Previews: PreviewProvider {
    static var previews: some View {
        EditorDirections()
    }
}
