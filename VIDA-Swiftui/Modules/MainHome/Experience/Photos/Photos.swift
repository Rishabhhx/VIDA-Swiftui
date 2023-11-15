//
//  Photos.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 27/09/22.
//

import SwiftUI
import PhotosUI

struct Photos: View {
    @StateObject var photosModel : PhotosModel = .init()
    var body: some View {
        NavigationStack {
            VStack {
                if !photosModel.loadedImages.isEmpty {
                    TabView {
                        ForEach(photosModel.loadedImages) { mediaFile in
                            mediaFile.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height: 250)
                }
            }
            .navigationTitle("Photos")
            .toolbar() {
                PhotosPicker(selection: $photosModel.selectedPhotos, matching: .any(of: [.images]), photoLibrary: .shared()) {
                    Image(systemName: "photo.fill")
                }
                PhotosPicker(selection: $photosModel.selectedMultiplePhotos, matching: .any(of: [.images]), photoLibrary: .shared()) {
                    Image(systemName: "photo.fill")
                }
            }
        }
    }
}

struct Photos_Previews: PreviewProvider {
    static var previews: some View {
        Photos()
    }
}
