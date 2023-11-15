//
//  LocationCell.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 05/09/22.
//

import SwiftUI

struct LocationCell: View {
    @State var moveToLocationDetail : Bool = false
    @State var getIndex: Int = 0
    var cellData : CellDataType = .home
    var savedList = SavedListModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                if cellData == .lists {
                    ForEach(savedList.savedLocation.indices, id: \.self) { item in
                        NavigationLink(destination: LocationDetailView(dataObject: savedList.savedLocation[getIndex], selectedIndex: getIndex), isActive: $moveToLocationDetail) {
                            VStack(alignment: .leading) {
                                LocationCellContentView(likeButton: savedList.savedLocation[item].likeButton, likeCount: savedList.savedLocation[item].likeCount, place: savedList.savedLocation[item].place, location: savedList.savedLocation[item].location, coverImage: savedList.savedLocation[item].coverImage, index: item)
                            }
                            .padding(.horizontal, 20)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    getIndex = 0
                                }
                            }
                            .onTapGesture {
                                self.getIndex = item
                                print(getIndex)
                                self.moveToLocationDetail.toggle()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    ForEach(locationCellModelObj.indices, id: \.self) { item in
                        NavigationLink(destination: LocationDetailView(dataObject: locationCellModelObj[getIndex], selectedIndex: getIndex), isActive: $moveToLocationDetail) {
                            VStack(alignment: .leading) {
                                LocationCellContentView(likeButton: locationCellModelObj[item].likeButton, likeCount: locationCellModelObj[item].likeCount, place: locationCellModelObj[item].place, location: locationCellModelObj[item].location, coverImage: locationCellModelObj[item].coverImage, index: item)
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
                                self.moveToLocationDetail.toggle()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

struct LocationCellContentView: View {
    @State var likeButton : Bool = false
    @State var likeCount : Int = 4
    var place: String = ""
    var location :String = ""
    var coverImage: Image = Image("")
    var index : Int = 0
    
    var body: some View {
        ZStack {
            Image("blackOverlay")
                .resizable()
                .opacity(0.25)
                .ignoresSafeArea()
            coverImage
                .resizable()
                .cornerRadius(15)
            VStack {
                HStack {
                    Spacer()
                    Text("\(likeCount)")
                        .foregroundColor(.white)
                    Button(action: {
                        self.likeButton.toggle()
                        if likeButton {
                            likeCount += 1
                            locationCellModelObj[index].likeCount = likeCount
                            locationCellModelObj[index].likeButton = likeButton
                        } else {
                            likeCount -= 1
                            locationCellModelObj[index].likeButton = likeButton
                            locationCellModelObj[index].likeCount = likeCount
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
                    Text(place)
                        .fontWeight(.medium)
                        .font(.custom("Gill Sans", size: 24))
                        .lineLimit(2)
                    Text(location)
                        .font(.custom("Gill Sans", size: 20))
                        .fontWeight(.medium)
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.white)
                .padding(.vertical, 30)
                .padding(.horizontal, 24)
            }
        }
        .frame(height: 228)
    }
}

//struct LocationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationCell()
//    }
//}

