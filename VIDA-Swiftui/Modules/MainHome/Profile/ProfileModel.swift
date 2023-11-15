//
//  ProfileModel.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 01/11/22.
//

import SwiftUI
struct ProfileModel : Identifiable {
    let id = UUID()
    var name: String = UserDefaults.standard.object(forKey: "name") as? String ?? "R"
    var username : String = UserDefaults.standard.object(forKey: "username") as? String ?? "r"
    var followers : Int = 2
    var following : Int = 9
    var placeVisited : Int = 4
    var isVerified : Bool = true
    var profilePicture : Image = Image("kprofilePlaceholder")
    var profileBanner : Image = Image("klandscape-placeholder")
    var createdLocation : [LocationCellModel] = []
    var createdExperience : [ExperienceCellModel] = []
}

var userProfileObj = ProfileModel()
