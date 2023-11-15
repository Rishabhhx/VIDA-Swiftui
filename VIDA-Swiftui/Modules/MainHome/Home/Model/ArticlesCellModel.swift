//
//  ArticlesCellModel.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 05/09/22.
//

import Foundation
import SwiftUI
struct ArticlesCellModel : Identifiable{
    let id = UUID()
    var pageNameLable: String = ""
    var descriptionLabel : String = ""
    var websiteLink : String = ""
    var articleImage: Image = Image("")
}

var articleCellModelObj = [ArticlesCellModel(pageNameLable: "Rishian shhha", descriptionLabel: "sdcdsicidscijdsjcisdcijsdijcdisjdcis", websiteLink: "https://www.apple.com", articleImage: Image("location3")),ArticlesCellModel(pageNameLable: "Karanan shannram", descriptionLabel: "ajsijidiand", websiteLink: "https://www.instagram.com", articleImage: Image("location1")),ArticlesCellModel(pageNameLable: "Lajcnuyy uuaus", descriptionLabel: "ASdjiasd ajdnasndn jkasd dain", websiteLink: "https://www.amazon.com", articleImage: Image("location2"))]

var articleCellListModelObj : [ArticlesCellModel] = []
