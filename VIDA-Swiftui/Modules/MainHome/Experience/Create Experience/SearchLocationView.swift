//
//  SearchLocationView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 19/09/22.
//
enum MoveAfterSearch {
    case openDetail
    case selectLocation
}

import SwiftUI

struct SearchLocationView: View {
    @State var showAll : Bool = false
    @State var searchType : SearchType = .location
    @State var searchText : String = ""
    @State var showTag : Bool = false
    @State var noResult : Bool = true
    @State var searchArray : Bool = false
    @State var cellStructArr : [CellStruct] = []
    @State var moveAfterSearch : MoveAfterSearch = .selectLocation
    @Binding var location : String

    var body: some View {
        VStack {
            ZStack {
                Color(.white)
                    .padding(.top, 200)
                VStack(spacing: 0) {
                    SearchTextField(searchText: $searchText, showAll: $showAll, showTag: $showTag)
                        .frame(height: 40)
                        .padding(12)
                    Divider()
                    if !searchText.isEmpty {
                        SearchResults(showAll: $showAll, searchType: $searchType, searchText: $searchText, showTag: $showTag, noResult: $noResult, searchArray: $searchArray, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                            .onAppear() {
                                noResult = false
                            }
                    }
                    Spacer()
                }
                .background(.white)
                .cornerRadius(20)
                .padding(.top, 10)
                .ignoresSafeArea(edges: .bottom)
                if noResult {
                    NoResultFound()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.displayP3, red: 218/255, green: 237/255, blue: 227/255))
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

//struct SearchLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchLocationView()
//    }
//}
