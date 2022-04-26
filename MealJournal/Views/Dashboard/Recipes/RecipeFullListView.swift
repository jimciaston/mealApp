//
//  RecipeFullListView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/25/22.
//

import SwiftUI

struct RecipeFullListView: View {
    @Environment(\.dismiss) var dismiss
    @State var listofRecipes: [RecipeListModel] = RecipeList.recipes
    @State private var active = false
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
            VStack{
                Text("Recipes")
                    //.padding(.bottom, -20)
                    //.padding(.top, 40)
                    .font(.title2)
                
                List{
                    ForEach(listofRecipes, id: \.id){ recipe in
                            HStack{
                                Image(recipe.image)
                                    .resizable()
                                   .frame (width: 70, height:70)
                                    .cornerRadius(15)
                                ZStack{
                                    Text(recipe.name)
                                        .font(.title2)
                                    //temp solution until I can center it
                                        .padding(.top, 1)
                                    //as a note, sets empty view to hide list arrow
                                    NavigationLink(destination: {RecipeController(name: recipe.name, image: recipe.image)}, label: {
                                        emptyview()
                                        })
                                        .opacity(0.0)
                                        .buttonStyle(PlainButtonStyle())
                                    
                                    Text("10g 25g 88g")
                                        .foregroundColor(.black)
                                        .padding(.top, 80)
                                        .padding(.bottom, 10)
                                        .padding(.trailing, 10)
                                        .frame(height:90)
                                }
                                    .padding(.top, -10)
                                    .padding(5)
                        }
                    }
                }
            }//end of VStack
            
            .toolbar{
                ToolbarItem (placement: .navigationBarTrailing){
                    VStack{
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        }
       


struct RecipeFullListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFullListView()
    }
}
