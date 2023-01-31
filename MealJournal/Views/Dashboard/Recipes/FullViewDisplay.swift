//
//  TestRowOne.swift
//  MealJournal
//
//  Created by Jim Ciaston on 7/25/22.
//

import SwiftUI
import SDWebImageSwiftUI

/*
 -- count indexes for each swipe
 
 
 
 
 */

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
    
    @State private var totalHeight
        //   = CGFloat.zero       // << variant for ScrollView/List
      = CGFloat.infinity   // << variant for VStack
    @State private var currentPage = 0
    
    var body: some View {
        if rm.recipes.count >= 1 { // << Fatal error, index out of range if removed
            TabView {
                   ForEach(Array(rm.recipes.chunked(into: 4)), id: \.self) { recipesChunk in
                       GeometryReader { geometry in
                           self.generateContent(in: geometry, recipes: recipesChunk)
                       }
                   }
              
               }
            .border(.red)
            //   .frame(height: totalHeight + 350 )// << keep if HStack in future
               // If frame is removed, issue occurs when deleting items
               //if deleting items after 6, stack does not go up.
               .frame(maxHeight: totalHeight + 350)
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
        }
        
    }

    private func generateContent(in g: GeometryProxy, recipes: [RecipeItem]) -> some View {
           var width = CGFloat.zero
           var height = CGFloat.zero
           return ZStack(alignment: .topLeading) {
               ForEach(recipes, id: \.id) { recipe in
                   self.item(image: recipe.recipeImage, title: recipe.recipeTitle, ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id, recipeCaloriesMacro: recipe.recipeCaloriesMacro, recipeFatMacro: recipe.recipeFatMacro, recipeCarbMacro: recipe.recipeCarbMacro, recipeProteinMacro: recipe.recipeProteinMacro, prepTime: recipe.recipePrepTime)
                   .padding([.horizontal, .vertical], 5)
                   .alignmentGuide(.leading, computeValue: { d in
                       if (abs(width - d.width) > g.size.width){
                           width = 0
                           height -= d.height - 20
                       }
                       let result = width
                       if recipe == allRecipes.last! {
                           width = 0
                       } else {
                           width -= d.width - 20
                       }
                       return result
                   })
                   .alignmentGuide(.top, computeValue: { d in
                       let result = height
                       if recipe == allRecipes.last! {
                           height = 0
                       }
                       return result
                   })
                   .onTapGesture {
                       selectedRecipe = recipe
                   }
               }
           }
          // .background(viewHeightReader($totalHeight))
        
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

                .fullScreenCover(item: $selectedRecipe){
                    RecipeControllerModal(name: $0.recipeTitle, prepTime: $0.recipePrepTime, image: $0.recipeImage, ingredients: $0.ingredientItem, directions: $0.directions, recipeID: $0.id, recipeCaloriesMacro: recipeCaloriesMacro, recipeFatMacro: $0.recipeFatMacro, recipeCarbMacro: $0.recipeCarbMacro, recipeProteinMacro: $0.recipeProteinMacro)
                       
                }
            }
        .padding(.leading, 30) // << center on screen
        
    }
       
//
//    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
//        return GeometryReader { geometry -> Color in
//            let rect = geometry.frame(in: .local)
//            DispatchQueue.main.async {
//                binding.wrappedValue = rect.size.height
//            }
//            return .clear
//        }
//    }
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
