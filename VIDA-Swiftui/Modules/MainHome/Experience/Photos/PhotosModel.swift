//
//  PhotosModel.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 27/09/22.
//

import SwiftUI
import PhotosUI
extension Photos {
    class PhotosModel : ObservableObject {
        @Published var loadedImages : [MediaFile] = []
        @Published var selectedPhotos : PhotosPickerItem? {
            didSet {
                if let selectedPhotos {
                    processPhoto(photo: selectedPhotos)
                }
            }
        }
        @Published var selectedMultiplePhotos : [PhotosPickerItem] = [] {
            didSet {
                for photo in selectedMultiplePhotos {
                     processPhoto(photo: photo)
                }
            }
        }
        func processPhoto(photo: PhotosPickerItem) {
            photo.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        if let data, let image = UIImage(data: data) {
                            print("Image Found")
                            self.loadedImages.append(.init(image: Image(uiImage: image), data: data))
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }
    }
}
