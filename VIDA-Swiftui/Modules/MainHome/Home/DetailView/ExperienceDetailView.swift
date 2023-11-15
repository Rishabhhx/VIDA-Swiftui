//
//  ExperienceDetailView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 06/09/22.
//

import SwiftUI

struct ExperienceDetailView: View {
    
    var selectedIndex : Int = 0
    @State var moveToExperienceAgain : Bool = false
    @State var getIndex: Int = 0
    @State var showToast : Bool = false
    var dataObject : ExperienceCellModel

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    SelectedExperienceDetailsCell(selectedIndex: selectedIndex, dataObject: dataObject, showTost: $showToast)
                    ExperienceUserDetails(dataObject: dataObject)
                    Divider()
                    TitleAndDescription(dataObject: dataObject)
                    ExperienceImages(dataObject: dataObject)
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Related experiences")
                            .font(.custom("Gill Sans", size: 20))
                            .fontWeight(.semibold)
                            .padding(.horizontal, 30)
                        VStack(alignment: .leading) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 0) {
                                    ForEach(0..<4, id: \.self) { item in
                                        if !(experienceCellModelObj[item].id == dataObject.id) {
                                            NavigationLink(destination: ExperienceDetailView(selectedIndex: getIndex, dataObject: experienceCellModelObj[getIndex]), isActive: $moveToExperienceAgain) {
                                                VStack(alignment: .leading) {
                                                    ExperienceCellHeaderView(profileImage: experienceCellModelObj[item].profileImage, name: experienceCellModelObj[item].name, userName: experienceCellModelObj[item].userName, travlerFeatured: experienceCellModelObj[item].travelerFeatured)
                                                    ExperienceCellContentView(likeButton: experienceCellModelObj[item].likeButton, likeCount: experienceCellModelObj[item].likeCount, title: experienceCellModelObj[item].title, descriptionLabel: experienceCellModelObj[item].descriptionLabel, locationLabel: experienceCellModelObj[item].locationLabel, coverImage: experienceCellModelObj[item].coverImage, index: 0, height: 350)
                                                }
    //                                            .frame(width: UIScreen.main.bounds.width - 60)
                                                .padding(5)
                                                .onTapGesture {
                                                    self.getIndex = item
                                                    self.moveToExperienceAgain.toggle()
                                                }
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationTitle("")
            .navigationBarHidden(true)
            VStack {
                Spacer()
                if showToast {
                    ToastMessage(req: $showToast, text: "Experience already saved in this list")
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

//struct ExperienceDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExperienceDetailView( dataObject: experienceCellModelObj[0])
//    }
//}

struct ExperienceDetailHeader: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.white)
                Button(action: {} ) {
                    Image("kblackCross")
                        .renderingMode(.original)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            .frame(width: 35, height: 35)
            Spacer()
            ZStack {
                Circle()
                    .fill(.white)
                Button(action: {} ) {
                    Image("koptionsdots")
                        .renderingMode(.original)
                }
            }
            .frame(width: 35, height: 35)
        }
        .padding(.top, 50)
        .padding(.horizontal, 20)
    }
}

struct SavePinLikeShareButtons: View {
    @State var likeButton : Bool = false
    @State var likeCount : Int = 4
    var dataObject : ExperienceCellModel
    @State var refresh : Bool = false
    @State var moveToAddSave : Bool = false
    @Binding var showTost : Bool
    var index : Int = 0

    var body: some View {
        HStack {
            Button(action: {
                moveToAddSave.toggle()
            }) {
                ZStack {
                    Circle()
                        .fill(.white)
                        Image("klocdetail-save")
                }
                .frame(width: 35, height: 35)
            }
            .buttonStyle(.plain)
            .fullScreenCover(isPresented: $moveToAddSave) {
                CreateListView(refresh: $refresh, saveListType: .save, dataObject: dataObject, showToast: $showTost)
            }
            ZStack {
                Circle()
                    .fill(.white)
                Button(action: {} ) {
                    Image("klocdetail-pin")
                }
            }
            .frame(width: 35, height: 35)
            ZStack {
                Circle()
                    .fill(.white)
                Button(action: {
                    self.likeButton.toggle()
                    if likeButton {
                        likeCount += 1
                        experienceCellModelObj[index].likeCount = likeCount
                        experienceCellModelObj[index].likeButton = likeButton
                    } else {
                        likeCount -= 1
                        experienceCellModelObj[index].likeButton = likeButton
                        experienceCellModelObj[index].likeCount = likeCount
                    }
                }) {
                    if likeButton {
                        Image("khome-likebutton")
                    } else {
                        Image("klocdetail-unlike")
                    }
                }
            }
            .frame(width: 35, height: 35)
            ZStack {
                Circle()
                    .fill(.white)
                Button(action: {actionSheet()} ) {
                    Image("klocdetail-share")
                }
            }
            .frame(width: 35, height: 35)
        }
        .foregroundColor(Color.black)
    }
    func actionSheet() {
        let activityVC = UIActivityViewController(activityItems: [dataObject.title, dataObject.coverImage], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
       }
}

struct ExperienceDetailButton: View {
    var selectedIndex : Int = 0
    var dataObject : ExperienceCellModel
    @Binding var showTost : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ViewHeading(text: dataObject.title, size: 30, topPadding: 0)
                .foregroundColor(Color.white)
            HStack {
                Image("klocationpin-alternate")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.white)
                Text(dataObject.locationLabel)
                    .font(.custom("Gill Sans", size: 20))
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                Spacer()
                SavePinLikeShareButtons(likeButton: dataObject.likeButton, likeCount: dataObject.likeCount, dataObject: dataObject, showTost: $showTost, index: selectedIndex)
            }
            .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 40)
    }
}

struct SelectedExperienceDetailsCell: View {
    var selectedIndex : Int = 0
    var dataObject : ExperienceCellModel
    @Binding var showTost : Bool

    var body: some View {
        ZStack {
            dataObject.coverImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            Image("blackOverlay")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                .opacity(0.25)
                .ignoresSafeArea()
            VStack {
                ExperienceDetailHeader()
                Spacer()
                ExperienceDetailButton(selectedIndex: selectedIndex, dataObject: dataObject, showTost: $showTost)
            }
        }
        .frame(height: UIScreen.main.bounds.height*2 / 3 )
    }
}

struct ExperienceUserDetails: View {
    var selectedIndex : Int = 0
    var dataObject : ExperienceCellModel
    
    var body: some View {
        HStack {
            UsernameImage(selectedIndex: selectedIndex, dataObject: dataObject)
            Spacer()
            HStack {
                Image("klocationpin-alternate")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(dataObject.locationLabel)
                    .font(.custom("Gill Sans", size: 16))
                    .fontWeight(.semibold)
            }
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary, lineWidth: 0.4))
        }
        .padding(.horizontal, 20)
    }
}

struct TitleAndDescription: View {
    var selectedIndex : Int = 0
    var dataObject : ExperienceCellModel
    
    var body: some View {
        VStack(alignment : .leading, spacing: 20) {
            Text(dataObject.title)
                .font(.custom("Gill Sans", size: 25))
                .fontWeight(.semibold)
            Text(dataObject.descriptionLabel)
                .font(.custom("Gill Sans", size: 20))
                .fontWeight(.regular)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 30)
    }
}

struct ExperienceImages: View {
    var selectedIndex : Int = 0
    var dataObject : ExperienceCellModel
    
    public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(dataObject.experienceImages.indices, id: \.self) { index in
                dataObject.experienceImages[index]
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .onReceive(timer, perform: {_ in
            withAnimation {
                selection = selection < dataObject.experienceImages.count ? selection + 1 : 0
            }
        })
        .frame(height: 400)
    }
}

struct UsernameImage: View {
    var selectedIndex : Int = 0
    var dataObject : ExperienceCellModel
    
    var body: some View {
        HStack {
            Image(dataObject.profileImage)
                .resizable()
                .frame(width: 45, height: 45)
                .cornerRadius(50)
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 5) {
                    Text(dataObject.name)
                        .font(.custom("Gill Sans", size: 20))
                        .fontWeight(.semibold)
                    if dataObject.travelerFeatured {
                        Image("featured-traveller-profile")
                    }
                }
                Text("@\(dataObject.userName)")
                    .font(.custom("Gill Sans", size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(Color.secondary)
            }
        }
    }
}
