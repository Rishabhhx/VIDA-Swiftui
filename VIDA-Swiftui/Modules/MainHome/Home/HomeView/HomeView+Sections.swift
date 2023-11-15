//
//  HomeView+Sections.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 05/09/22.
//

import SwiftUI

struct SectionView: View {
    var sectionTitle: String = "Locations"
    var sectionTitleColor: Color = Color.gray
    var sectionLineColor : Color = Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255)
    var body: some View {
        VStack {
            Text(sectionTitle)
                .font(.custom("Gill Sans", size: 18))
                .fontWeight(.semibold)
                .foregroundColor(sectionTitleColor)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(sectionLineColor)
        }
    }
}

struct HomePageSections: View {
    
    @Binding var selectedSection : Sections
    @Binding var backgroundImage : String
    @Binding var title : String
    @Binding var filterShow : Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                selectedSection = .locations
                title = "Locations for you"
                backgroundImage = "locationGradientBg"
                filterShow = false
            }) {
                if selectedSection == .locations {
                    SectionView(sectionTitle: "Locations", sectionTitleColor: Color.black, sectionLineColor: Color.orange)
                } else {
                    SectionView(sectionTitle: "Locations", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                }
                
            }
            Button(action: {
                selectedSection = .experience
                title = "Experience for you"
                backgroundImage = "experiencesGradientBg"
                filterShow = true
            }) {
                if selectedSection == .experience {
                    SectionView(sectionTitle: "Experience", sectionTitleColor: Color.black, sectionLineColor: Color.blue)
                    
                } else {
                    SectionView(sectionTitle: "Experience", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                }
            }
            Button(action: {
                selectedSection = .articles
                title = "Articles for you"
                backgroundImage = "articlesGradientBg"
                filterShow = false
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

struct NoSectionAdded: View {
    var sectionText : String = "Experience"
    var body: some View {
        VStack(alignment: .center) {
            Image("kvida-logo")
            Text("No \(sectionText) Added Yet!")
                .font(.custom("Gill Sans", size: 16))
        }
        .foregroundColor(.secondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
