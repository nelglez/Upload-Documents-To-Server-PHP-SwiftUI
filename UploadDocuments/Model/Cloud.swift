//
//  Cloud.swift
//  UploadDocuments
//
//  Created by Nelson Gonzalez on 4/25/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Cloud: Identifiable {
     var id = UUID()
     var name: String
     var type: String
     var url: URL
 }
