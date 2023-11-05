//
//  File.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/24/23.
//

import SwiftUI
import UIKit
import TOCropViewController

// A SwiftUI wrapper for UIImagePickerController from UIKit.
struct ImagePicker: UIViewControllerRepresentable {
    
    // Binding to a UIImage to store the selected image
    @Binding var selectedImage: UIImage?
    
    // Enviroment property to manage the presentation state of this view
    @Environment(\.presentationMode) var presentationMode

    var useCamera: Bool
    // Function to create the coordinator which handles the communication between
    // the UIImagePickerController and the SwiftUI view
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    // Function to create the UIImagePickerController instnce
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        if useCamera && UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
}


// Image selector class
extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TOCropViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // Image picker function
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                parent.presentationMode.wrappedValue.dismiss()
                return
            }

            let cropController = TOCropViewController(croppingStyle: .default, image: image)
            cropController.delegate = self
            cropController.customAspectRatio = CGSize(width: 1, height: 1)

            // Lock the aspect ratio and disable the user's ability to change it
            cropController.aspectRatioLockEnabled = true
            cropController.resetAspectRatioEnabled = false
            cropController.aspectRatioPickerButtonHidden = true

            // Present the TOCropViewController
            picker.pushViewController(cropController, animated: true)
        }
        
        // Crop Controller
        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
            parent.selectedImage = image
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        // Image picker cancel
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

