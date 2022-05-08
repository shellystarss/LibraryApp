//
//  ImagePicker.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import SwiftUI
import Combine

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var show: Bool
    @Binding var image: Data

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(child1: self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var child: ImagePicker

        init(child1: ImagePicker) {
            child = child1
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let image = info[.originalImage] as! UIImage
                
            let data = image.jpegData(compressionQuality: 0.45)
            
            self.child.image = data!
            self.child.show.toggle()

        }

    }
}
