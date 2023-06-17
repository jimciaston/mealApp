//
//  ImageUpdateSelector.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/24/23.
//

import SwiftUI

import SwiftUI
import UIKit
import FirebaseFirestore
import SDWebImageSwiftUI
import _PhotosUI_SwiftUI

@available(iOS 16.0, *)
struct ImageUpdateSelector: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeClass: Recipe
    @State private var showingImagePicker = false
    @State private var inputImage: Image?
    @Binding var selectedRecipeImage: PhotosPickerItem?
    @ObservedObject var ema: EditModeActive
    @Binding var imageURL: String
    var body: some View {
        if ema.editMode{
            VStack{
                ZStack (alignment: .trailing){
                    if let url = URL(string: imageURL) {
                        WebImage(url: url).resizable()
                            .placeholder(Image("defaultRecipeImage-2").resizable())
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
                    }
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
                                        print("Image saved Successfully")
                                        guard let url = url else { return }
                                        imageURL = url.absoluteString
                                        ema.recipeImage = url.absoluteString // Save the image URL to the recipe model
                                        dismiss()
                                    }
                                }
                                return
                            }
                        }
                    }
                }
                
                
                
            }
        }
        else{
            VStack{
                WebImage(url: URL(string: imageURL))
                    .placeholder(Image("defaultRecipeImage-2").resizable())
                    .resizable()
                    .frame(width:250, height: 170)
                    .cornerRadius(15)
            }
        }
    }
}

//struct ImageUpdateSelector_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEditorImage()
//    }
//}
