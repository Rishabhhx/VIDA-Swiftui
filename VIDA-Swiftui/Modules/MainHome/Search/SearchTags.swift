//
//  SearchTags.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 14/09/22.
//

import SwiftUI
struct Tags: View {
    @Binding var searchType : SearchType
    @Binding var showAll : Bool
    @State var toggleSelection : Bool = false

    var body: some View {
        HStack {
            switch searchType {
            case .location:
                SelectedSearchTags(tagName: "Locations")
                    .onTapGesture {
                        self.searchType = .all
                        showAll = true
                    }
                SearchTags(tagName: "Experiences")
                    .onTapGesture {
                        self.searchType = .experience
                        showAll = false
                    }
                SearchTags(tagName: "Articles")
                    .onTapGesture {
                        self.searchType = .articles
                        showAll = false
                    }
                SearchTags(tagName: "Accounts")
                    .onTapGesture {
                        self.searchType = .accounts
                        showAll = false
                    }

            case .experience:
                SearchTags(tagName: "Locations")
                    .onTapGesture {
                        self.searchType = .location
                        showAll = false

                    }
                SelectedSearchTags(tagName: "Experiences")
                    .onTapGesture {
                        self.searchType = .all
                        showAll = true
                    }
                SearchTags(tagName: "Articles")
                    .onTapGesture {
                        self.searchType = .articles
                        showAll = false
                    }
                SearchTags(tagName: "Accounts")
                    .onTapGesture {
                        self.searchType = .accounts
                        showAll = false
                    }
            case .articles:
                SearchTags(tagName: "Locations")
                    .onTapGesture {
                        self.searchType = .location
                        showAll = false
                    }
                SearchTags(tagName: "Experiences")
                    .onTapGesture {
                        self.searchType = .experience
                        showAll = false
                    }
                SelectedSearchTags(tagName: "Articles")
                    .onTapGesture {
                        self.searchType = .all
                        showAll = true
                    }
                SearchTags(tagName: "Accounts")
                    .onTapGesture {
                        self.searchType = .accounts
                        showAll = false
                    }
            case .accounts:
                SearchTags(tagName: "Locations")
                    .onTapGesture {
                        self.searchType = .location
                        showAll = false
                    }
                SearchTags(tagName: "Experiences")
                    .onTapGesture {
                        self.searchType = .experience
                        showAll = false
                    }
                SearchTags(tagName: "Articles")
                    .onTapGesture {
                        self.searchType = .articles
                        showAll = false
                    }
                SelectedSearchTags(tagName: "Accounts")
                    .onTapGesture {
                        self.searchType = .all
                        showAll = true
                    }
            case .all:
                SearchTags(tagName: "Locations")
                    .onTapGesture {
                        self.searchType = .location
                        showAll = false
                    }
                SearchTags(tagName: "Experiences")
                    .onTapGesture {
                        self.searchType = .experience
                        showAll = false
                    }
                SearchTags(tagName: "Articles")
                    .onTapGesture {
                        self.searchType = .articles
                        showAll = false
                    }
                SearchTags(tagName: "Accounts")
                    .onTapGesture {
                        self.searchType = .accounts
                        showAll = false
                    }
            }
        }
        .padding(.vertical, 20)
    }
}

