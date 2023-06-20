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
    @State var showingPhotoPermissionAlert = false
    @State private var showingImagePicker = false
    @State private var inputImage: Image?
    @State private var selectedRecipeImage: PhotosPickerItem?
    
    struct PhotoPermissionAlert: View {
        var body: some View {
            VStack {
                Text("Please grant permission to access your photos")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                Text("To grant permission, go to Settings > Privacy > Photos, and turn on the toggle next to the name of this app.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }) {
                    Text("Open Settings")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
            case .authorized:
                showingImagePicker = true
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({
                    (newStatus) in
                    print("status is \(newStatus)")
                    if newStatus ==  PHAuthorizationStatus.authorized {
                        /* do stuff here */
                        showingImagePicker = true
                    }
                })
                print("It is not determined until now")
            case .restricted:
                // same same
                print("User does not have access to photo album.")
            //handle user deny
            case .denied:
                showingPhotoPermissionAlert = true
            
        @unknown default:
               // Handle any future cases that may be added to the `PHAuthorizationStatus` enumeration.
               print("Unknown authorization status.")
           
        }
    }
    
    
    
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
                       checkPermission()
                    }
                    .photosPicker(isPresented: $showingImagePicker, selection: $selectedRecipeImage)
                    
                    .alert(isPresented: $showingPhotoPermissionAlert) {
                               Alert(
                                   title: Text("Permission Required"),
                                   message: Text("To access your photos, please go to Settings > Privacy > Photos and enable permissions for this app."),
                                   primaryButton: .default(Text("Go to Settings"), action: {
                                       guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                           return
                                       }
                                       UIApplication.shared.open(settingsUrl)
                                   }),
                                   secondaryButton: .cancel()
                               )
                           }
                    
                    
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

  
