//
//  Followers&Followings.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 18/11/22.
//

import SwiftUI

struct Followers_Followings: View {
    @State var selectedSection : Followers = .following
    var column: [GridItem] = [
        GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            FollowingHeader()
            
            FollowingFollowerSection(selectedSection: $selectedSection)
            LazyVGrid(columns: column, spacing: 10) {
                ForEach(0..<5, id: \.self) { index in
                    FollowingFollowerProfileCell()
                }
            }
            Spacer()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct Followers_Followings_Previews: PreviewProvider {
    static var previews: some View {
        Followers_Followings()
    }
}

enum Followers {
    case followers
    case following
}

struct FollowingHeader: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Image("chevron-back")
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(20)
                Spacer()
            }
            Text("Followers & Followings")
                .font(.custom("Gill Sans", size: 20))
        }
    }
}

struct FollowingFollowerSection: View {
    @Binding var selectedSection : Followers

    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                selectedSection = .following
            }) {
                if selectedSection == .following {
                    SectionView(sectionTitle: "Following", sectionTitleColor: Color.black, sectionLineColor: Color.green)
                    
                } else {
                    SectionView(sectionTitle: "Following", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                }
            }
            Button(action: {
                selectedSection = .followers
            }) {
                if selectedSection == .followers {
                    SectionView(sectionTitle: "Followers", sectionTitleColor: Color.black, sectionLineColor: Color.green)
                    
                } else {
                    SectionView(sectionTitle: "Followers", sectionTitleColor: Color.gray, sectionLineColor: Color(.displayP3, red: 238/255, green: 238/255, blue: 238/255))
                }
            }
        }
        .padding(.top, 40)
    }
}

struct FollowingFollowerProfileCell: View {
    @State var followingButton : Bool = false
    var body: some View {
        HStack {
            Image("spain1")
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(50)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(userProfileObj.name)
                        .font(.custom("Gill Sans", size: 16))
                        .fontWeight(.medium)
                    if userProfileObj.isVerified {
                        Image("featured-traveller-profile")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
                }
                Text(userProfileObj.username)
                    .font(.custom("Gill Sans", size: 13))
                    .fontWeight(.light)
            }
            Spacer()
            if followingButton {
                Button(action: {
                    followingButton.toggle()
                }) {
                    FollowFollowingButtonView(text: "Follow", isSelected: $followingButton)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Button(action: {
                    followingButton.toggle()
                }) {
                    FollowFollowingButtonView(text: "Following", isSelected: $followingButton)

                }
                .buttonStyle(PlainButtonStyle())
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

struct FollowFollowingButtonView: View {
    var text : String = "Following"
    @Binding var isSelected : Bool
    var body: some View {
        Text(text)
            .padding(.horizontal, 20)
            .padding(.vertical, 6)
            .font(.custom("Gill Sans", size: 15))
            .background(isSelected ? Color(.displayP3, red: 216/255, green: 235/255, blue: 227/255, opacity: 100) : Color.clear)
            .overlay(Capsule().stroke(isSelected ? Color.clear : Color.secondary, lineWidth: 1))
            .cornerRadius(30)
    }
}
