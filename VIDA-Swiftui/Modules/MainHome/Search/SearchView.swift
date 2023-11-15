//
//  SearchView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 10/09/22.
//

import SwiftUI
enum SearchType {
    case location
    case experience
    case articles
    case accounts
    case all
    var title: String {
        switch self {
        case .location:
            return "Locations"
        case .experience:
            return "Experience"
        case .articles:
            return "Articles"
        case .accounts:
            return "Accounts"
        case .all:
            return ""
        }
    }
}

struct CellStruct {
    var type : SearchType = .location
    var image : Image = Image("")
    var heading : String = ""
    var subHeading : String = ""
    var showLogo : Bool = false
    var elementPos : Int = 0
}

struct SearchView: View {
    @State var showAll : Bool = true
    @State var searchType : SearchType = .all
    @State var searchText : String = ""
    @State var showTag : Bool = false
    @State var noResult : Bool = false
    @State var searchArray : Bool = false
    @State var cellStructArr : [CellStruct] = []
    @State var moveAfterSearch : MoveAfterSearch = .openDetail
    @State var location = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color(.white)
                        .padding(.top, 200)
                    VStack(spacing: 0) {
                        SearchTextField(searchText: $searchText, showAll: $showAll, showTag: $showTag)
                            .frame(height: 40)
                            .padding(12)
                        Divider()
                        if showTag && !searchText.isEmpty {
                            Tags(searchType: $searchType, showAll: $showAll)
                            SearchResults(showAll: $showAll, searchType: $searchType, searchText: $searchText, showTag: $showTag, noResult: $noResult, searchArray: $searchArray, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                        }
                        if !showTag || searchText.isEmpty {
                            RecentSearch(searchArray: $searchArray, cellStructArr: $cellStructArr)
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
            .hideKeyboardWhenTappedAround()
        }
        .navigationViewStyle(.stack)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct SearchTextField: View {
    @Binding var searchText: String
    @Binding var showAll: Bool
    @Binding var showTag : Bool
    var body: some View {
        HStack {
            TextField("Type to search...", text: $searchText,
                      onEditingChanged: { edit in
                print(searchText)
            },
                      onCommit: {
            })
            .frame(height: 20)
            if !searchText.isEmpty {
                Button(action: {
                    self.searchText = ""
                    showAll = true
                } ) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.init(.displayP3, red: 100/255, green: 100/255, blue: 100/255, opacity: 0.5))
                }
                .onAppear() {
                    self.showTag = true
                }
            }
        }
    }
}

struct RecentSearch: View {
    @Binding var searchArray : Bool
    @Binding var cellStructArr : [CellStruct]
    
    var body: some View {
        VStack {
            HStack {
                Text("RECENT SEARCHES")
                    .font(.custom("Gill Sans", size: 15))
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {
                }) {
                    ClearAll()
                        .onTapGesture {
                            print(cellStructArr)
                            cellStructArr.removeAll()
                            self.searchArray.toggle()
                        }
                }
            }
            if cellStructArr.count != 0 {
                ForEach(cellStructArr.indices, id: \.self) { index in
                    CellForSearch(image: cellStructArr[index].image, heading: cellStructArr[index].heading, subHeading: cellStructArr[index].subHeading, showLogo: cellStructArr[index].showLogo)
                        .padding(.vertical, 5)
                        .onAppear() {
                            print(cellStructArr)
                        }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
    }
}

struct SearchTypeList: View {
    @State var moveToLocationDetail : Bool = false
    @State var moveToExperienceDetail : Bool = false
    @State var moveToArticlesDetail : Bool = false
    @State var moveToAccountsDetail : Bool = false
    @Binding var showAll : Bool
    @Binding var cellStructArr : [CellStruct]
    
    var searchText : String = ""
    var searchResultsLocation: [LocationCellModel]
    var searchResultsExperience: [ExperienceCellModel]
    var searchResultsArticles: [ArticlesCellModel]
    var searchResultsAccounts: [ExperienceModel]
    
    @State var getLocationIndex: Int = 0
    @State var getExperienceIndex: Int = 0
    @State var getArticlesIndex: Int = 0
    @State var getAccountsIndex: Int = 0
    @State var searchType : SearchType = .location
    @Binding var moveAfterSearch : MoveAfterSearch
    @Binding var location : String
    
    var body: some View {
        LazyVStack() {
            switch searchType {
            case .location:
                if showAll {
                    let countElements = searchResultsLocation.count >= 2 ? 2 : searchResultsLocation.count
                    LocationSearchList(moveToLocationDetail: $moveToLocationDetail, showAll: $showAll, cellStructArr: $cellStructArr, searchType: $searchType, getLocationIndex: $getLocationIndex, moveAfterSearch: $moveAfterSearch, searchText: searchText, searchResultsLocation: searchResultsLocation, countElements: countElements, location: $location)
                } else {
                    let countElements = searchResultsLocation.count
                    LocationSearchList(moveToLocationDetail: $moveToLocationDetail, showAll: $showAll, cellStructArr: $cellStructArr, searchType: $searchType, getLocationIndex: $getLocationIndex, moveAfterSearch: $moveAfterSearch, searchText: searchText, searchResultsLocation: searchResultsLocation, countElements: countElements, location: $location)
                    
                }
                
            case .experience:
                if showAll {
                    let countElements = searchResultsExperience.count >= 2 ? 2 : searchResultsExperience.count
                    ExperienceSearchList(moveToExperienceDetail: $moveToExperienceDetail, showAll: $showAll, cellStructArr: $cellStructArr, searchType: $searchType, getExperienceIndex: $getExperienceIndex, searchText: searchText, searchResultsExperience: searchResultsExperience, countElements: countElements)
                } else {
                    let countElements = searchResultsExperience.count
                    ExperienceSearchList(moveToExperienceDetail: $moveToExperienceDetail, showAll: $showAll, cellStructArr: $cellStructArr, searchType: $searchType, getExperienceIndex: $getExperienceIndex, searchText: searchText, searchResultsExperience: searchResultsExperience, countElements: countElements)
                }
                
            case .articles:
                if showAll {
                    let countElements = searchResultsArticles.count >= 2 ? 2 : searchResultsArticles.count
                    ArticlesSearchList(moveToArticlesDetail: $moveToArticlesDetail, showAll: $showAll, cellStructArr: $cellStructArr, searchType: $searchType, searchText: searchText, searchResultsArticles: searchResultsArticles, countElements: countElements, getArticlesIndex: $getArticlesIndex)
                } else {
                    let countElements = searchResultsArticles.count
                    ArticlesSearchList(moveToArticlesDetail: $moveToArticlesDetail, showAll: $showAll, cellStructArr: $cellStructArr, searchType: $searchType, searchText: searchText, searchResultsArticles: searchResultsArticles, countElements: countElements, getArticlesIndex: $getArticlesIndex)
                    
                }
                
            case .accounts:
                if showAll {
                    let countElements = searchResultsAccounts.count >= 2 ? 2 : searchResultsAccounts.count
                    ForEach(0..<countElements) { index in
                        CellForSearch(image: searchResultsAccounts[index].coverImage, heading: searchResultsAccounts[index].name, subHeading: searchResultsAccounts[index].userName)
                    }
                } else {
                    let countElements = searchResultsAccounts.count
                    ForEach(0..<countElements) { index in
                        CellForSearch(image: searchResultsAccounts[index].coverImage, heading: searchResultsAccounts[index].name, subHeading: searchResultsAccounts[index].userName)
                    }
                }
                
            case .all:
                ForEach(experienceModelObj) { accounts in
                    CellForSearch(image: accounts.coverImage, heading: accounts.name, subHeading: accounts.userName)
                }
            }
        }
    }
}

struct ExDivider: View {
    let color: Color = .black
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct SearchList: View {
    @State var searchType : SearchType = .location
    @Binding var searchType2 : SearchType
    @Binding var showAll : Bool
    
    var searchText : String = ""
    var searchResultsLocation: [LocationCellModel]
    var searchResultsExperience: [ExperienceCellModel]
    var searchResultsArticles: [ArticlesCellModel]
    var searchResultsAccounts: [ExperienceModel]
    @Binding var cellStructArr : [CellStruct]
    @Binding var moveAfterSearch : MoveAfterSearch
    @Binding var location : String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(searchType.title)
                    .font(.custom("Gill Sans", size: 15))
                    .fontWeight(.medium)
                SearchTypeList(showAll: $showAll, cellStructArr: $cellStructArr, searchText: searchText, searchResultsLocation: searchResultsLocation, searchResultsExperience: searchResultsExperience, searchResultsArticles: searchResultsArticles, searchResultsAccounts: searchResultsAccounts, searchType: searchType, moveAfterSearch: $moveAfterSearch,location: $location)
            }
            .padding(10)
            if showAll {
                Button(action: {}) {
                    SeeAllText(searchType: $searchType)
                        .onTapGesture {
                            showAll = false
                            searchType2 = searchType
                        }
                }
                .foregroundColor(.black)
            }
        }
    }
}

struct CellForSearch: View {
    var image : Image = Image("")
    var heading : String = ""
    var subHeading : String = ""
    var showLogo : Bool = false
    var body: some View {
        HStack {
            image
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            VStack(alignment: .leading) {
                Text(heading)
                    .fontWeight(.medium)
                    .font(.custom("Gill Sans", size: 18))
                Text(subHeading)
                    .font(.custom("Gill Sans", size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(Color.secondary)
            }
            .padding(.leading, 10)
            Spacer()
            if showLogo {
                Image("kvida-logo-nav")
            }
        }
        .listRowSeparator(.hidden)
    }
}

struct NoResultFound: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("kvida-logo")
            Text("No Result Found!")
                .font(.custom("Gill Sans", size: 16))
        }
        .foregroundColor(.secondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ClearAll: View {
    var body: some View {
        Text("Clear all")
            .font(.custom("Gill Sans", size: 20))
            .fontWeight(.regular)
            .foregroundColor(.secondary)
    }
}

struct SeeAllText: View {
    @Binding var searchType : SearchType
    var body: some View {
        Text("See all \(searchType.title.lowercased()) results")
            .font(.custom("Gill Sans", size: 15))
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(Rectangle()
                .stroke(Color.black))
            .padding(.horizontal, 2)
    }
}

struct LocationSearchList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var moveToLocationDetail : Bool
    @Binding var showAll : Bool
    @Binding var cellStructArr : [CellStruct]
    @Binding var searchType : SearchType
    @Binding var getLocationIndex: Int
    @Binding var moveAfterSearch : MoveAfterSearch

    var searchText : String = ""
    var searchResultsLocation: [LocationCellModel]
    var countElements : Int = 0
    @Binding var location : String
    
    
    var body: some View {
        ForEach( 0..<countElements ) { index in
            if moveAfterSearch == .openDetail {
                NavigationLink(destination: LocationDetailView(dataObject: searchResultsLocation[getLocationIndex]), isActive: $moveToLocationDetail ) {
                    CellForSearch(image: searchResultsLocation[index].coverImage, heading: searchResultsLocation[index].place, subHeading: "\(searchResultsLocation[index].location), \(searchResultsLocation[index].country)", showLogo: searchResultsLocation[index].onVida)
                        .padding(.vertical, 5)
                        .onAppear {
                            getLocationIndex = 0
                        }
                        .onTapGesture {
                            getLocationIndex = index
                            moveToLocationDetail.toggle()
                            cellStructArr.insert(CellStruct(type: searchType, image: searchResultsLocation[getLocationIndex].coverImage, heading: searchResultsLocation[getLocationIndex].place, subHeading: "\(searchResultsLocation[getLocationIndex].location), \(searchResultsLocation[getLocationIndex].country)",showLogo: searchResultsLocation[getLocationIndex].onVida, elementPos: getLocationIndex), at: 0)
                        }
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                    CellForSearch(image: searchResultsLocation[index].coverImage, heading: searchResultsLocation[index].place, subHeading: "\(searchResultsLocation[index].location), \(searchResultsLocation[index].country)", showLogo: searchResultsLocation[index].onVida)
                        .padding(.vertical, 5)
                        .onAppear {
                            getLocationIndex = 0
                        }
                        .onTapGesture {
                            getLocationIndex = index
                            location = searchResultsLocation[getLocationIndex].location
                            presentationMode.wrappedValue.dismiss()
                        }
            }
            
        }
    }
}

struct ExperienceSearchList: View {
    
    @Binding var moveToExperienceDetail : Bool
    @Binding var showAll : Bool
    @Binding var cellStructArr : [CellStruct]
    @Binding var searchType : SearchType
    @Binding var getExperienceIndex: Int
    @State var refresh : Bool = false
    var searchText : String = ""
    var searchResultsExperience: [ExperienceCellModel]
    var countElements : Int = 0
        
    var body: some View {
        ForEach(0..<countElements) { index in
            NavigationLink(destination: ExperienceDetailView(dataObject: searchResultsExperience[getExperienceIndex]), isActive: $moveToExperienceDetail) {
                CellForSearch(image: searchResultsExperience[index].coverImage, heading: searchResultsExperience[index].title, subHeading: searchResultsExperience[index].userName)
                    .padding(.vertical, 5)
                    .onAppear {
                        getExperienceIndex = 0
                    }
                    .onTapGesture {
                        getExperienceIndex = index
                        moveToExperienceDetail.toggle()
                        cellStructArr.insert(CellStruct(type: searchType, image: searchResultsExperience[getExperienceIndex].coverImage , heading: searchResultsExperience[getExperienceIndex].title, subHeading: searchResultsExperience[getExperienceIndex].userName, elementPos: getExperienceIndex), at: 0)
                    }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct ArticlesSearchList: View {
    
    @Binding var moveToArticlesDetail : Bool
    @Binding var showAll : Bool
    @Binding var cellStructArr : [CellStruct]
    @Binding var searchType : SearchType
    
    
    var searchText : String = ""
    var searchResultsArticles: [ArticlesCellModel]
    var countElements : Int = 0
    
    @Binding var getArticlesIndex: Int
    
    var body: some View {
        ForEach(0..<countElements) { index in
            NavigationLink(destination: ArticlesDetailView(), isActive: $moveToArticlesDetail) {
                CellForSearch(image: searchResultsArticles[index].articleImage, heading: searchResultsArticles[index].pageNameLable, subHeading: searchResultsArticles[index].descriptionLabel)
                    .padding(.vertical, 5)
                    .onAppear {
                        getArticlesIndex = 0
                    }
                    .onTapGesture {
                        getArticlesIndex = index
                        moveToArticlesDetail.toggle()
                        cellStructArr.insert(CellStruct(type: searchType , image: searchResultsArticles[getArticlesIndex].articleImage , heading: searchResultsArticles[getArticlesIndex].pageNameLable, subHeading: searchResultsArticles[getArticlesIndex].descriptionLabel, elementPos: getArticlesIndex), at: 0)
                        
                    }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
