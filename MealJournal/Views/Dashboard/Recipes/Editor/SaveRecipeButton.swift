//
//  SaveRecipeButton.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/6/22.
//

import SwiftUI

struct SaveRecipeButton: View {
    var body: some View {
        Button(action: {
            
        }){
            HStack{
                Image(systemName: "pencil").resizable()
                    .frame(width:40, height:40)
                    .foregroundColor(.white)
                Text("Save Recipe")
                    .font(.title)
                    .frame(width:200)
                    .foregroundColor(.white)
                    
            }
            .padding(EdgeInsets(top: 12, leading: 100, bottom: 12, trailing: 100))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        Color("completeGreen")))         }
    }
}

//struct SaveRecipeButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveRecipeButton()
//    }
//}
