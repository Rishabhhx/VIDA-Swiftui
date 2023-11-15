//
//  DiscoverTravelersView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 01/09/22.
//

import SwiftUI

var changePageControlIndex : (() -> Void)?

struct DiscoverTravelersView: View {
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(red: 134/255, green: 186/255, blue: 160/255, alpha: 1)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    }
    
    var body: some View {
        ZStack {
            BackgroundImage()
            VStack {
                SkipDoneButton()
                ViewHeading(text: "Discover Travelers")
                    .frame(maxWidth: .infinity, alignment: .leading)
                ExperiencePageTab()
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct DiscoverTravelersView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverTravelersView()
    }
}

struct SkipDoneButton: View {
    @State var showSkip: Bool = true
    @State var moveToHome: Bool = false
    @State var skipToHome: Bool = false

    var body: some View {
        HStack {
            if showSkip {
                NavigationLink(destination: TabBarView(), isActive: $skipToHome) {
                    Button(action: {}) {
                        ButtonCustom(text: "Skip", corner: 32)
                            .onTapGesture {
                                self.skipToHome.toggle()
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showSkip = false
                                    }
                                }
                            }
                    }
                    .foregroundColor(Color.black)
                }
            }
            Spacer()
            NavigationLink(destination: TabBarView(), isActive: $moveToHome) {
                Button(action: {}) {
                    ButtonCustom(text: "Done", corner: 32)
                        .onTapGesture {
                            self.moveToHome.toggle()
                        }
                }
                .foregroundColor(Color.black)
            }
        }
        .padding(.all, 24)
    }
}

struct ExperienceProfileHeader: View {
    var name: String
    var username: String
    var index : Int
    @State var followButton : Bool
    var body: some View {
        HStack {
            Image("kprofilePlaceholder")
                .resizable()
                .frame(width: 45,height: 45)
                .cornerRadius(50)
            VStack(alignment: .leading) {
                Text(name)
                    .fontWeight(.medium)
                    .font(.custom("Gill Sans", size: 20))
                Text(username)
                    .font(.custom("Gill Sans", size: 20))
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: {
            }) {
                if followButton {
                    ButtonCustom(text: "Following", corner: 10)
                        .onTapGesture {
                            self.followButton.toggle()
                            experienceModelObj[index].follow = followButton

                        }
                } else {
                    ButtonCustom(text: "Follow", corner: 10, color: Color.white)
                        .onTapGesture {
                            self.followButton.toggle()
                            experienceModelObj[index].follow = followButton

                        }
                }
            }
            .foregroundColor(.black)
            
        }
        .padding(.vertical, 8)
    }
}

struct ExperienceProfileContent: View {
    var coverImage : Image
    var title : String
    var description : String
    var location : String
    var body: some View {
        ZStack {
            coverImage
                .resizable()
            VStack(spacing: 0) {
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .fontWeight(.medium)
                        .font(.custom("Gill Sans", size: 24))
                        .lineLimit(2)
                    Text(description)
                        .font(.custom("Gill Sans", size: 15))
                        .fontWeight(.regular)
                        .lineLimit(2)
                    HStack {
                        Image("klocationpin-alternate")
                            .resizable()
                            .frame(width: 24, height: 20)
                        Text(location)
                            .fontWeight(.medium)
                            .font(.custom("Gill Sans", size: 18))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.white)
                .padding(.vertical, 30)
                .padding(.horizontal, 24)
                
            }
        }
    }
}

struct ExperiencePageTab: View {
    var body: some View {
        TabView {
            ForEach(0 ..< experienceModelObj.count) { item in
                VStack {
                    ExperienceProfileHeader(name: experienceModelObj[item].name, username: experienceModelObj[item].userName, index: item, followButton: experienceModelObj[item].follow)
                    ExperienceProfileContent(coverImage: experienceModelObj[item].coverImage, title: experienceModelObj[item].title, description: experienceModelObj[item].descriptionLabel, location: experienceModelObj[item].locationLabel)
                }
                .frame(width: UIScreen.main.bounds.width - 40)
                .padding(.bottom, 60)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .frame(height: 600, alignment: .top)
        .padding(.bottom)
    }
}
