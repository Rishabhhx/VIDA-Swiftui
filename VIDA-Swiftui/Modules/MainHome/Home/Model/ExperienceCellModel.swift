//
//  ExperienceCellModel.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 04/09/22.
//

import SwiftUI

struct ExperienceCellModel : Identifiable{
    let id = UUID()
    var name: String = ""
    var userName : String = ""
    var title: String = ""
    var descriptionLabel :String = ""
    var locationLabel: String = ""
    var coverImage: Image = Image("")
    var profileImage : String = ""
    var likeCount : Int = 0
    var likeButton: Bool = false
    var travelerFeatured: Bool = false
    var experienceImages : [Image] = [Image("")]
}

var experienceCellModelObj = [ExperienceCellModel(name: "Rishabh", userName: "rishabh1", title: "First Time delhi", descriptionLabel: "Delhi", locationLabel: "New Delhi", coverImage: Image("spain1"), profileImage: "spain2", likeCount: 3, likeButton: false, travelerFeatured: true, experienceImages: [Image("spain1"),Image("spain2"),Image("location1"),Image("location2")]),ExperienceCellModel(name: "Ronit", userName: "ronittushir", title: "Welcome to Mumbai", descriptionLabel: "Mumbai is the Best!!!", locationLabel: "Mumbai", coverImage: Image("spain2"), profileImage: "spain1", likeCount: 10, likeButton: false, travelerFeatured: false, experienceImages: [Image("spain1"),Image("spain2"),Image("location1"),Image("location2")]),ExperienceCellModel(name: "Huda", userName: "hudahuda", title: "Take KT give Kt", descriptionLabel: "Meerut is the Best!!!", locationLabel: "Meerut", coverImage: Image("location2"), profileImage: "location1", likeCount: 10, likeButton: false, travelerFeatured: false, experienceImages: [Image("spain1"),Image("spain2"),Image("location1"),Image("location2")]),ExperienceCellModel(name: "Neha", userName: "neha11", title: "Go Goa", descriptionLabel: "Goa is the Best!!!", locationLabel: "Goa", coverImage: Image("location1"), profileImage: "location2", likeCount: 2, likeButton: false, travelerFeatured: true, experienceImages: [Image("spain1"),Image("spain2"),Image("location1"),Image("location2")])]

var experienceCellListModelObj : [ExperienceCellModel] = []
