//
//  LocationModel.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 05/09/22.
//

import SwiftUI

struct LocationCellModel : Identifiable {
    let id = UUID()
    var place: String = ""
    var location :String = ""
    var coverImage: Image = Image("")
    var likeCount : Int = 0
    var likeButton: Bool = false
    var country : String = ""
    var locationDescription : String = ""
    var onVida : Bool = false

}

var locationCellModelObj = [LocationCellModel(place: "New Building", location: "Barcelona", coverImage: Image("location1"), likeCount: 2, likeButton: false, country: "Spain", locationDescription: "similar to the way dolphins and bats communicate! LoRa modulated transmission",onVida: true),LocationCellModel(place: "New Emiartes", location: "Madrid", coverImage: Image("location2"), likeCount: 4, likeButton: false, country: "USA", locationDescription: "layer which defines how devices use the LoRa hardware, for example when they transmit, and the format of messages.",onVida: true), LocationCellModel(place: "ApeTown", location: "Italy", coverImage: Image("location3"), likeCount: 10, likeButton: true, country: "South Africa", locationDescription: "LoRaWAN gateways can transmit and receive signals over a distance of over 10 kilometers in rural areas and up to 3 kilometers in dense urban areas.",onVida: false),LocationCellModel(place: "New Crocls", location: "Berlin", coverImage: Image("location1"), likeCount: 2, likeButton: false, country: "Spain", locationDescription: "similar to the way dolphins and bats communicate! LoRa modulated transmission",onVida: true),LocationCellModel(place: "New Ham", location: "Brinmbigam", coverImage: Image("location1"), likeCount: 2, likeButton: false, country: "Spain", locationDescription: "similar to the way dolphins and bats communicate! LoRa modulated transmission",onVida: true),LocationCellModel(place: "New Delhi", location: "Badarpur", coverImage: Image("location2"), likeCount: 5, likeButton: true, country: "India", locationDescription: "similar to the way dolphins and bats communicate! LoRa modulated transmission",onVida: false)]

var locationCellListModelObj : [LocationCellModel] = []
