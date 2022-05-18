//
//  EditorIngredients.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/12/22.
//READY FOR CORE DATA

import SwiftUI

struct EditorIngredients: View {
    @State private var sizing: String = ""
    @State private var name: String = ""
    
    var body: some View {
        ZStack{
            VStack{
                List{
                    HStack{
                        TextField("ex. 1 cup", text: $sizing)
                            .font(.title2)
                            .foregroundColor(.green)
                           
                        TextField("ex. Chicken Breast", text: $name)
                            .font(.title3)
                       
                    }
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                       
                }
               
                .listStyle(SidebarListStyle())
            
                
                
                }
            Spacer()
            
            }
        .padding(.top, -50)
        }
    }


struct EditorIngredients_Previews: PreviewProvider {
    static var previews: some View {
        EditorIngredients()
    }
}
