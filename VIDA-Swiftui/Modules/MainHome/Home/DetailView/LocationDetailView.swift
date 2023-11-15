//
//  LocationDetailView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 09/09/22.
//

import SwiftUI

struct LocationDetailView: View {
    @State var selectedSection : Sections = .experience
    @State var selectedExperienceType : ExperienceType = .all
    var dataObject : LocationCellModel
    @State var showToast : Bool = false
    @State var refresh : Bool = false
    var selectedIndex : Int = 1

    var body: some View {
        ZStack {
            VStack {
                LocationDetailHeader(likeButton: dataObject.likeButton, likeCount: dataObject.likeCount, dataObjectLocation: dataObject, showToast: $showToast,index: selectedIndex)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LocationDetails(place: dataObject.place, location: dataObject.location, country: dataObject.country, locationDescription: dataObject.locationDescription, coverImage: dataObject.coverImage)
                        HStack(spacing: 0) {
                            Button(action: {
                                selectedSection = .experience
                            }) {
                                if selectedSection == .experience {
                                    SectionView(sectionTitle: "Experience", sectionTitleColor: Color.black, sectionLineColor: Color.orange)
                                    
                                } else {
                                    SectionView(sectionTitle: "Experience", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                                }
                            }
                            Button(action: {
                                selectedSection = .articles
                            }) {
                                if selectedSection == .articles {
                                    SectionView(sectionTitle: "Articles", sectionTitleColor: Color.black, sectionLineColor: Color.orange)
                                    
                                } else {
                                    SectionView(sectionTitle: "Articles", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                                }
                            }
                            
                        }
                        .padding(.vertical)
                        .padding(.horizontal)
                        if selectedSection == .experience {
                            ZStack {
                                if experienceCellModelObj.count == 0 {
                                    NoSectionAdded(sectionText: "Experience")
                                }
                                ExperienceCell(selectedExperienceType: selectedExperienceType)
                            }
                        } else if selectedSection == .articles {
                            ZStack {
                                if articleCellModelObj.count == 0 {
                                    NoSectionAdded(sectionText: "Articles")
                                }
                                ArticlesCell()
                            }
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            VStack {
                Spacer()
                if showToast {
                    ToastMessage(req: $showToast, text: "Location already saved in this list")
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(dataObject: locationCellModelObj[0])
    }
}

struct LocationDetailHeader: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var likeButton : Bool = false
    @State var likeCount : Int = 4
    @State var moveToAddSave : Bool = false
    var dataObjectLocation : LocationCellModel
    @Binding var showToast : Bool
    @State var refresh : Bool = false
    var dataType : Sections = .locations
    var index : Int = 0

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color.white)
                Button(action: {} ) {
                    Image("chevron-back")
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            .frame(width: 35, height: 35)
            Spacer()
            Button(action: {
                moveToAddSave.toggle()
            }) {
                ZStack {
                    Circle()
                        .fill(Color(.displayP3, red: 245/255, green: 245/255, blue: 245/255, opacity: 1))
                        Image("klocdetail-save")
                }
                .frame(width: 35, height: 35)
            }
            .buttonStyle(.plain)
            .fullScreenCover(isPresented: $moveToAddSave) {
                CreateListView(refresh: $refresh, saveListType: .save, dataObjectLocation: dataObjectLocation, showToast: $showToast, dataType: .locations)
            }
            ZStack {
                Circle()
                    .fill(Color(.displayP3, red: 245/255, green: 245/255, blue: 245/255, opacity: 1))
                Button(action: {} ) {
                    Image("klocdetail-pin")
                }
            }
            .frame(width: 35, height: 35)
            ZStack {
                Circle()
                    .fill(Color(.displayP3, red: 245/255, green: 245/255, blue: 245/255, opacity: 1))
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
                    } else {
                        Image("klocdetail-unlike")
                    }
                }
            }
            .frame(width: 35, height: 35)
            ZStack {
                Circle()
                    .fill(Color(.displayP3, red: 245/255, green: 245/255, blue: 245/255, opacity: 1))
                Button(action: {actionSheet()} ) {
                    Image("klocdetail-share")
                }
            }
            .frame(width: 35, height: 35)
        }
        .foregroundColor(Color.black)
        .padding(10)
    }
    func actionSheet() {
        let activityVC = UIActivityViewController(activityItems: ["title"], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
       }
}

struct LocationDetails: View {
    var place : String
    var location : String
    var country : String
    var locationDescription : String
    var coverImage : Image

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(place)
                    .font(.custom("Gill Sans", size: 24))
                    .fontWeight(.semibold)
                Text("\(location), \(country)")
                    .font(.custom("Gill Sans", size: 20))
                    .fontWeight(.medium)
                Text(locationDescription)
                    .font(.custom("Gill Sans", size: 18))
                    .fontWeight(.regular)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .top, .bottom], 30)
            .padding(.trailing, 60)
            ZStack {
                coverImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 355)
                Image("blackOverlay")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 355)
                    .opacity(0.25)
                    .ignoresSafeArea()
            }
        }
    }
}
