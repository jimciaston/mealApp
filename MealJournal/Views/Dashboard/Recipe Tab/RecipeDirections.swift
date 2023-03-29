//
//  RecipeDirections.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/21/22.
//

import SwiftUI

struct RecipeDirections: View {
    @ObservedObject var rm = RecipeLogic()
    @ObservedObject var ema: EditModeActive
    
    @Binding var directions: [String]
    @State private var totalDirectionsCount = 0
    
    @State var userDirection = ""
    
//    init(){
//        UITableView.appearance().backgroundColor = .clear
//    }
    //rearrange rows in list logic
    func move(from source: IndexSet, to destination: Int) {
        directions.move(fromOffsets: source, toOffset: destination)
        ema.updatedDirections = directions
       }
    
    
    var body: some View {
        VStack{
            if ema.editMode{
                TextField("ex. Pour the flour", text: $userDirection)
                    .font(.body)
                    .padding(.leading, 45)
                    .padding(.top, 15)
                
                Button(action: {
                    if (userDirection != "" ){
                        directions.append(userDirection)
                        ema.updatedDirections = directions
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
                .padding(.top, -15)
            }
            List{
                ForEach(Array(directions.enumerated()), id: \.offset){ index, recipe in
                    HStack{
                        Text(String(index + 1))
                            .font(.title)
                            .foregroundColor(Color("UserProfileCard1"))
                            .fontWeight(.bold)
                        Text(recipe)
                            .font(.title3)
                        
                    }
                }
                //rearrange rows
                .onMove(perform: move)
                //on delete
                .onDelete(perform: { indexSet in
                    if ema.editMode{
                        directions.remove(atOffsets: indexSet)
                        ema.updatedDirections = directions
                    }
                })
            }
            .onAppear{
              //  ema.updatedDirections = directions
            }
            .listStyle(PlainListStyle())
           
        }
        .environment(\.editMode, Binding.constant(ema.editMode ? EditMode.active : EditMode.inactive))
    }
}

//struct RecipeDirections_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDirections()
//    }
//}
