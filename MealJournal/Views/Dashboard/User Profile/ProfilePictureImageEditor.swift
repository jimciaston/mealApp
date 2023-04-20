//
//  ProfilePictureImageEditor.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/19/23.
//

import Foundation
import SwiftUI
import PhotosUI

struct ProfilePictureImageEditor: UIViewControllerRepresentable{
    @Binding var imageProfile: UIImage?
 
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        var parent: ProfilePictureImageEditor

        init(_ parent: ProfilePictureImageEditor){
            self.parent = parent
            print("locator a")
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){image, _ in
                    DispatchQueue.main.async {
                        self.parent.imageProfile = image as? UIImage
                    }
                }
            }
        }
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        //configures ios to just be able to select images
        var config = PHPickerConfiguration()
        config.filter = .images

        //the view of picker
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //leave empty for now
    }
}
