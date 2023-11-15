//
//  ExperienceCell.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 05/09/22.
//

import SwiftUI

struct ExperienceCell: View {
    @State var moveToExperienceDetail : Bool = false
    var selectedExperienceType : ExperienceType = .all
    var cellData : CellDataType = .home
    var savedList = SavedListModel()
    var featuredExperienceCellModelObj = experienceCellModelObj.filter { $0.travelerFeatured }
    var nonExperienceCellModelObj = experienceCellModelObj.filter { $0.travelerFeatured == false }
    @State var getIndex: Int = 0
    @State var refresh : Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if refresh {
                Text("SFD")
            }
            if refresh || true {
                VStack(spacing: 30) {
                    if cellData == .lists {
                        ForEach(savedList.savedExperience.indices, id: \.self) { item in
                            NavigationLink(destination: ExperienceDetailView(selectedIndex: getIndex, dataObject: savedList.savedExperience[getIndex]), isActive: $moveToExperienceDetail) {
                                TypeExperienceView(experienceCellModelObj: savedList.savedExperience, getIndex: $getIndex, item: item, moveToExperienceDetail: $moveToExperienceDetail)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else {
                        if selectedExperienceType == .featuredTravellers {
                            ForEach(featuredExperienceCellModelObj.indices, id: \.self) { item in
                                NavigationLink(destination: ExperienceDetailView(selectedIndex: getIndex, dataObject: featuredExperienceCellModelObj[getIndex]), isActive: $moveToExperienceDetail) {
                                    TypeExperienceView(experienceCellModelObj: featuredExperienceCellModelObj, getIndex: $getIndex, item: item, moveToExperienceDetail: $moveToExperienceDetail)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        } else if selectedExperienceType == .travellers {

                            ForEach(nonExperienceCellModelObj.indices, id: \.self) { item in
                                NavigationLink(destination: ExperienceDetailView(selectedIndex: getIndex, dataObject: nonExperienceCellModelObj[getIndex]), isActive: $moveToExperienceDetail) {
                                    TypeExperienceView(experienceCellModelObj: nonExperienceCellModelObj, getIndex: $getIndex, item: item, moveToExperienceDetail: $moveToExperienceDetail)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        else {

                            ForEach(experienceCellModelObj.indices, id: \.self) { item in
                                NavigationLink(destination: ExperienceDetailView(selectedIndex: getIndex, dataObject: experienceCellModelObj[getIndex]), isActive: $moveToExperienceDetail) {
                                    TypeExperienceView(experienceCellModelObj: experienceCellModelObj, getIndex: $getIndex, item: item, moveToExperienceDetail: $moveToExperienceDetail)

                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }

            }
        }
    }
}

//struct ExperienceCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ExperienceCell()
//    }
//}

struct ExperienceCellHeaderView: View {
    
    var profileImage : String = ""
    var name: String = ""
    var userName : String = ""
    var travlerFeatured : Bool = false
    var body: some View {
        HStack {
            Image(profileImage)
                .resizable()
                .frame(width: 45,height: 45)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(name)
                        .fontWeight(.medium)
                        .font(.custom("Gill Sans", size: 20))
                    if travlerFeatured {
                        Image("featured-traveller-profile")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
                }
                Text("@\(userName)")
                    .font(.custom("Gill Sans", size: 15))
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ExperienceCellContentView: View {
    @State var likeButton : Bool = false
    @State var likeCount : Int = 4
    var title: String = ""
    var descriptionLabel :String = ""
    var locationLabel: String = ""
    var coverImage: Image = Image("")
    var index : Int = 0
    var height : CGFloat = 280
    var selectedExperienceType : ExperienceType = .all
    @State var featuredExperienceCellModelObj = experienceCellModelObj.filter { $0.travelerFeatured}
    @State var nonExperienceCellModelObj = experienceCellModelObj.filter { $0.travelerFeatured == false}

    var body: some View {
        ZStack {
            coverImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 40, height: height)
                .clipped()
                .cornerRadius(15)
            VStack {
                HStack {
                    Spacer()
                    Text("\(likeCount)")
                        .foregroundColor(.white)
                    Button(action: {
                        print(likeCount)
                        switch selectedExperienceType {
                        case .all:
                            self.likeButton.toggle()
                            if likeButton {
                                likeCount += 1
                                experienceCellModelObj[index].likeCount = likeCount
                                experienceCellModelObj[index].likeButton = likeButton
                            } else {
                                likeCount -= 1
                                experienceCellModelObj[index].likeCount = likeCount
                                experienceCellModelObj[index].likeButton = likeButton
                            }
                        case .featuredTravellers:
                            self.likeButton.toggle()
                            if likeButton {
                                likeCount += 1
                                featuredExperienceCellModelObj[index].likeCount = likeCount
                                featuredExperienceCellModelObj[index].likeButton = likeButton
                            } else {
                                likeCount -= 1
                                featuredExperienceCellModelObj[index].likeCount = likeCount
                                featuredExperienceCellModelObj[index].likeButton = likeButton
                            }
                        case .travellers:
                            self.likeButton.toggle()
                            if likeButton {
                                likeCount += 1
                                nonExperienceCellModelObj[index].likeCount = likeCount
                                nonExperienceCellModelObj[index].likeButton = likeButton
                            } else {
                                likeCount -= 1
                                nonExperienceCellModelObj[index].likeCount = likeCount
                                nonExperienceCellModelObj[index].likeButton = likeButton
                            }
                        }
                        
                    }) {
                        if likeButton {
                            Image("khome-likebutton")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                        } else {
                            Image("khome-unlikebutton")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                .padding(.all, 15)
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .fontWeight(.medium)
                        .font(.custom("Gill Sans", size: 24))
                        .lineLimit(2)
                    Text(descriptionLabel)
                        .font(.custom("Gill Sans", size: 15))
                        .fontWeight(.bold)
                        .lineLimit(2)
                    HStack {
                        Image("klocationpin-alternate")
                            .resizable()
                            .frame(width: 24, height: 20)
                        Text(locationLabel)
                            .fontWeight(.medium)
                            .font(.custom("Gill Sans", size: 18))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.white)
                .padding(.vertical, 30)
                .padding(.horizontal, 24)
            }
        }
//        .frame( height: height)
    }
}

struct TypeExperienceView: View {
    var experienceCellModelObj : [ExperienceCellModel]
    @Binding var getIndex : Int
    var item : Int
    @Binding var moveToExperienceDetail : Bool
    var body: some View {
        VStack(alignment: .leading) {
            ExperienceCellHeaderView(profileImage: experienceCellModelObj[item].profileImage, name: experienceCellModelObj[item].name, userName: experienceCellModelObj[item].userName, travlerFeatured: experienceCellModelObj[item].travelerFeatured)
            ExperienceCellContentView(likeButton: experienceCellModelObj[item].likeButton, likeCount: experienceCellModelObj[item].likeCount, title: experienceCellModelObj[item].title, descriptionLabel: experienceCellModelObj[item].descriptionLabel, locationLabel: experienceCellModelObj[item].locationLabel, coverImage: experienceCellModelObj[item].coverImage, index: item)
        }
        .padding(.horizontal, 20)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                getIndex = 0
            }
        }
        .onTapGesture {
            self.getIndex = item
            print(getIndex)
            self.moveToExperienceDetail.toggle()
        }
    }
}
