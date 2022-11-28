//
//  RecipeListView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/17/22.
//when recipe is clicked assign id to go to page
import UIKit
import SwiftUI
import SDWebImageSwiftUI

struct RecipeListView: View {
    @EnvironmentObject var mealEntryObj: MealEntrys
    //keep as stateOBJ, if observed object - causes weird issue with loading recipes
    @StateObject var rm = RecipeLogic()
    @State var MealObject = Meal()
    @State var mealTimingToggle = false
    @State var sheetMode: SheetMode = .none
    @State var recipeViewToggle = false
    
    @State var isViewSearching = true
    @State var userSearch = false
    
    @State var triggerRecipeController = false // << show recipe controller toggle
    @EnvironmentObject var emaGlobal: EditModeActive
   
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    @ViewBuilder
    var body: some View {
        
        if rm.recipes.count != 0 {
                   VStack{
                       List{
                           //prefix = only show 3 recipes at a time
                           ForEach(rm.recipes.prefix(3), id: \.id ){ recipe in
                                   HStack{
                                       WebImage(url: URL(string: recipe.recipeImage))
                                           .placeholder(Image("profileDefaultPicture").resizable())
                                           .resizable()
                                          .aspectRatio(contentMode: .fill)
                                        .frame (width: 70, height:70)
                                        .cornerRadius(15)
                                VStack{
                                    ZStack{
                                      
                                            Text(recipe.recipeTitle)
                                                .font(.body)
                                            //temp solution until I can center it
                                                .padding(.top, 1)
                                            
                                         
                                       
                                        
                                        //as a note, sets empty view to hide list arrow
                                        NavigationLink(destination: {RecipeController(name: recipe.recipeTitle,prepTime: recipe.recipePrepTime, image: recipe.recipeImage,  ingredients: recipe.ingredientItem, directions: recipe.directions, recipeID: recipe.id, recipeCaloriesMacro:  recipe.recipeCaloriesMacro , recipeFatMacro: recipe.recipeFatMacro, recipeCarbMacro: recipe.recipeCarbMacro, recipeProteinMacro: recipe.recipeProteinMacro)}, label: {
                                            emptyview()
                                            })
                                            .opacity(0.0)
                                            .buttonStyle(PlainButtonStyle())
                                        
                                        HStack{
                                            Text(String(recipe.recipeCaloriesMacro) + "g")
                                                .foregroundColor(.gray)
                                            Text(String(recipe.recipeFatMacro) + "g")
                                                .foregroundColor(.gray)
                                            Text(String(recipe.recipeCarbMacro) + "g")
                                                .foregroundColor(.gray)
                                            Text(String(recipe.recipeProteinMacro) + "g")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.top, 80)
                                        .padding(.bottom, 10)
                                        .frame(height:90)
                                    }
                                    .padding(.top, -20)
                                 
                                    }
                                .padding(EdgeInsets(top: -5, leading: -25, bottom: 0, trailing: 0))
                                }
                            }
                    
                    ZStack{
                        NavigationLink(destination:RecipeFullListView(recipes: rm.recipes, showAddButton: true)) {
                               emptyview()
                           }
                       
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        
                           HStack {
                               Text("View More")
                                   .font(.body)
                                   .frame(width:300)
                                   .padding(.top, 20)
                           }
                        
                    }
                           
                }
                       .windowOverlay(isKeyAndVisible: self.$mealTimingToggle, {
                           GeometryReader { geometry in {
                               BottomSheetView(
                                   isOpen: self.$mealTimingToggle,
                                   maxHeight: geometry.size.height / 2.0
                               ) {
                                   
                                   MealTimingSelectorView(meal: $MealObject, isViewSearching: .constant(true), userSearch: .constant(false), mealTimingToggle: $mealTimingToggle, extendedViewOpen: .constant(false), mealSelected: .constant(true))
                                           .environmentObject(mealEntryObj)
                                      
                               }
                              
                           }().edgesIgnoringSafeArea(.all)
                                  
                           }
                           
                       })
                       
            }
            .onAppear{
                emaGlobal.editMode = false
            }//<<end of VStack
            //using windowOverlay from swiftUIX to hide TabBar
          
    
        }
        else{
            VStack{
                Image(systemName: "plus.rectangle.on.rectangle")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .onTapGesture {
                        triggerRecipeController = true
                    }
                Text("Add a Recipe!")
                    .font(.title3)
                    .padding()
            }
            .padding(.top, 40)
            .fullScreenCover(isPresented: $triggerRecipeController){
                    RecipeEditor()
            }
            Spacer()
        }
       
    }
        
}



struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
