//
//  MediaFile.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 27/09/22.
//

import SwiftUI

struct MediaFile: Identifiable {
    var id : String = UUID().uuidString
    var image : Image
    var data : Data
    
}
