//
//  DocPicker.swift
//  UploadDocuments
//
//  Created by Nelson Gonzalez on 4/25/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import MobileCoreServices

struct DocPicker : UIViewControllerRepresentable {

    @ObservedObject var getData: getData
    @Binding var show : Bool
    @Binding var isLoading : Bool
    
    func makeCoordinator() -> Coordinator {
        
        return DocPicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeItem)], in: .open)
        picker.allowsMultipleSelection = false
        picker.shouldShowFileExtensions = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        
        
    }
    
    class Coordinator : NSObject, UIDocumentPickerDelegate{
        
        var parent : DocPicker
        
        init(parent1 : DocPicker) {
            
            parent = parent1
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            
            self.parent.show = false
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            
            guard let url = urls.first else { return }
            let fileName = url.lastPathComponent
            url.startAccessingSecurityScopedResource()
    
            do {
            let data = try Data(contentsOf: url)
                parent.getData.uploadToTheServer(fileName: fileName, data: data)
                self.parent.isLoading = false
                } catch {
                    print(error)
                }
            url.stopAccessingSecurityScopedResource()
            parent.getData.updateData(name: fileName, type: "doc", url: url)
            
            
            self.parent.show = false
            self.parent.isLoading = true
        }

    }
}
