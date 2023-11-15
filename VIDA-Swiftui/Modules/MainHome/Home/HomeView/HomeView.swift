//
//  HomeView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 03/09/22.
//

import SwiftUI

enum Sections {
    case locations
    case experience
    case articles
}

enum ExperienceType {
    case all
    case travellers
    case featuredTravellers
}

enum CellDataType {
    case home
    case lists
}

struct HomeView: View {
    @State var translation : CGSize = .zero
    @State var selectedSection : Sections = .experience
    @State var selectedExperienceType : ExperienceType = .all
    @State var backgroundImage : String = "experiencesGradientBg"
    @State var title : String = "Experience for you"
    @State var filterShow : Bool = true
    @State var moveToExperienceDetail : Bool = false
    @State private var viewID: Int = 0

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    BackgroundImage(image: backgroundImage)
                    VStack(alignment: .leading, spacing: 0) {
                        NavigationBarCustom(filterShown: $filterShow, selectedExperienceType: $selectedExperienceType)
                            .frame(height: 60)
                        ViewHeading(text: title, size: 34, topPadding: 10)
                        HomePageSections(selectedSection: $selectedSection, backgroundImage: $backgroundImage, title: $title, filterShow: $filterShow)
                        VStack {
                            if selectedSection == .experience {
                                ZStack {
                                    if experienceCellModelObj.count == 0 {
                                        NoSectionAdded(sectionText: "Experience")
                                    }
                                    ExperienceCell(selectedExperienceType: selectedExperienceType)
                                }
                            } else if selectedSection == .locations {
                                ZStack {
                                    if locationCellModelObj.count == 0 {
                                        NoSectionAdded(sectionText: "Locations")
                                    }
                                    LocationCell()
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
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

struct NavigationBarCustom: View {
    @Binding var filterShown : Bool
    @Binding var selectedExperienceType : ExperienceType
    @State var showPopup : Bool = false

    var body: some View {
        HStack {
            Image("kvida-logo-nav")
                .resizable()
                .frame(width: 30, height: 30)
            Spacer()
            if filterShown {
                ZStack {
                    Circle()
                        .fill(.white)
                        .shadow(color: Color(.displayP3, red: 200/255, green: 200/255 , blue: 200/255, opacity: 1), radius: 20, x: 0, y: 0)
                    Image("kfilter-home-icon")
                        .sheet(isPresented: $showPopup) {
                            ExperienceTypePopupView(showPopup: $showPopup, selectedExperienceType: $selectedExperienceType)
                                .presentationDetents([.small])
                        }
                        .onTapGesture {
                            self.showPopup.toggle()
                        }
                }
                .frame(width: 40, height: 40)
                .transition(.move(edge: .trailing))
                .animation(.easeInOut)
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension PresentationDetent {
    static let small = Self.height(290)
}
