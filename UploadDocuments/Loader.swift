//
//  Loader.swift
//  UploadDocuments
//
//  Created by Nelson Gonzalez on 4/25/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct Loader: View {
     @State var show = false
         
         var body : some View{
             
             Circle()
                 .trim(from: 0, to: 0.8)
                 .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                 .frame(width: 35, height: 35)
                 .rotationEffect(.init(degrees: self.show ? 360 : 0))
                 .animation(Animation.default.repeatForever(autoreverses: false).speed(1))
                 .padding(40)
                 .background(Color.white)
                 .cornerRadius(15)
                 .onAppear {
                     
                     self.show.toggle()
             }
         }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
