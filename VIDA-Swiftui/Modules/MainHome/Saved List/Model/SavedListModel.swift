//
//  SavedListModel.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 02/10/22.
//

import SwiftUI
struct SavedListModel : Identifiable {
    let id = UUID()
    var listImage : Image = Image("")
    var listName : String = ""
    var savedExperience : [ExperienceCellModel] = []
    var savedLocation : [LocationCellModel] = []
    var savedArticles : [ArticlesCellModel] = []
}

var savedListObj = [SavedListModel(listImage: Image("location5"), listName: "Goaaa Goneee", savedExperience: [experienceCellModelObj[0]]), SavedListModel(listImage: Image("location4"), listName: "We PArtyyy")]

struct RecentSavedListModel : Identifiable {
    let id = UUID()
    var saveImage : Image = Image("")
    var saveTitle : String = ""
    var saveDesc : String = ""
}

var recentSavedListObj : [RecentSavedListModel] = []
