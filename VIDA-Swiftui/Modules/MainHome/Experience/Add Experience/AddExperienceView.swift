//
//  AddExperienceView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 21/09/22.
//

import SwiftUI
import PhotosUI

struct AddExperienceView: View {
    @Binding var experience : String
    @State var detail : String = ""
    @State var isEditing : Bool = false
    @State var selectedItems : [PhotosPickerItem] = []
    @State var selectedPhotoData : [Data] = []
    @Binding var location : String
    @Binding var coverImage: Image?
    @State var experienceImages : [Image] = []
    @State var dataObject = ExperienceCellModel(name: "", userName: "", title: "", descriptionLabel: "", locationLabel: "", coverImage: Image(""), profileImage: "", likeCount: 0, likeButton: false, travelerFeatured: false, experienceImages: [Image("")])
    @State var experienceImageReq : Bool = false
    
    var name : String = UserDefaults.standard.object(forKey: "name") as? String ?? "R"
    var username : String = UserDefaults.standard.object(forKey: "username") as? String ?? "r"
    let dismissCreateExperience : () -> Void

    var body: some View {
            VStack(spacing: 0) {
                AddExperienceHeader(dataObject: $dataObject, name: name, username: username, experience: $experience, detail: $detail, location: $location, coverImage: $coverImage, experienceImages: $experienceImages, experienceImageReq: $experienceImageReq, dismissCreateExperience: dismissCreateExperience)
                    .onTapGesture {
                        withAnimation() {
                            isEditing = false
                        }
                    }
                Divider()
                if !isEditing {
                    AddExperienceProfile(location: $location, name: name, username: username)
                        .transition(.move(edge: .top))
                    Divider()
                }
                AddExperienceContent(experience: $experience, detail: $detail, isEditing: $isEditing)
                Spacer()
                if experienceImageReq {
                    ToastMessage(req: $experienceImageReq, text: "Please add at least 1 experience image")
                        .padding(.bottom, 10)
                }
                if !isEditing {
                    if selectedPhotoData.count > 0
                    {
                        ShowExperienceImages(selectedItems: $selectedItems, selectedPhotoData: $selectedPhotoData, experienceImages: $experienceImages)
                    } else {
                        PhotosPicker(selection: $selectedItems, maxSelectionCount: 4, matching: .images) {
                            AddImage()
                                .transition(.move(edge: .bottom))
                        }
                        .onChange(of: selectedItems) { newItems in
                            for newItem in newItems {
                                Task {
                                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                                        if selectedPhotoData.isEmpty {
                                            selectedPhotoData.append(data)
                                        }
                                        else if !selectedPhotoData.contains(data) {
                                            selectedPhotoData.append(data)
                                            print(selectedPhotoData)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .hideKeyboardWhenTappedAround()
            .background(.white)
            .onTapGesture {
                withAnimation() {
                    isEditing = false
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

//struct AddExperienceView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddExperienceView(coverImage: Image(""), dismissCreateExperience: {})
//    }
//}

struct AddExperienceHeader: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var dataObject : ExperienceCellModel
    var name : String = "R"
    var username : String = "r"
    @Binding var experience : String
    @Binding var detail : String
    @Binding var location : String
    @Binding var coverImage : Image?
    @State var moveToExperienceDetail : Bool = false
    @Binding var experienceImages : [Image]
    @State var showPostOptions : Bool = false
    @State var moveBackToTab : Bool = false
    @Binding var experienceImageReq : Bool
    let dismissCreateExperience : () -> Void
    @State var postExperience : Bool = false
    @State var refresh : Bool = false
    var body: some View {
        HStack(spacing: 20) {
            Image("chevron-back")
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            NavigationLink(destination: ExperienceDetailView(selectedIndex: 0, dataObject: dataObject), isActive: $moveToExperienceDetail) {
                Button(action: {
                    self.dataObject = ExperienceCellModel(name: name, userName: username, title: experience, descriptionLabel: detail, locationLabel: location, coverImage: coverImage ?? Image(""), profileImage: "spain1", likeCount: 0, likeButton: false, travelerFeatured: false, experienceImages: experienceImages)
                    moveToExperienceDetail.toggle()
                }) {
                    Text("Preview")
                        .font(.custom("Gill Sans", size: 18))
                        .fontWeight(.light)
                }
                .foregroundColor(.black)
            }
                Text("Share")
                    .font(.custom("Gill Sans", size: 18))
                    .fontWeight(.light)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 50)
                        .fill(Color(red: 208/255, green: 231/255, blue: 220/255)))
                    .sheet(isPresented: $showPostOptions, onDismiss: {
                        if postExperience {
                            moveBackToTab.toggle()
                            experienceCellModelObj.append(ExperienceCellModel(name: name, userName: username, title: experience, descriptionLabel: detail, locationLabel: location, coverImage: coverImage ?? Image(""), profileImage: "spain1", likeCount: 0, likeButton: false, travelerFeatured: false, experienceImages: experienceImages))
                            userProfileObj.createdExperience.append(ExperienceCellModel(name: name, userName: username, title: experience, descriptionLabel: detail, locationLabel: location, coverImage: coverImage ?? Image(""), profileImage: "spain1", likeCount: 0, likeButton: false, travelerFeatured: false, experienceImages: experienceImages))
                            userProfileObj.createdLocation.append(LocationCellModel(place: "New Building", location: "Barcelona", coverImage: Image("location1"), likeCount: 2, likeButton: false, country: "Spain", locationDescription: "similar to the way dolphins and bats communicate! LoRa modulated transmission",onVida: true))
                            self.dismissCreateExperience()
                        }
                    }) {
                        PostOptionsView(showPostOptions: $showPostOptions, postExperience: $postExperience)
                            .presentationDetents([.medium])
                    }
                    .onTapGesture {
                        if experienceImages.count != 0 {
                            self.showPostOptions.toggle()
                        } else {
                            experienceImageReq = true
                        }
                    }
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
        .padding(.bottom, 20)
    }
}

struct AddExperienceProfile: View {
    @Binding var location : String
    @State var moveToSearchLocation : Bool = false
    var name : String = ""
    var username : String = ""
    var body: some View {
        HStack {
            HStack {
                Image("kprofilePlaceholder")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                    .onAppear() {
                        UserDefaults.standard.set("Rishabh", forKey: "name")
                        UserDefaults.standard.set("rishabh11", forKey: "username")
                    }
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("\(name)")
                            .fontWeight(.medium)
                            .font(.custom("Gill Sans", size: 20))
                        if true {
                            Image("featured-traveller-profile")
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                    }
                    Text("@\(username)")
                        .font(.custom("Gill Sans", size: 15))
                        .foregroundColor(.secondary)
                }
                Spacer()
                NavigationLink(destination: SearchLocationView(location: $location), isActive: $moveToSearchLocation) {
                    Button(action: {}) {
                        AddLocation(location: $location)
                            .foregroundColor(.black)
                            .onTapGesture {
                                moveToSearchLocation.toggle()
                            }
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 8)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 230/255, green: 230/255, blue: 230/255)))
                }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
    }
}

struct AddExperienceContent: View {
    @Binding var experience: String
    @Binding var detail: String
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack {
            TextField("", text: $experience, axis: .vertical)
                .lineLimit(1...3)
                .placeholder(when: experience.isEmpty, placeholder: {
                    Text("Add your experience title here..")
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                })
                .font(.custom("Gill Sans", size: 30))
                .fontWeight(.bold)
            TextField("", text: $detail, axis: .vertical)
                .lineLimit(1...40)
                .onChange(of: detail, perform: {_ in
                    withAnimation() {
                        isEditing = true
                    }
                })
                .lineLimit(1...3)
                .placeholder(when: detail.isEmpty, placeholder: {
                    Text("Add your experience detail here..")
                        .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
                        .lineLimit(1)
                })
                .onTapGesture {
                    withAnimation() {
                        isEditing = true
                    }
                }
        }
        .transition(.scale)
        .padding(20)
    }
}

struct AddImage: View {
    var body: some View {
        Image("kimageplaceholderLarge")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.secondary)
            .frame(width: 30, height: 30)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color(red: 208/255, green: 231/255, blue: 220/255))
            .padding(.bottom, 40)
    }
}

struct ExperienceImagesAdd: View {
    @State private var selection = 0
    @Binding var selectedPhotoData : [Data]
    @Binding var experienceImages : [Image]
    
    public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(selectedPhotoData.indices, id: \.self) { index in
                if let image = UIImage(data: selectedPhotoData[index]) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .onAppear() {
                            experienceImages.append(Image(uiImage: image))
                        }
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .onReceive(timer, perform: {_ in
            withAnimation {
                selection = selection < selectedPhotoData.count ? selection + 1 : 0
                print(selection)
            }
        })
        .frame(height: 300)
    }
}

struct ShowExperienceImages: View {
    @Binding var selectedItems : [PhotosPickerItem]
    @Binding var selectedPhotoData : [Data]
    @Binding var experienceImages : [Image]
    var body: some View {
        VStack {
            ZStack {
                ExperienceImagesAdd(selectedPhotoData: $selectedPhotoData, experienceImages: $experienceImages)
                VStack {
                    HStack {
                        PhotosPicker(selection: $selectedItems, maxSelectionCount: 4, matching: .images) {
                            Image("keditor-mediaeditcircle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .transition(.move(edge: .bottom))
                        }
                        .onChange(of: selectedItems) { newItems in
                            for newItem in newItems {
                                Task {
                                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                                        if selectedPhotoData.isEmpty {
                                            selectedPhotoData.append(data)
                                        }
                                        else if !selectedPhotoData.contains(data) {
                                            selectedPhotoData.append(data)
                                            print(selectedPhotoData)
                                        }
                                    }
                                }
                            }
                        }
                        Image("keditor-delete")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Spacer()
                    }
                    .padding(20)
                    Spacer()
                }
            }
            .frame(height: 300)
            .transition(.move(edge: .bottom))
        }
    }
}
