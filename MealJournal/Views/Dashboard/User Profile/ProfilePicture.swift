//
//  ProfilePicture.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/13/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI
import Photos
import Kingfisher

struct UrlImageView: View {
    @StateObject var urlImageModel: UrlImageModel
    @State var pictureUpdated = false
    @Binding var inputImage: UIImage?
  
    @Binding var testLink: String
    
    init(testLink: Binding<String>, inputImage: Binding<UIImage?>) {
          _urlImageModel = StateObject(wrappedValue: UrlImageModel(urlString: testLink.wrappedValue))
          _inputImage = inputImage
          _testLink = testLink
      }
  
    var body: some View {
        if let image = inputImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(color: Color("LightWhite"), radius: 9, x: 0, y: 13)
                    .onChange(of: testLink, perform: { newValue in
                        urlImageModel.image = inputImage
                        urlImageModel.urlString = testLink
                        urlImageModel.imageCache.removeCache(forKey: testLink)
                        urlImageModel.newImageAdded = true
                        urlImageModel.loadImage()
                        urlImageModel.newImageAdded = false
                    })
                    
            }  else {
                Image(uiImage: urlImageModel.image ?? ProfilePicture.placeholderProfileImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(color: Color("LightWhite"), radius: 9, x: 0, y: 13)
                    .id(UUID()) // Add a unique identifier
            }
    }

}

struct ProfilePicture: View {
    @State var showingPhotoPermissionAlert = false
    @State var pictureUpdated = false
    @StateObject var vm = DashboardLogic()
   
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
    
  
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var profilePicURL: String
    
    static var placeholderProfileImage = UIImage(named: "profileDefaultPicture" )
    
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
                  
                  
                    profilePicURL = url.absoluteString
                   
                    //save to firestore
                    Firestore.firestore().collection("users").document(uid).setData([ "profilePicture": url.absoluteString ], merge: true)
                    
                }
            }
        }
    
    //store in cache
    
    var body: some View {
            VStack{
                UrlImageView(testLink: $profilePicURL, inputImage: $inputImage)
                   
                Button(action: {
                   checkPermission()
                   
                }){
                    Image(systemName:("plus.circle.fill"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(Color("ButtonTwo"))
                        .frame(width:30, height:25)
                       
                       
                }
                .padding(.top, -20)
                .padding(.leading, 50)
                .edgesIgnoringSafeArea(.all)
            //PRESENT PICKER
        }
         
            .sheet(isPresented: $showingImagePicker){
                ProfilePictureImageEditor(imageProfile: $inputImage)
                
            }
            .alert(isPresented: $showingPhotoPermissionAlert) {
                       Alert(
                           title: Text("Permission Required"),
                           message: Text("To access your photos so you may upload from your library, please go to Settings > Privacy > Photos and enable permissions for Macro Mate."),
                           primaryButton: .default(Text("Go to Settings"), action: {
                               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                   return
                               }
                               UIApplication.shared.open(settingsUrl)
                           }),
                           secondaryButton: .cancel()
                       )
                   }
               
    
        //SAVE IMAGE TO DATABASE (FIREBASE)
        .onChange(of: inputImage, perform: { _ in
            persistImageToStorage()
         
         
        })
}
        

        
}
//
//struct ProfilePicture_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePicture()
//    }
//}
