//
//  ProfileView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 26/10/22.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State var selectedPhotoData = Data()
    @State var selectedPhotoDataBanner = Data()
    @State var selectedItem : PhotosPickerItem?
    @State var selectedItemBanner : PhotosPickerItem?
    @State var selectedSection : Sections = .locations
    @State var showAdd : Bool = true
    @State var profileImage : Image = userProfileObj.profilePicture
    @State var profileBanner : Image = userProfileObj.profileBanner

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        PictureAndBanner(selectedPhotoData: $selectedPhotoData,selectedPhotoDataBanner: $selectedPhotoDataBanner, selectedItem: $selectedItem, selectedItemBanner: $selectedItemBanner, showAdd: $showAdd, profileImage: $profileImage, profileBanner: $profileBanner)
                        LocationExperienceSection(selectedSection: $selectedSection)
                        SectionCells(selectedSection: $selectedSection)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                MapIcon()
            }
            .onAppear() {
                if userProfileObj.profilePicture != Image("") {
                    showAdd = false
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfilePictureView: View {
    @Binding var selectedPhotoData : Data
    @Binding var selectedItem : PhotosPickerItem?
    @Binding var showAdd : Bool
    @Binding var profileImage : Image
    @State var moveToFollowing : Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                    profileImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 72, height: 72)
                    .clipped()
                    .background(Circle()
                        .stroke(lineWidth: 2)
                        .fill(Color(red: 110/255, green: 109/255, blue: 109/255)))
                    .cornerRadius(50)
                    .background(Circle()
                        .stroke(lineWidth: 2)
                        .fill(.white))
                VStack {
                    Spacer()
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        
                        Image("keditor-mediaeditcircle")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding(-8)
                    }
                    .onChange(of: selectedItem ) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedPhotoData = data
                                    let image = UIImage(data: selectedPhotoData)
                                    userProfileObj.profilePicture = Image(uiImage: image!)
                                    profileImage = Image(uiImage: image!)
                                }
                            }
                        showAdd = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(width: 72, height: 72)
            HStack {
                Text(userProfileObj.name)
                    .font(.custom("Gill Sans", size: 26))
                    .fontWeight(.medium)
                if userProfileObj.isVerified {
                    Image("featured-traveller-profile")
                        .resizable()
                        .frame(width: 22, height: 22)
                }
            }
            .padding(.top, 18)
            Text(userProfileObj.username)
                .font(.custom("Gill Sans", size: 20))
                .fontWeight(.light)
                .padding(.top, 2)
            HStack(spacing : 8) {
                Image("klocationsVisited")
                Text("\(userProfileObj.placeVisited) Place Visited")
                    .font(.custom("Gill Sans", size: 20))
                    .fontWeight(.light)
            }
            .padding(.top, 15)
            HStack {
                Text("\(userProfileObj.followers)")
                    .font(.custom("Gill Sans", size: 20))
                    .fontWeight(.light)
                    .padding(.top, 15)
                NavigationLink(destination: Followers_Followings(), isActive: $moveToFollowing) {
                    Button(action: {
                        moveToFollowing.toggle()
                    }) {
                        Text("Followers")
                            .font(.custom("Gill Sans", size: 20))
                            .fontWeight(.light)
                            .padding(.top, 15)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .buttonStyle(PlainButtonStyle())

                Text("| \(userProfileObj.following)")
                    .font(.custom("Gill Sans", size: 20))
                    .fontWeight(.light)
                    .padding(.top, 15)
                NavigationLink(destination: Followers_Followings(), isActive: $moveToFollowing) {
                    Button(action: {
                        moveToFollowing.toggle()
                    }) {
                        Text("Following")
                            .font(.custom("Gill Sans", size: 20))
                            .fontWeight(.light)
                            .padding(.top, 15)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 20)
        .padding(.top, -36)
    }
}

struct ProfileBannerView: View {
    @Binding var selectedPhotoDataBanner : Data
    @Binding var selectedItemBanner : PhotosPickerItem?
    @Binding var showAdd : Bool
    @Binding var profileBanner : Image
    @State var pushToSettings : Bool = false
    var body: some View {
        ZStack {
            profileBanner
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 210)
                .clipped()
            VStack {
                Spacer()
                VStack {
                    PhotosPicker(selection: $selectedItemBanner, matching: .images) {
                        
                        Image("keditor-mediaeditcircle")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    .onChange(of: selectedItemBanner) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedPhotoDataBanner = data
                                    let image = UIImage(data: selectedPhotoDataBanner)
                                    userProfileObj.profileBanner = Image(uiImage: image!)
                                    profileBanner = Image(uiImage: image!)
                                }
                            }
                        showAdd = false
                    }
                    NavigationLink(destination: SettingsView(), isActive: $pushToSettings) {
                        Image("settings-profile")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .onTapGesture {
                                pushToSettings.toggle()
                            }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(height: 210)
    }
}

struct PictureAndBanner: View {
    @Binding var selectedPhotoData : Data
    @Binding var selectedPhotoDataBanner : Data
    @Binding var selectedItem : PhotosPickerItem?
    @Binding var selectedItemBanner : PhotosPickerItem?
    @Binding var showAdd : Bool
    @Binding var profileImage : Image
    @Binding var profileBanner : Image

    var body: some View {
        VStack(spacing: 0) {
            ProfileBannerView(selectedPhotoDataBanner: $selectedPhotoDataBanner, selectedItemBanner: $selectedItemBanner, showAdd: $showAdd, profileBanner: $profileBanner)
            ProfilePictureView(selectedPhotoData: $selectedPhotoData, selectedItem: $selectedItem, showAdd: $showAdd, profileImage: $profileImage)
        }
        .ignoresSafeArea()
    }
}

struct LocationExperienceSection: View {
    @Binding var selectedSection : Sections
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                selectedSection = .locations
            }) {
                if selectedSection == .locations {
                    SectionView(sectionTitle: "Locations", sectionTitleColor: Color.black, sectionLineColor: Color.green)
                    
                } else {
                    SectionView(sectionTitle: "Locations", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                }
            }
            Button(action: {
                selectedSection = .experience
            }) {
                if selectedSection == .experience {
                    SectionView(sectionTitle: "Experiences", sectionTitleColor: Color.black, sectionLineColor: Color.green)
                    
                } else {
                    SectionView(sectionTitle: "Experiences", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                }
            }
        }
        .padding(.top, 40)
    }
}

struct SectionCells: View {
    var column: [GridItem] = [
        GridItem(.flexible(), spacing: 20 ,alignment: .trailing),GridItem(.flexible(), alignment: .leading)]
    @Binding var selectedSection : Sections
    var body: some View {
        VStack {
            if selectedSection == .locations {
                    if userProfileObj.createdLocation.count == 0 {
                        NoSectionAdded(sectionText: "Locations")
                            .frame(height: UIScreen.main.bounds.height/3)
                    } else {
                        LazyVGrid(columns: column, spacing: 20) {
                            ForEach(userProfileObj.createdLocation.indices, id: \.self) { item in
                                ProfileCell(dataObjectLocation: userProfileObj.createdLocation[item], selectedSection: $selectedSection)
                            }
                        }
                        .padding(10)
                    }
            } else if selectedSection == .experience {
                ZStack {
                    if userProfileObj.createdExperience.count == 0 {
                        NoSectionAdded(sectionText: "Experience")
                            .frame(height: UIScreen.main.bounds.height/3)
                    } else {
                        LazyVGrid(columns: column, spacing: 20) {
                            ForEach(userProfileObj.createdExperience.indices, id: \.self) { item in
                                ProfileCell(dataObjectExperience: userProfileObj.createdExperience[item], selectedSection: $selectedSection)
                            }
                        }
                        .padding(10)
                    }
                }
            }
        }
    }
}

struct MapIcon: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(.white)
                    Image("kMapIcon")
                }
                .frame(width: 60,height: 60)
                .overlay(RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.black, lineWidth: 2))
            }
            .padding(.trailing, 20)
            .padding(.bottom, 40)
        }
    }
}
