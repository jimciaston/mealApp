//
//  ExistingRecipeDirections.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/26/23.
//

import SwiftUI

struct ExistingRecipeDirections: View {
    @EnvironmentObject var recipeClass: Recipe
    
    @State private var isUserEditingDirections = false
    @State private var userDirection = ""
    @State private var userWantsNewDirection = false

    @ObservedObject var ema: EditModeActive
    @State private var counter = 0
    @Binding var recipeDirections: [String]
    func move(from source: IndexSet, to destination: Int) {
        recipeClass.directions.move(fromOffsets: source, toOffset: destination)
       }
    
    var body: some View {
        if ema.editMode{
            VStack{
                TextField("ex. Pour the flour", text: $userDirection)
                    .font(.body)
                    .padding(.leading, 45)
                    .submitLabel(.done)
                    //Spacer()
                Button(action: {
                    if (userDirection != "" ){
                        print(type(of: ema.updatedDirections))
                        let newDirection = Directions(description: userDirection)
                        ema.updatedDirections.append(newDirection.description)
                        recipeDirections.append(newDirection.description)
                            counter += 1
                            userDirection = ""
                        ema.isDirectionsActive = true
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
                    ForEach(Array(recipeDirections.enumerated()), id: \.offset){ (index, direction) in
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
        else{
            List{
                ForEach(Array(recipeDirections.enumerated()), id: \.offset){ (index, direction) in
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
                    ema.updatedDirections.remove(atOffsets: indexSet)
                })
            }
            .listStyle(PlainListStyle())
            .padding(.top, -20)
        }
              
            
        }
}
//
//struct ExistingRecipeDirections_Previews: PreviewProvider {
//    static var previews: some View {
//        ExistingRecipeDirections()
//    }
//}
