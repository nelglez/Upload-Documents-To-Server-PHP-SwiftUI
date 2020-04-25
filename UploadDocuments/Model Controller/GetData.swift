//
//  GetData.swift
//  UploadDocuments
//
//  Created by Nelson Gonzalez on 4/25/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation

class getData : ObservableObject{
    
    @Published var data = [Cloud]()
 
    func updateData(name: String, type: String, url: URL){
        let newData = Cloud(name: name, type: type, url: url)
        self.data.append(newData)
    }
    
    func uploadToTheServer(fileName: String, data: Data) {
        
   
        let myUrl = URL(string: "https://www.ultimate-teenchat.com/test-app/uploadDocument.php")!
        let request = NSMutableURLRequest(url: myUrl)
        request.httpMethod = "POST"
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        let fname = fileName
        //remoteName
        let mimetype = "text/plain"
        
        body.append("--\(boundary)\r\n".data(
            using: String.Encoding.utf8,
            allowLossyConversion: false)!)
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(
            using: String.Encoding.utf8,
            allowLossyConversion: false)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        
        body.append(data)
        body.append("\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        request.setValue(String(body.count), forHTTPHeaderField: "Content-Length")
        
        request.httpBody = body
        
        
        let session = Foundation.URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString as Any)
            
        }
        
        task.resume()
        
        
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    
}
