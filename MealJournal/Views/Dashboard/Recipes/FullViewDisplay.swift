//
//  TestRowOne.swift
//  MealJournal
//
//  Created by Jim Ciaston on 7/25/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FullListOfRecipes: View {
    @State var showRecipeModal = false
    var allRecipes: [RecipeItem]
    @State var selectedRecipe: RecipeItem?
    
    @State private var totalHeight
        //   = CGFloat.zero       // << variant for ScrollView/List
      = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
     //   .frame(height: totalHeight + 350 )// << bring stack to the top
        .frame(maxHeight: totalHeight + 350) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
       // var arrOfRecipes: [RecipeItem] = Array(arrayLiteral: self.tags)
        return ZStack (alignment: .topLeading) {
            ForEach(allRecipes, id: \.self) { recipe in
               
                self.item(image: recipe.recipeImage, title: recipe.recipeTitle, ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id, recipeCaloriesMacro: recipe.recipeCaloriesMacro, recipeFatMacro: recipe.recipeFatMacro, recipeCarbMacro: recipe.recipeCarbMacro, recipeProteinMacro: recipe.recipeProteinMacro, prepTime: recipe.recipePrepTime)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width){
                                width = 0
                                height -= d.height + 30 // <<height between rows
                            }
                            let result = width
                        
                        if recipe == allRecipes.last! {
                                width = 0 //last item
                            } else {
                                width -= d.width - 20 // << padding to rows
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: { d in
                            let result = height
                            if recipe == allRecipes.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                        .onTapGesture{
                            selectedRecipe = recipe
                        }
            }
        }
        .background(viewHeightReader($totalHeight))
    }
//individual item
    func item(image: String, title: String, ingredients: [String: String], directions: [String], recipeID: String, recipeCaloriesMacro: Int ,recipeFatMacro: Int, recipeCarbMacro: Int, recipeProteinMacro: Int, prepTime: String) -> some View {
        VStack{
            WebImage(url: URL(string: image))
                .placeholder(Image("defaultRecipeImage-2").resizable())
                .resizable()
                .frame (width: 110, height:130)
                .cornerRadius(15)
            
            ZStack{
                HStack{
                    Text(title).bold()
                        .padding(.leading, 20)
                    Spacer()
                }
            }
                .frame(width:150)
                .padding(.bottom, 2)
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
       
 
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct TestTagCloudView : View {
    var recipes: [RecipeItem]
    
    var body: some View {
        
        let recipeList = Array(recipes)
        VStack {
           // Text("All Recipes").font(.largeTitle)
            
            ForEach (recipeList, id: \.self){ recipe in
                FullListOfRecipes(allRecipes: recipeList)
            }
           
        }
    }
}

struct TestRowOne_Previews: PreviewProvider {
    
    static var previews: some View {
        FullListOfRecipes(allRecipes: [RecipeItem(id: "Test", recipeTitle: "Balls", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeCaloriesMacro: 3, recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),RecipeItem(id: "test", recipeTitle: "Two", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeCaloriesMacro: 0, recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),RecipeItem(id: "test", recipeTitle: "Three", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeCaloriesMacro: 0, recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),
                                       RecipeItem(id: "Last", recipeTitle: "Four", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeCaloriesMacro: 0, recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),
                                 
                                 ])
    }
}
