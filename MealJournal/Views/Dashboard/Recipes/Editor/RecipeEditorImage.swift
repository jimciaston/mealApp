//
//  RecipeEditorImage.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import SwiftUI
import UIKit
import FirebaseFirestore
import SDWebImageSwiftUI

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
    
    //Save Profile picture to firestore
    private func persistImageToStorage() {
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
            let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        
            guard let imageData = self.inputImage?.jpegData(compressionQuality: 0.5) else { return }
            ref.putData(imageData, metadata: nil) { metadata, err in
                if let err = err {
                   print("failed to push to storage \(err)")
                    return
                }

                ref.downloadURL { url, err in
                    if let err = err {
                        print("failed to fetch download link")
                        return
                    }

                   print("Image saved Successfully")
                    guard let url = url else { return }
                    Firestore.firestore().collection("users").document(uid).setData([ "recipeImage": url.absoluteString ], merge: true)
                }
            }
        }
    
    
}
        


struct RecipeEditorImage_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorImage()
    }
}
