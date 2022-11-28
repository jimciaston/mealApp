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
struct ProfilePicture: View {
    @ObservedObject var vm = DashboardLogic()
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
  
    var body: some View {
       
            VStack{
                if let inputImage = inputImage {
                    Image(uiImage: inputImage)
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width:150, height: 150)
                     .clipShape(Circle())
                     
                 } else {
                     WebImage(url: URL(string: vm.userModel?.profilePictureURL ?? ""))
                         .placeholder(Image("profileDefaultPicture").resizable())
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width:150, height: 150)
                             .clipShape(Circle())
                             .shadow(color: Color("LightWhite"), radius: 9, x: 0, y: 13)
        
                 }
                    
                Button(action: {
                    print("fj")
                    showingImagePicker = true
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
            
    
        //SAVE IMAGE TO DATABASE (FIREBASE)
        .onChange(of: inputImage, perform: { _ in
            persistImageToStorage() //call to save function
        })
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
                    
                    Firestore.firestore().collection("users").document(uid).setData([ "profilePicture": url.absoluteString ], merge: true)
                }
            }
        }
        
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicture()
    }
}
