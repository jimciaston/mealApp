//
//  RecipeImagePicker.swift
//  MealJournal
//
//  Created by Jim Ciaston on 5/9/22.
//

import PhotosUI
import SwiftUI

/*
 ****BELOW EXPLANATION
 
 IMplemented this originally, but was getting issue in console that call was taking over 30 seconds, improved process with help from hacking swift(; much better implementation, now need to study why,
 
 */
//
//struct EditorImagePicker: UIViewControllerRepresentable {
//
//    @Binding var image: UIImage?
//
//    private let controller = UIImagePickerController()
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//        let parent: EditorImagePicker
//
//        init(parent: EditorImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            parent.image = info[.originalImage] as? UIImage
//            picker.dismiss(animated: true)
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss(animated: true)
//        }
//
//    }
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//        controller.delegate = context.coordinator
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//    }
//
//}




struct EditorImagePicker: UIViewControllerRepresentable{
    @Binding var imageForRecipe: UIImage?

    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        var parent: EditorImagePicker

        init(_ parent: EditorImagePicker){
            self.parent = parent
            print("locator b")
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){image, _ in
                    DispatchQueue.main.async {
                        self.parent.imageForRecipe = image as? UIImage
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
