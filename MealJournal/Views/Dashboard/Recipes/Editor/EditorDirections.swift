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
    
    @State private var recipeDirections: [String] = ["Marinate chicken breast for 2 hours upon cooking", "Boil water and throw pasta in the pot", "oh man"]
    @State private var userDirection = ""
    @State private var userWantsNewDirection = false
    @State var allUserDirections: [Directions] = []
    @State private var counter = 0
    
    func move(from source: IndexSet, to destination: Int) {
        allUserDirections.move(fromOffsets: source, toOffset: destination)
       }
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("ex. Pour the flour", text: $userDirection)
                    .font(.body)
                    .padding(.leading, 45)
                    .padding(.top, 5)
                    //Spacer()
                Button(action: {
                    if (userDirection != "" ){
                        let newDirection = Directions(description: userDirection)
                            allUserDirections.append(newDirection)
                            counter += 1
                            userDirection = ""
                    }
                }){
                    Image(systemName: "plus.circle.fill")
                        .opacity(!userDirection.isEmpty ? 1.0 : 0.5)
                        .foregroundColor(.blue)
                        .padding(.leading, 35)
                        .padding(.top, 20)
                        .background(.clear)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        Spacer()
                }
                .padding(.top, -10)
                .padding(.bottom, 10)
               
               
               
                List{
                    ForEach(Array(allUserDirections.enumerated()), id: \.offset){ (index, direction) in
                        HStack{
                            Text(String(index + 1))
                                .font(.title)
                                    .foregroundColor(.green)
                                    .fontWeight(.bold)
                            Text(direction.description)
                                .font(.body)
                                .padding()
                            }
                        }
                    
                    .onMove(perform: move)
                    
                    .onDelete(perform: { indexSet in
                        allUserDirections.remove(atOffsets: indexSet)
                    })
                  
                   
                }
                .padding(.top, -20)
               
                .navigationBarHidden(true)
                .navigationBarTitle("")
              
            }
//                .toolbar {
//                    ToolbarItem(placement:.bottomBar){
//                        EditButton()
//                            .foregroundColor(.black)
//                    }
//                }
              
            
            }
        }
        
    }



struct EditorDirections_Previews: PreviewProvider {
    static var previews: some View {
        EditorDirections()
    }
}
