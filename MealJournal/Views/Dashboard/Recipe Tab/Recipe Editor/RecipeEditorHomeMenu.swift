//
//  RecipeEditorHomeMenu.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/18/23.
//

import SwiftUI

struct RecipeEditorHomeMenu: View {
    @Environment(\.dismiss) var dismiss
    @State var recipeAddedSuccess = false
    @State private var showSaveButton = false
  
    @State private var sheetMode: SheetMode = .none
    @State var shown = false
    @StateObject var recipeClass = Recipe()
    var onDismiss: (() -> Void)?
    var resetPickerTime: (() -> Void)?
    @ObservedObject var dashboardRouter: DashboardRouter
    @State var thisTest = false
    @Binding var showSuccessMessage: Bool
    var body: some View {
        
        GeometryReader{ geo in
            VStack{
                HStack{
                   Spacer()
                    //bottom sheet for meals
                    Button(action: {
                        showSaveButton.toggle()
                        switch sheetMode {
                            case .none:
                                sheetMode = .mealTimingSelection
                            case .mealTimingSelection:
                                sheetMode = .none
                            case .quarter:
                                sheetMode = .none
                        }
                    }){
                        Image(systemName:"checkmark.circle.fill").resizable()
                            .frame(width: 30, height: 30)
                          //  .frame(maxWidth: .infinity)
                            .foregroundColor(Color("ButtonTwo"))
                            .padding(.trailing, 20)
                    }
                    .blur(radius: showSuccessMessage ? 15 : 0)
                }
               
                RecipeEditorImage()
                    .padding(.top,5)
                    .blur(radius: showSuccessMessage ? 15 : 0)
               
                RecipeEditorView(recipeClass: recipeClass, showSuccessMessage: $shown)
                    .blur(radius: showSuccessMessage ? 15 : 0)
                    .padding(.top, 80)
                    
                RecipeEditModals()
                    .blur(radius: showSuccessMessage ? 15 : 0)
               // Spacer()
                
                
                //display save button
                if showSaveButton{
                       FlexibleSheet(sheetMode: $sheetMode) {
                           SaveRecipeButton(showSuccessMessage: $showSuccessMessage, recipeClass: recipeClass, thisTest: $thisTest)
                           .background(Color.white)
                           .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                           //sets coordinates of view on dash
                           .offset(y:-200)
                       }
                       .onChange(of: thisTest) { value in
                           if value {
                               dashboardRouter.currentTab = .home
                           }
                       }
                   }
                  
                
             
                
            }
            .onAppear{
                recipeAddedSuccess = false
            }
            //center view
            .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .environmentObject(recipeClass)
        }
        
    }
    
}
//struct RecipeEditorHomeMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEditorHomeMenu()
//    }
//}
