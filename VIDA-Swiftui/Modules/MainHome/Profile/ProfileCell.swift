//
//  ProfileCell.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 26/10/22.
//

import SwiftUI

struct ProfileCell: View {
    var dataObjectLocation = LocationCellModel()
    var dataObjectExperience = ExperienceCellModel()
    @Binding var selectedSection : Sections
    @State var image : Image = Image("")
    @State var likes : Int = 0
    @State var title : String = ""
    var body: some View {
        VStack {
            ZStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160 , height: 210)
                    .clipped()
                Image("blackOverlay")
                    .resizable()
                    .opacity(0.25)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("\(likes)")
                            .font(.custom("Gill Sans", size: 20))
                        Image("khome-unlikebutton")
                    }
                    .padding(15)
                    Spacer()
                    Text(title)
                        .font(.custom("Gill Sans", size: 18))
                        .padding(15)
                }
                .foregroundColor(.white)
            }
        }
        .frame(width: 160 , height: 210)
        .cornerRadius(15)
        .onAppear() {
            if selectedSection == .locations {
                image = dataObjectLocation.coverImage
                likes = dataObjectLocation.likeCount
                title = dataObjectLocation.place
            } else if selectedSection == .experience {
                image = dataObjectExperience.coverImage
                likes = dataObjectExperience.likeCount
                title = dataObjectExperience.title
            }
        }
    }
}

//struct ProfileCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCell()
//    }
//}
