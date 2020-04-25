//
//  ImagePicker.swift
//  UploadDocuments
//
//  Created by Nelson Gonzalez on 4/25/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {

    @Binding var show : Bool
    @Binding var isLoading : Bool
    
    func makeCoordinator() -> Coordinator {
        
        return ImagePicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
        
    }
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        var parent : ImagePicker
        
        init(parent1 : ImagePicker) {
            
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            self.parent.show = false
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let url = info[.imageURL] as! URL
            

            //Handel uploading image to the server.
            
            self.parent.show = false
            self.parent.isLoading = true
        }
    }
}
