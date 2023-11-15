//
//  CreateListPopup.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 02/10/22.
//

import SwiftUI
import PhotosUI

struct CreateListPopup: View {
    
    @State var listName : String = ""
    @State var listImage : Image = Image("")
    @State var selectedPhotoData = Data()
    @State var selectedItem : PhotosPickerItem?
    @State var showAdd : Bool = true
    @Binding var showListPopup : Bool
    @State var listNameReq : Bool = false
    @State var listImageReq : Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                CreateListPopupHeader(showListPopup: $showListPopup)
                Divider()
                TextField("Listname", text: $listName)
                    .font(.custom("Gill Sans", size: 20))
                    .textFieldStyle(.roundedBorder)
                    .padding(20)
                AddImageSavedList(selectedPhotoData: $selectedPhotoData, showAdd: $showAdd, listImage: $listImage, selectedItem: $selectedItem)
                    .onChange(of: selectedItem) { newItem in
                        showAdd = false
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedPhotoData = data
                            }
                        }
                    }
                Button(action: {
                    if listName.count < 3 {
                        listNameReq = true
                    } else if listImage == Image("") {
                        listImageReq = true
                    } else {
                        savedListObj.insert(SavedListModel(listImage: listImage, listName: listName), at: 0)
                        showListPopup = false
                    }
                }) {
                    CreateButtonText()
                }
            }
            .background(.white)
            .cornerRadius(10)
            .padding(10)
            VStack {
                Spacer()
                if listNameReq {
                    ToastMessage(req: $listNameReq, text: "Enter List Name")
                } else if listImageReq {
                    ToastMessage(req: $listImageReq, text: "Enter List Image")
                }
            }
        }
        .transition(.move(edge: .bottom))
        .animation(.easeInOut)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
    }
}

//struct CreateListPopup_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateListPopup()
//    }
//}

struct CreateListPopupHeader: View {
    @Binding var showListPopup : Bool
    
    var body: some View {
        ZStack {
            HStack {
                Image("kblackCross")
                    .onTapGesture {
                        showListPopup = false
                    }
                Spacer()
            }
            
            Text("Create a new list")
                .font(.custom("Gill Sans", size: 18))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
    }
}

struct AddImageSavedList: View {
    @Binding var selectedPhotoData : Data
    @Binding var showAdd : Bool
    @Binding var listImage : Image
    @Binding var selectedItem : PhotosPickerItem?
    
    var body: some View {
        HStack {
            ZStack {
                if showAdd {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        
                        Image("create-List")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60, alignment: .center)
                            .cornerRadius(12)
                            .clipped()
                            .onAppear() {
                                selectedPhotoData.removeAll()
                                listImage = Image("")
                            }
                    }
                } else {
//                    if let selectedPhotoData, let image = UIImage(data: selectedPhotoData) {
//                        Image(uiImage: image)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 60, height: 60, alignment: .center)
//                            .cornerRadius(12)
//                            .clipped()
//                            .onAppear() {
//                                listImage = Image(uiImage: image)
//                            }
//                    }
                }
                if !showAdd {
                    DeleteListImage(showAdd: $showAdd, listImage: $listImage)
                }
            }
            if showAdd {
                AddImageText()
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
}

struct DeleteListImage: View {
    @Binding var showAdd : Bool
    @Binding var listImage : Image
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.white)
                Button(action: {
                    showAdd = true
                    listImage = Image("")
                } ) {
                    Image("kblackCross")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.black)
                }
                .padding(4)
            }
            .frame(width: 10, height: 10)
            .padding(6)
            Spacer()
        }
        .frame(width: 60, height: 60, alignment: .trailing)
    }
}

struct AddImageText: View {
    var body: some View {
        Text("Add Image")
            .font(.custom("Gill Sans", size: 18))
            .fontWeight(.light)
            .lineLimit(3)
            .padding(.leading, 15)
            .foregroundColor(.black)
    }
}

struct CreateButtonText: View {
    var body: some View {
        Text("Create")
            .font(.custom("Gill Sans", size: 20))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 58)
            .background(Color.init(.displayP3, red: 36/255, green: 62/255, blue: 54/255, opacity: 1.0))
            .cornerRadius(8)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
    }
}
