//
//  CellView.swift
//  UploadDocuments
//
//  Created by Nelson Gonzalez on 4/25/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct CellView: View {
     var data : Cloud
         
         var body : some View{
             
             HStack(spacing: 15){
                 
                 Image(data.type == "image/jpeg" ? "pic" : "doc")
                 .resizable()
                 .renderingMode(.original)
                 .frame(width: 55, height: 55)
                 
                Text(data.name)
                     .fontWeight(.bold)
                 
                 Spacer()
                 
             }.padding()
             .background(Color.white)
             .cornerRadius(10)
         }
         
        
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(data: Cloud(name: "test", type: "image", url: URL(string: "https://www.google.com")!))
    }
}
