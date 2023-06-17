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
import _PhotosUI_SwiftUI

@available(iOS 16.0, *)
struct RecipeEditorImage: View {
    @EnvironmentObject var recipeClass: Recipe
    @State private var showingImagePicker = false
    @State private var inputImage: Image?
    @State private var selectedRecipeImage: PhotosPickerItem?
    
    var body: some View {
        VStack{
            ZStack (alignment: .trailing){
               if let inputImage {
                   inputImage
                       .resizable()
                       .aspectRatio(4/3, contentMode: .fill)
                       .frame(width:250, height: 170)
                       .clipped()
                       .cornerRadius(10)
                       .padding(.top, 25)
                       .onTapGesture {
                           showingImagePicker = true
                       }
                       .photosPicker(isPresented: $showingImagePicker, selection: $selectedRecipeImage)
                      
                } else{
                    ZStack {
                        Color("LightWhite")
                            .frame(width:250 ,height: 160)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(Color("LighterWhite"))
                            .frame(width:250, height: 170)
                            .frame(maxWidth: .infinity)
                        Image("uploadRecipeImage")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width:60, height: 60)
                            .padding()
                        Text("Upload your recipe photo")
                            .font(.caption)
                            .offset(y: 55)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 25)
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    .photosPicker(isPresented: $showingImagePicker, selection: $selectedRecipeImage)
//
                }
//
//
//                    Image(systemName:("plus.circle.fill"))//.renderingMode(.original)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .offset(x: 20, y: -10)
//                        .foregroundStyle(.white, Color("UserProfileCard2"))
//                        .frame(width:50, height:10)
//                        .contentShape(Rectangle())
                
                       
                }
            
            .onChange(of: selectedRecipeImage) { _ in
                Task {
                    if let data = try? await selectedRecipeImage?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            inputImage = Image(uiImage: uiImage)
                            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
                            let ref = FirebaseManager.shared.storage.reference(withPath: "\(uid)/recipeImage.jpg")
                            guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return }
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
                                    guard let url = url else { return }
                                    recipeClass.recipeImage = url.absoluteString // Save the image URL to the recipe model
                                }
                            }
                            return
                        }
                    }
                    print("Failed")
                }
            }

            //save to storage when image is selected
            
        }
//            .onChange(of: inputImage, perform: { _ in
//            persistImageToStorage()
//        })
        
    }
    
    //Save Profile picture to firestore
//    private func persistImageToStorage() {
//            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//            let ref = FirebaseManager.shared.storage.reference(withPath: uid)
//        
//            guard let imageData = self.inputImage?.jpegData(compressionQuality: 0.5) else { return }
//            ref.putData(imageData, metadata: nil) { metadata, err in
//                if let err = err {
//                   print("failed to push to storage \(err)")
//                    return
//                }
//
//                ref.downloadURL { url, err in
//                    if let err = err {
//                        print("failed to fetch download link")
//                        return
//                    }
//
//                   print("Image saved Successfully")
//                    guard let url = url else { return }
//                    
//                    //save to recipe model
//                    recipeClass.recipeImage = url.absoluteString
//                    
//                    
//                }
//            }
//        }    
}
        


//struct RecipeEditorImage_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEditorImage()
//    }
//}

  
