//
//  TestRowOne.swift
//  MealJournal
//
//  Created by Jim Ciaston on 7/25/22.
//

import SwiftUI
import SDWebImageSwiftUI

//break down Array into "chunks" of 4
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct FullListOfRecipes: View {
    
    
    @EnvironmentObject var mealEntryObj: MealEntrys
    
    @ObservedObject var rm = RecipeLogic()
    @Binding var showAddButton:Bool
    @State var showRecipeModal = false
    @State var allRecipes: [RecipeItem]
    @State var selectedRecipe: RecipeItem?
    @State var MealObject = Meal()
    @State var mealTimingToggle = false
   
    @State private var currentPage = 0
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        if allRecipes.count >= 1 {
            // << Fatal error, index out of range if removed
            
            TabView {
                ForEach(Array(rm.recipes.chunked(into: 6)), id: \.self) { recipesChunk in
                       LazyVGrid(columns: columns) {
                          ForEach(recipesChunk, id: \.id) { recipe in
                             
                              self.item(image: recipe.recipeImage, title: recipe.recipeTitle, ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id, recipeCaloriesMacro: recipe.recipeCaloriesMacro, recipeFatMacro: recipe.recipeFatMacro, recipeCarbMacro: recipe.recipeCarbMacro, recipeProteinMacro: recipe.recipeProteinMacro, prepTime: recipe.recipePrepTime)
                                 
                              .onTapGesture {
                                selectedRecipe = recipe
                            }
                          }
                       }.frame(maxHeight: .infinity, alignment: .top)
                    
                   }
               }
          
               
           .tabViewStyle(.page)
           .gesture(
               DragGesture()
                  .onEnded { value in
                      if value.translation.width < 0 {
                          self.currentPage = min(self.currentPage + 1, rm.recipes.count / 4)
                  } else if value.translation.width > 0 {
                      self.currentPage = max(self.currentPage - 1, 0)
                  }
              }
               
            )
           .fullScreenCover(item: $selectedRecipe, content: { item in
               RecipeControllerModal(name: item.recipeTitle, prepTime: item.recipePrepTime, image: item.recipeImage, ingredients: item.ingredientItem, directions: item.directions, recipeID: item.id, recipeCaloriesMacro: item.recipeCaloriesMacro, recipeFatMacro: item.recipeFatMacro, recipeCarbMacro: item.recipeCarbMacro, recipeProteinMacro: item.recipeProteinMacro)
                   })
//           .fullScreenCover(item: $selectedRecipe,  onDismiss: { print("dismissed!") }){
//               RecipeControllerModal(name: $0.recipeTitle, prepTime: $0.recipePrepTime, image: $0.recipeImage, ingredients: $0.ingredientItem, directions: $0.directions, recipeID: $0.id, recipeCaloriesMacro: $0.recipeCaloriesMacro, recipeFatMacro: $0.recipeFatMacro, recipeCarbMacro: $0.recipeCarbMacro, recipeProteinMacro: $0.recipeProteinMacro)
            
    //   }
        }
        else{
            Text("No Recipes Saved")
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }

//individual item
    func item(image: String, title: String, ingredients: [String: String], directions: [String], recipeID: String, recipeCaloriesMacro: Int ,recipeFatMacro: Int, recipeCarbMacro: Int, recipeProteinMacro: Int, prepTime: String) -> some View {
        
        VStack{
            WebImage(url: URL(string: image))
                .placeholder(Image("defaultRecipeImage-2").resizable())
                .resizable()
                .frame (width: 150, height:130)
                .cornerRadius(15)
            
            ZStack{
                HStack{
                    Text(title).bold()
                        .padding(.leading, 20)
                    Spacer()
                }
            }
                .frame(width:150)
                .padding(.bottom,  2)
                //macros
                HStack{
                    Text(String(recipeCaloriesMacro) + " Calories")
                         Spacer()
                
                }
                
                .padding(.leading, 20)
                .frame(width:150)
            
        }
    }

}

//struct TestTagCloudView : View {
//    var recipes: [RecipeItem]
//
//    var body: some View {
//
//        let recipeList = Array(recipes)
//        VStack {
//           // Text("All Recipes").font(.largeTitle)
//
//            ForEach (recipeList, id: \.self){ recipe in
//                FullListOfRecipes(showAddButton: true, allRecipes: recipeList)
//            }
//
//        }
//    }
//}

//struct TestRowOne_Previews: PreviewProvider {
//
//    static var previews: some View {
//        FullListOfRecipes(showAddButton: Binding.constant(true), allRecipes: [RecipeItem(id: "Test", recipeTitle: "Balls", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeCaloriesMacro: 3, recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),RecipeItem(id: "test", recipeTitle: "Two", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeCaloriesMacro: 0, recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),RecipeItem(id: "test", recipeTitle: "Three", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeCaloriesMacro: 0, recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),
//                                                                              RecipeItem(id: "Last", recipeTitle: "Four", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeCaloriesMacro: 0, recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),
//
//                                                                             ])
//    }
//}
