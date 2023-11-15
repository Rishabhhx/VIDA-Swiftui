//
//  SearchResults.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 15/09/22.
//

import SwiftUI

struct SearchResults: View {
    
    @Binding var showAll : Bool
    @Binding var searchType : SearchType
    @Binding var searchText : String
    @Binding var showTag : Bool
    @Binding var noResult : Bool
    @Binding var searchArray : Bool
    @Binding var cellStructArr : [CellStruct]
    @Binding var moveAfterSearch : MoveAfterSearch
    @Binding var location : String

    
    var searchResultsLocation: [LocationCellModel] {
        if searchText.isEmpty {
            return locationCellModelObj
        } else {
            return locationCellModelObj.filter { $0.location.contains(searchText)}
        }
    }
    var searchResultsExperience: [ExperienceCellModel] {
        if searchText.isEmpty {
            return experienceCellModelObj
        } else {
            return experienceCellModelObj.filter { $0.title.contains(searchText)}
        }
    }
    var searchResultsArticles: [ArticlesCellModel] {
        if searchText.isEmpty {
            return articleCellModelObj
        } else {
            return articleCellModelObj.filter { $0.pageNameLable.contains(searchText)}
        }
    }
    var searchResultsAccounts: [ExperienceModel] {
        if searchText.isEmpty {
            return experienceModelObj
        } else {
            return experienceModelObj.filter { $0.userName.contains(searchText)}
        }
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                switch searchType {
                case .location:
                    if searchResultsLocation.isEmpty {
                        
                    } else {
                        SearchList(searchType: .location, searchType2: $searchType, showAll: $showAll, searchText: searchText, searchResultsLocation: searchResultsLocation, searchResultsExperience: searchResultsExperience, searchResultsArticles: searchResultsArticles, searchResultsAccounts: searchResultsAccounts, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                    }
                    
                case .experience:
                    if searchResultsExperience.isEmpty {
                        
                    } else {
                        SearchList( searchType: .experience,searchType2: $searchType,showAll: $showAll, searchText: searchText, searchResultsLocation: searchResultsLocation, searchResultsExperience: searchResultsExperience, searchResultsArticles: searchResultsArticles, searchResultsAccounts: searchResultsAccounts, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                    }
                    
                case .articles:
                    if searchResultsArticles.isEmpty {
                        
                    } else {
                        SearchList( searchType: .articles,searchType2: $searchType,showAll: $showAll, searchText: searchText, searchResultsLocation: searchResultsLocation, searchResultsExperience: searchResultsExperience, searchResultsArticles: searchResultsArticles, searchResultsAccounts: searchResultsAccounts, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                    }
                    
                case .accounts:
                    if searchResultsAccounts.isEmpty {
                        
                    } else {
                        SearchList(searchType: .accounts, searchType2: $searchType,showAll: $showAll, searchText: searchText, searchResultsLocation: searchResultsLocation, searchResultsExperience: searchResultsExperience, searchResultsArticles: searchResultsArticles, searchResultsAccounts: searchResultsAccounts, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                    }
                    
                case .all:
                    if !searchResultsLocation.isEmpty {
                        SearchList( searchType: .location, searchType2: $searchType,showAll: $showAll, searchText: searchText, searchResultsLocation: searchResultsLocation, searchResultsExperience: searchResultsExperience, searchResultsArticles: searchResultsArticles, searchResultsAccounts: searchResultsAccounts, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                    }
                    if !searchResultsExperience.isEmpty {
                        SearchList(searchType: .experience, searchType2: $searchType,showAll: $showAll, searchText: searchText, searchResultsLocation: searchResultsLocation, searchResultsExperience: searchResultsExperience, searchResultsArticles: searchResultsArticles, searchResultsAccounts: searchResultsAccounts, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                    }
                    if !searchResultsArticles.isEmpty {
                        SearchList(searchType: .articles, searchType2: $searchType,showAll: $showAll, searchText: searchText, searchResultsLocation: searchResultsLocation, searchResultsExperience: searchResultsExperience, searchResultsArticles: searchResultsArticles, searchResultsAccounts: searchResultsAccounts, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                    }
                    if !searchResultsAccounts.isEmpty {
                        SearchList(searchType: .accounts, searchType2: $searchType,showAll: $showAll, searchText: searchText, searchResultsLocation: searchResultsLocation, searchResultsExperience: searchResultsExperience, searchResultsArticles: searchResultsArticles, searchResultsAccounts: searchResultsAccounts, cellStructArr: $cellStructArr, moveAfterSearch: $moveAfterSearch, location: $location)
                    }
                }
            }
        }
    }
}
