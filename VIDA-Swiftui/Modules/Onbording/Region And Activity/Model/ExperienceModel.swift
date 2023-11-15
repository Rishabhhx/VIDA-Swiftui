//
//  ExperienceModel.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 02/09/22.
//

import SwiftUI

struct ExperienceModel : Identifiable {
    let id = UUID()
    var name: String
    let userName : String
    var title: String
    var descriptionLabel :String
    var locationLabel: String
    var coverImage: Image
    var follow: Bool
}

var experienceModelObj = [ExperienceModel(name: "Neha", userName: "neha11", title: "Across the Wilderness", descriptionLabel: "Located at the intersection of three major storm tracks", locationLabel: "Assam", coverImage: Image("spain1"), follow: false), ExperienceModel(name: "Huda", userName: "huda34", title: "Mt. Washington", descriptionLabel: "The summit has an alpine.. ", locationLabel: "Delhi", coverImage: Image("spain2"), follow: true)]
