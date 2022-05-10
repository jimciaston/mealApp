//
//  PopUpMenu.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/7/22.
//

import SwiftUI
extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing))}
}
struct ReditorPopUp: View {
    
    @State var showEditRecipe = false
    
    var body: some View {
        ZStack{
            VStack (alignment: .leading, spacing: 20){
                HStack(spacing:12){
                    Image(systemName: "pencil")
                        .font(.title2)
                    Button(action:{
                        showEditRecipe.toggle()
                           
                    }){
                        Text("Edit")
                            .foregroundColor(.black)
                    } .buttonStyle(BorderlessButtonStyle())
                        .sheet(isPresented: $showEditRecipe){
                            RecipeEditor()
                        }
                }
                HStack(spacing: 12){
                    Image(systemName: "trash")
                        .font(.title2)
                        .foregroundColor(.red)
                    Button(action: {
                        
                    }){
                        Text("Delete")
                            .foregroundColor(.black)
                    } .buttonStyle(BorderlessButtonStyle())
                }
               
                
            }
           
            
         
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        ///art of animations
        .transition(.backslide)
        .animation(.easeInOut(duration: 0.25))
    }
}

struct ReditorPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ReditorPopUp()
    }
}
