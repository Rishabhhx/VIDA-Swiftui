//
//  ArticlesCell.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 05/09/22.
//

import SwiftUI

struct ArticlesCell: View {
    @State var moveToArticleDetail : Bool = false
    @State var getIndex: Int = 0
    var cellData : CellDataType = .home
    var savedList = SavedListModel()
    @State var showToast : Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                if cellData == .lists {
                    ForEach(savedList.savedArticles.indices, id: \.self) { item in
                        NavigationLink(destination: ArticlesDetailView(url: savedList.savedArticles[getIndex].websiteLink, title: savedList.savedArticles[getIndex].pageNameLable), isActive: $moveToArticleDetail) {
                            VStack(alignment: .leading) {
                                ArticlesCellContentView(pageNameLable: savedList.savedArticles[item].pageNameLable, descriptionLabel: savedList.savedArticles[item].descriptionLabel,websiteName: savedList.savedArticles[item].websiteLink, coverImage: savedList.savedArticles[item].articleImage, index: item, showToast: $showToast, cellData: cellData, savedList: savedList)
                            }
                            .padding(.horizontal, 20)
                            .onAppear {
                                getIndex = 0
                            }
                            .onTapGesture {
                                self.getIndex = item
                                print(getIndex)
                                self.moveToArticleDetail.toggle()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    ForEach(articleCellModelObj.indices, id: \.self) { item in
                        NavigationLink(destination: ArticlesDetailView(url: articleCellModelObj[getIndex].websiteLink, title: articleCellModelObj[getIndex].pageNameLable), isActive: $moveToArticleDetail) {
                            VStack(alignment: .leading) {
                                ArticlesCellContentView(pageNameLable: articleCellModelObj[item].pageNameLable, descriptionLabel: articleCellModelObj[item].descriptionLabel,websiteName: articleCellModelObj[item].websiteLink, coverImage: articleCellModelObj[item].articleImage, index: item,  showToast: $showToast, cellData: cellData)
                            }
                            .padding(.horizontal, 20)
                            .onAppear {
                                getIndex = 0
                            }
                            .onTapGesture {
                                self.getIndex = item
                                print(getIndex)
                                self.moveToArticleDetail.toggle()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
            }
        }
    }
}

struct ArticlesCellContentView: View {
    var pageNameLable: String = ""
    var descriptionLabel :String = ""
    var websiteName :String = ""
    var coverImage: Image = Image("")
    var index : Int = 0
    @State var moveToAddSave : Bool = false
    @Binding var showToast : Bool
    @State var refresh : Bool = false
    var dataType : Sections = .articles
    var cellData : CellDataType = .home
    var savedList = SavedListModel()

    func actionSheet() {
        guard let urlShare = URL(string: websiteName) else { return }
           let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
       }
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                coverImage
                    .resizable()
                    .frame(height: 190)
                Image("blackOverlay")
                    .resizable()
                    .frame(height: 190)
                    .opacity(0.25)
                    .ignoresSafeArea()
                VStack {
                    HStack(spacing: 10) {
                        Spacer()
                        Button(action: {
                            actionSheet()
                        }) {
                            Image("kshareroundwhite")
                        }
                        Button(action: {
                            moveToAddSave.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(.displayP3, red: 245/255, green: 245/255, blue: 245/255, opacity: 1))
                                Image("ksaveroundwhite")
                            }
                            .frame(width: 35, height: 35)
                        }
                        .buttonStyle(.plain)
                        .fullScreenCover(isPresented: $moveToAddSave) {
                            if cellData == .home {
                                CreateListView(refresh: $refresh, saveListType: .save, dataObjectArticles: articleCellModelObj[index], showToast: $showToast, dataType: dataType)

                            } else {
                                CreateListView(refresh: $refresh, saveListType: .save, dataObjectArticles: savedList.savedArticles[index], showToast: $showToast, dataType: dataType)

                            }
                        }
                    }
                    Spacer()
                }
                .padding(15)
            }
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(pageNameLable)
                        .font(.custom("Gill Sans", size: 16))
                        .fontWeight(.regular)
                        .lineLimit(1)
                    Text(descriptionLabel)
                        .font(.custom("Gill Sans", size: 17))
                        .fontWeight(.medium)
                        .lineLimit(2)
                    Text(websiteName)
                        .font(.custom("Gill Sans", size: 16))
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .foregroundColor(Color.black)
            }
        }
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color(.displayP3, red: 200/255, green: 200/255, blue: 200/255)))
    }
}

//struct ArticlesCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticlesCell()
//    }
//}
