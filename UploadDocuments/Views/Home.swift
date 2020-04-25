//
//  Home.swift
//  UploadDocuments
//
//  Created by Nelson Gonzalez on 4/25/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var expand = false
    @ObservedObject var data = getData()
    @State var show = false
    @State var type = ""
    @State var isLoading = false
    
    var body : some View{
        
        NavigationView{
            
            ZStack{
                
                Color.black.opacity(0.05).edgesIgnoringSafeArea(.all)
                
                ZStack(alignment: .bottomTrailing) {
                    
                    if self.data.data.count != 0 {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            VStack(spacing: 15){
                                
                                ForEach(self.data.data){i in
                                    
                                    CellView(data: i)
                                }
                            }
                            .padding()
                        }
                    }
                    
                    if self.data.data.isEmpty {
                        
                        GeometryReader{_ in
                            
                            VStack{
                                
                                Text("No Documents In Cloud !!!")
                            }
                        }
                    }
                    
                    VStack(spacing: 18){
                        
                        
                        if self.expand{
                            
                            Button(action: {
                                
                                self.expand.toggle()
                                self.type = "doc"
                                self.show.toggle()
                                
                            }) {
                                
                                Image(systemName: "doc.fill")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.blue)
                                    .padding()
                                
                            }
                            .background(Color.white)
                            .clipShape(Circle())
                            
                            Button(action: {
                                
                                self.expand.toggle()
                                self.type = "img"
                                self.show.toggle()
                                
                            }) {
                                
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.blue)
                                    .padding()
                                
                            }
                            .background(Color.white)
                            .clipShape(Circle())
                        }
                        
                        
                        Button(action: {
                            
                            withAnimation(.spring()){
                                
                                self.expand.toggle()
                            }
                            
                        }) {
                            
                            Image(systemName: self.expand ? "xmark" : "plus")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.blue)
                                .padding()
                            
                        }
                        .background(Color.white)
                        .clipShape(Circle())
                    }
                    .padding()
                }
                
            }
            .navigationBarTitle("Cloud",displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                
                VStack{
                    
                    if self.data.data.count != 0 && !self.isLoading {
                        
                        Button(action: {
                            
                            NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
                        }) {
                            
                            Image(systemName: "arrow.clockwise")
                            .resizable()
                            .frame(width: 15, height: 18)
                            .foregroundColor(.blue)
                        }
                    }
                }
            }))
        }
        .sheet(isPresented: self.$show) {
            
            if self.type == "doc" {
                
                DocPicker(getData: self.data, show: self.$show, isLoading: self.$isLoading)
            }
            else{
                
                ImagePicker(show: self.$show, isLoading: self.$isLoading)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
