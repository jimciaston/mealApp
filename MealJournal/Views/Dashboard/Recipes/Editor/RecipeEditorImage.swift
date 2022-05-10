//
//  RecipeEditorImage.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import SwiftUI
import UIKit

struct RecipeEditorImage: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack (alignment: .trailing){
           if let inputImage = inputImage {
               Image(uiImage: inputImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:200, height: 100)
            } else{
                Image("defaultRecipeImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:200, height: 100)
            
            }
                
                Image(systemName:("plus.circle.fill")).renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: 20)
                    .foregroundColor(Color("completeGreen"))
                    .frame(width:50, height:10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showingImagePicker = true
                    }
            
                    .sheet(isPresented: $showingImagePicker){
                        EditorImagePicker(image: $inputImage)
                    }
            }
        }
    
}
        


struct RecipeEditorImage_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorImage()
    }
}
