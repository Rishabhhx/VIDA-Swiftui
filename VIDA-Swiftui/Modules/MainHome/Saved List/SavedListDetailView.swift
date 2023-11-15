//
//  SavedListDetailView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 06/10/22.
//

import SwiftUI

struct SavedListDetailView: View {
    var savedList = SavedListModel()
    @State var selectedSection : Sections = .experience
    var body: some View {
        VStack(alignment: .leading) {
            ListDetailHeader()
            ViewHeading(text: savedList.listName ,size: 30, topPadding: 5)
            ListSection(selectedSection: $selectedSection)
            VStack {
                if selectedSection == .experience {
                    ZStack {
                        if savedList.savedExperience.count == 0 {
                            NoSectionAdded(sectionText: "Experience")
                        }
                        ExperienceCell(selectedExperienceType: .all, cellData: .lists, savedList: savedList)
                    }
                } else if selectedSection == .locations {
                    ZStack {
                        if savedList.savedLocation.count == 0 {
                            NoSectionAdded(sectionText: "Locations")
                        }
                        LocationCell(cellData: .lists, savedList: savedList)
                    }
                } else if selectedSection == .articles {
                    ZStack {
                        if savedList.savedArticles.count == 0 {
                            NoSectionAdded(sectionText: "Articles")
                        }
                        ArticlesCell(cellData: .lists, savedList: savedList)
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct SavedListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SavedListDetailView()
    }
}

struct ListDetailHeader: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        HStack {
            Image("chevron-back")
                .onTapGesture {
                    dismiss()
                }
            Spacer()
        }
        .padding(30)
    }
}

struct ListSection: View {
    @Binding var selectedSection : Sections
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                selectedSection = .locations
            }) {
                if selectedSection == .locations {
                    SectionView(sectionTitle: "Locations", sectionTitleColor: Color.black, sectionLineColor: Color.orange)
                } else {
                    SectionView(sectionTitle: "Locations", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                }
                
            }
            Button(action: {
                selectedSection = .experience
            }) {
                if selectedSection == .experience {
                    SectionView(sectionTitle: "Experience", sectionTitleColor: Color.black, sectionLineColor: Color.blue)
                    
                } else {
                    SectionView(sectionTitle: "Experience", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                }
            }
            Button(action: {
                selectedSection = .articles
            }) {
                if selectedSection == .articles {
                    SectionView(sectionTitle: "Articles", sectionTitleColor: Color.black, sectionLineColor: Color.purple)
                    
                } else {
                    SectionView(sectionTitle: "Articles", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                }
            }
            
        }
        .padding(.vertical)
    }
}
