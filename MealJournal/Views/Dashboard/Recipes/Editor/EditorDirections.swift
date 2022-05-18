//
//  EditorDirections.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/12/22.
//

import SwiftUI
import UIKit

struct EditorDirections: View {
    @State private var isUserEditingDirections = false
    
    @State private var recipeDirections: [String] = ["Marinate chicken breast for 2 hours upon cooking", "Boil water and throw pasta in the pot"]
    @State private var newRecipe = ""
   @State private var userWantsNewDirection = false
    func move(from source: IndexSet, to destination: Int) {
           recipeDirections.move(fromOffsets: source, toOffset: destination)
       }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(Array(recipeDirections.enumerated()), id: \.offset){ (index, recipe) in
                        HStack{
                            Text(String(index))
                                .font(.title)
                                    .foregroundColor(.green)
                                    .fontWeight(.bold)
                            Text(recipe)
                                .font(.body)
                                .padding()
                            }
                        }
                    
                    .onMove(perform: move)
                    
                    .onDelete(perform: { indexSet in
                        recipeDirections.remove(atOffsets: indexSet)
                    })
                    if(userWantsNewDirection){
                    TextField("Enter direction", text: $newRecipe)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .background(.clear)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .onTapGesture{
                            userWantsNewDirection.toggle()
                        }
                }
                    

                }.padding(.top, -50)
              
                
                .toolbar {
                    EditButton()
                        .foregroundColor(.black)
                }
            }
        }
    }



struct EditorDirections_Previews: PreviewProvider {
    static var previews: some View {
        EditorDirections()
    }
}
