//
//  SavedListView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 01/10/22.
//

import SwiftUI

struct SavedListView: View {
    @State var refresh : Bool = false
    @State var discardAddingList : Bool = false
    @State var listName : String = ""
    @State var listIndex : Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                SavedListHeader(refresh: $refresh)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        RecentSavedList()
                        // Just to refresh we took variable refresh it will update the list this way
                        if refresh || true {
                            TravelListText()
                            TravelList(discardAddingList: $discardAddingList, listName: $listName, listIndex: $listIndex)
                        }
                        Spacer()
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct SavedListView_Previews: PreviewProvider {
    static var previews: some View {
        SavedListView()
    }
}

struct SavedListHeader: View {
    @State var moveToCreate : Bool = false
    @Binding var refresh : Bool
    @State var showToast : Bool = false
    var dataObject = ExperienceCellModel()
    var body: some View {
        HStack {
            Text("Saved")
                .font(.custom("Gill Sans", size: 25))
                .fontWeight(.semibold)
            Spacer()
            Button(action: {
                moveToCreate.toggle()
            }) {
                Text("Create")
                    .font(.custom("Gill Sans", size: 18))
                    .fontWeight(.light)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .background(RoundedRectangle(cornerRadius: 50)
                        .fill(Color(red: 208/255, green: 231/255, blue: 220/255)))
            }
            .buttonStyle(.plain)
            .fullScreenCover(isPresented: $moveToCreate) {
                CreateListView(refresh: $refresh, saveListType: .detail, dataObject: dataObject, showToast: $showToast)
            }
        }
        .padding(20)
    }
}

struct RecentSavedList: View {
    var row: [GridItem] = [
        GridItem(.flexible())]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if recentSavedListObj.count != 0 {
                Text("Recently Saved")
                    .font(.custom("Gill Sans", size: 20))
                    .fontWeight(.semibold)
                    .padding(.top, 50)
                    .padding(.horizontal, 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: row, spacing: 10) {
                        ForEach(recentSavedListObj.indices.prefix(5), id: \.self) { index in
                            RecentSavedCell(index: index)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 160)
                .padding(.top, 20)
            }
        }
    }
}

struct TravelList: View {
    @State var moveToListDetail : Bool = false
    @State var getIndex: Int = 0
    var saveListType : SavedListType = .detail
    @Binding var discardAddingList : Bool
    @Binding var listName : String
    @Binding var listIndex : Int
    
    var column: [GridItem] = [
        GridItem(.flexible())]
    
    var body: some View {

        VStack(alignment: .leading) {
            LazyVGrid (columns: column, spacing: 20) {
                ForEach(savedListObj.indices, id: \.self) { item in
                    if saveListType == .save {
                        TravelListCell(imageName: savedListObj[item].listImage, titleName: savedListObj[item].listName)
                            .onTapGesture {
                                discardAddingList = true
                                self.getIndex = item
                                listIndex = getIndex
                                listName = savedListObj[getIndex].listName
                            }
                    } else {
                        NavigationLink(destination: SavedListDetailView(savedList: savedListObj[getIndex]), isActive: $moveToListDetail) {
                            TravelListCell(imageName: savedListObj[item].listImage, titleName: savedListObj[item].listName)
                                .onTapGesture {
                                    self.getIndex = item
                                    moveToListDetail.toggle()
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.top, 10)
        }
    }
}

struct TravelListText: View {
    var body: some View {
        Text("Your Travel List")
            .font(.custom("Gill Sans", size: 20))
            .fontWeight(.semibold)
            .padding(.top, 50)
            .padding(.horizontal, 20)
    }
}

struct TravelListCell: View {
    var imageName : Image = Image("spain1")
    var titleName : String = "Title"
    var body: some View {
        HStack {
            ZStack {
                imageName
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60, alignment: .center)
                    .cornerRadius(12)
                    .clipped()
                Image("blackOverlay")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .opacity(0.25)
                    .cornerRadius(12)
                    .ignoresSafeArea()
            }
            
            Text(titleName)
                .font(.custom("Gill Sans", size: 18))
                .fontWeight(.semibold)
                .lineLimit(3)
                .padding(.leading, 15)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct RecentSavedCell: View {
    var index : Int = 0
    var body: some View {
        VStack(alignment: .leading) {
            recentSavedListObj[index].saveImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 100, alignment: .center)
                .clipped()
            VStack(alignment: .leading) {
                Text(recentSavedListObj[index].saveTitle)
                    .font(.custom("Gill Sans", size: 16))
                    .lineLimit(1)
                    .fontWeight(.medium)
                Text(recentSavedListObj[index].saveDesc)
                    .font(.custom("Gill Sans", size: 14))
                    .lineLimit(1)
            }
            .padding(5)
        }
        .frame(width: 140)
        .cornerRadius(12)
        .background(RoundedRectangle(cornerRadius: 12)
            .stroke(Color(red: 200/255, green: 200/255, blue: 200/255)))
    }
}

struct TravelListSave: View {
    @State var moveToListDetail : Bool = false
    @State var getIndex: Int = 0

    var column: [GridItem] = [
        GridItem(.flexible())]
    
    var body: some View {

        VStack(alignment: .leading) {
            LazyVGrid (columns: column, spacing: 20) {
                ForEach(savedListObj.indices, id: \.self) { item in
                    TravelListCell(imageName: savedListObj[item].listImage, titleName: savedListObj[item].listName)
                        .onTapGesture {
                            self.getIndex = item
                            moveToListDetail.toggle()
                        }
                }
            }
            .padding(.top, 10)
        }
    }
}
