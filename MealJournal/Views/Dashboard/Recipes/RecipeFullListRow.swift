//
//  RecipeFullListRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import SwiftUI


struct RecipeFullListRow: View {
    var recipe: RecipeListModel
    var recipeName: String
    
    @State var showRecipeOptions = false
    
   
    var body: some View {
                HStack{
                    Image(recipe.image)
                        .resizable()
                       .frame (width: 70, height:70)
                        .cornerRadius(15)
                    ZStack{
                        
                        Text(recipeName)
                            .font(.body)
                        //temp solution until I can center it
                            .padding(.top, 1)
                        //as a note, sets empty view to hide list arrow
                        NavigationLink(destination: {RecipeController(name: recipe.name, image: recipe.image)}, label: {
                            emptyview()
                            })
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                        
                        Text("10g 25g 88g")
                            .foregroundColor(.gray)
                            .padding(.top, 80)
                            .padding(.bottom, 10)
                            .padding(.trailing, 10)
                            .frame(height:90)
                        
                        if showRecipeOptions{
                            ReditorPopUp()
                                    .padding(.top, 20)
                                    .padding(.leading, 15)
                        }
                    }
                        .padding(.top, -10)
                        .padding(5)
                    
                   
                    Button(action: {
                       
                        
                    }){
                        Image(systemName: "slider.horizontal.3")
                            .padding(.top, 10)
                            .foregroundColor(.black)
                            .onTapGesture{
                                showRecipeOptions.toggle()
                            }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                   
            }
    }
}

//struct RecipeFullListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeFullListRow()
//    }
//}