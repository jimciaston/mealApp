//
//  TestRowOne.swift
//  MealJournal
//
//  Created by Jim Ciaston on 7/25/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct TagCloudView: View {
   
    @State var showRecipeModal = false
   
    
    var allRecipes: [RecipeItem]
    
    @State private var totalHeight
        //   = CGFloat.zero       // << variant for ScrollView/List
      = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight + 250 )// << bring stack to the top
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
       // var arrOfRecipes: [RecipeItem] = Array(arrayLiteral: self.tags)
        return ZStack (alignment: .topLeading) {
            ForEach(allRecipes, id: \.self) { recipe in
                self.item(image: recipe.recipeImage, title: recipe.recipeTitle, ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id, recipeFatMacro: recipe.recipeFatMacro, recipeCarbMacro: recipe.recipeCarbMacro, recipeProteinMacro: recipe.recipeProteinMacro, prepTime: recipe.recipePrepTime)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width){
                                width = 0
                                height -= d.height + 50
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
              
            }
        }.background(viewHeightReader($totalHeight))
    }

    func item(image: String, title: String, ingredients: [String: String], directions: [String], recipeID: String, recipeFatMacro: Int, recipeCarbMacro: Int, recipeProteinMacro: Int, prepTime: String) -> some View {
        VStack{
            WebImage(url: URL(string: image))
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
                   Text("20g")
                        Spacer()
                    Text("20g")
                        Spacer()
                    Text("20g")
                        Spacer()
                }
                
                .padding(.leading, 20)
                .frame(width:150)
            }
        .onTapGesture {
            showRecipeModal = true
        }
        .padding(.leading, 30) // << center on screen
        .fullScreenCover(isPresented: $showRecipeModal){
            RecipeControllerModal(name: title, prepTime: prepTime, image: image, ingredients: ingredients, directions: directions, recipeID: recipeID, recipeFatMacro: recipeFatMacro, recipeCarbMacro: recipeCarbMacro, recipeProteinMacro: recipeProteinMacro)
        }
        
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
                TagCloudView(allRecipes: recipeList)
            }
           
        }
       
    }
   
}

struct TestRowOne_Previews: PreviewProvider {
    
    static var previews: some View {
        TagCloudView(allRecipes: [RecipeItem(id: "Test", recipeTitle: "Balls", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),RecipeItem(id: "test", recipeTitle: "Two", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),RecipeItem(id: "test", recipeTitle: "Three", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),
                                  RecipeItem(id: "Last", recipeTitle: "Four", recipePrepTime: "test", recipeImage: "defaultRecipeImage", createdAt: "test", recipeFatMacro: 3, recipeCarbMacro: 3, recipeProteinMacro: 3, directions: ["test"], ingredientItem: ["test":"test"]),
                                 
                                 ])
    }
}
