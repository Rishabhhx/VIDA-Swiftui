//
//  CreateListView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 02/10/22.
//

import SwiftUI

enum SavedListType {
    case detail
    case save
}

struct CreateListView: View {
    @State var showListPopup : Bool = false
    @Binding var refresh : Bool
    var saveListType : SavedListType = .detail
    @Environment(\.dismiss) private var dismiss
    @State var discardAddingList : Bool = false
    @State var listName : String = ""
    var dataObject = ExperienceCellModel()
    var dataObjectLocation = LocationCellModel()
    var dataObjectArticles = ArticlesCellModel()

    @State var listIndex : Int = 0
    @Binding var showToast : Bool
    var dataType : Sections = .experience
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color(.white)
                        .padding(.top, 200)
                    VStack(spacing: 0) {
                        TopRectangle()
                        CreateListHeader(refresh: $refresh)
                        Divider()
                        TravelListCell(imageName: Image("create-List"), titleName: "Create new list")
                            .padding(.vertical, 20)
                            .onTapGesture {
                                showListPopup = true
                            }
                        ScrollView(.vertical, showsIndicators: false) {
                            TravelList(saveListType: saveListType, discardAddingList: $discardAddingList, listName: $listName, listIndex: $listIndex)
                        }
                        Spacer()
                    }
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.top, 10)
                    .ignoresSafeArea(edges: .bottom)
                }
                .gesture(
                    DragGesture().onEnded { value in
                        if value.location.y - value.startLocation.y > 150 {
                            /// Use presentationMode.wrappedValue.dismiss() for iOS 14 and below
                            dismiss()
                        }
                    }
                )
                .overlay(alignment: .center) {
                    if showListPopup {
                        CreateListPopup(showListPopup: $showListPopup)
                    }
                    if saveListType == .save && discardAddingList {
                        SaveToListPopup(listName: $listName, yesButtonPressed: {
                            switch dataType {
                            case .locations:
                                if savedListObj[listIndex].savedLocation.contains(where: {$0.id == dataObjectLocation.id}) {
                                    self.dismiss()
                                    showToast = true
                                } else {
                                    recentSavedListObj.insert(RecentSavedListModel(saveImage: dataObjectLocation.coverImage, saveTitle: dataObjectLocation.location, saveDesc: dataObjectLocation.locationDescription), at: 0)
                                    savedListObj[listIndex].savedLocation.append(dataObjectLocation)
                                    self.dismiss()
                                }
                            case .experience:
                                if savedListObj[listIndex].savedExperience.contains(where: {$0.id == dataObject.id}) {
                                    self.dismiss()
                                    showToast = true
                                } else {
                                    recentSavedListObj.insert(RecentSavedListModel(saveImage: dataObject.coverImage, saveTitle: dataObject.title, saveDesc: dataObject.descriptionLabel), at: 0)
                                    savedListObj[listIndex].savedExperience.append(dataObject)
                                    self.dismiss()
                                }
                            case .articles:
                                if savedListObj[listIndex].savedArticles.contains(where: {$0.id == dataObjectArticles.id}) {
                                    self.dismiss()
                                    showToast = true
                                } else {
                                    recentSavedListObj.insert(RecentSavedListModel(saveImage: dataObjectArticles.articleImage, saveTitle: dataObjectArticles.pageNameLable, saveDesc: dataObjectArticles.websiteLink), at: 0)

                                    savedListObj[listIndex].savedArticles.append(dataObjectArticles)
                                    self.dismiss()
                                }
                            }
                        }, noButtonPressed: {
                            discardAddingList = false
                        })
                    }
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.displayP3, red: 218/255, green: 237/255, blue: 227/255))
            .hideKeyboardWhenTappedAround()
        }
    }
}

//
//struct CreateListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateListView()
//    }
//}

struct CreateListHeader: View {
    @Binding var refresh : Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    self.refresh.toggle()
                    dismiss()
                }) {
                    Image("kblackCross")
                }
                .buttonStyle(.plain)
                Spacer()
            }
            
            Text("Saved Travel Lists")
                .font(.custom("Gill Sans", size: 16))
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

struct TopRectangle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 40, height: 4)
            .foregroundColor(Color(.displayP3, red: 18/255, green: 19/255, blue: 29/255, opacity: 0.2))
            .padding()
    }
}
