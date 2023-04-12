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

struct UrlImageView: View, Equatable {
    @ObservedObject var urlImageModel: UrlImageModel
    
    static func == (lhs: UrlImageView, rhs: UrlImageView) -> Bool {
          return lhs.urlImageModel.urlString == rhs.urlImageModel.urlString
      }
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        if urlImageModel.isLoading {
            // show loading indicator
            ProgressView()
                .frame(width: 150, height: 150)
        } else {
            Image(uiImage: urlImageModel.image ?? ProfilePicture.placeholderProfileImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(color: Color("LightWhite"), radius: 9, x: 0, y: 13)
        }
    }
}

struct ProfilePicture: View {
    @State var showingPhotoPermissionAlert = false
    
    
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
                print("User do not have access to photo album.")
            //handle user deny
            case .denied:
                showingPhotoPermissionAlert = true
            
        @unknown default:
               // Handle any future cases that may be added to the `PHAuthorizationStatus` enumeration.
               print("Unknown authorization status.")
           
        }
    }
    
    
    @StateObject var vm = DashboardLogic()
    
    let placeholderImage = UIImage(named: "profileDefaultPicture") // << placeholderImage
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var profilePicURL = ""
    
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
                    //save to firestore
                    Firestore.firestore().collection("users").document(uid).setData([ "profilePicture": url.absoluteString ], merge: true)
                }
            }
        }
    
    //store in cache
    
    var body: some View {
       
            VStack{
                UrlImageView(urlString: vm.userModel?.profilePictureURL)
                    .equatable()
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
                EditorImagePicker(image: $inputImage)
                
            }
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
               
    
        //SAVE IMAGE TO DATABASE (FIREBASE)
        .onChange(of: inputImage, perform: { _ in
            persistImageToStorage() //call to save function
        })
}
        

        
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicture()
    }
}
