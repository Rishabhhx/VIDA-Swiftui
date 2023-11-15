//
//  PostOptionsView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 30/09/22.
//

import SwiftUI

struct PostOptionsView: View {
    @State private var publicIsOn = true
    @State private var instaIsOn = false
    @Binding var showPostOptions : Bool
    @Binding var postExperience : Bool

    var body: some View {
        NavigationView {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 40, height: 4)
                    .foregroundColor(Color(.displayP3, red: 18/255, green: 19/255, blue: 29/255, opacity: 0.2))
                    .padding()
                PostOptionsHeader(showPostOptions: $showPostOptions, postExperience: $postExperience)
                Divider()
                ToggleWithText(isOn: $publicIsOn, text: "Public")
                ToggleWithText(isOn: $instaIsOn, text: "Share To Instagram")
                Divider()
                if !publicIsOn {
                    PublicOffInformation()
                }
                Spacer()
            }
            .onDisappear() {
                
            }
        }
    }
}

//struct PostOptionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostOptionsView()
//    }
//}

struct PostOptionsHeader: View {
    @Binding var showPostOptions : Bool
    @Binding var postExperience : Bool

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Button(action: {
                    self.showPostOptions.toggle()
                    postExperience = true
                }) {
                    ShareText()
                }
            }
            .padding(.horizontal, 10)
            Text("Post Options")
                .font(.custom("Gill Sans", size: 18))
                .fontWeight(.light)
        }
    }
}

struct ToggleWithText: View {
    @Binding var isOn : Bool
    var text : String = "Text"
    var body: some View {
        HStack {
            Toggle(isOn: $isOn) {
                Text(text)
                    .font(.custom("Gill Sans", size: 20))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct PublicOffInformation: View {
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image("ktooltip")
                .resizable()
                .frame(width: 20, height: 20)
            Text("By turning public toggle off, your post will only appear to you on your profile")
                .foregroundColor(.secondary)
                .font(.custom("Gill Sans", size: 15))
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 12)
    }
}

struct ShareText: View {
    var body: some View {
        Text("Share")
            .font(.custom("Gill Sans", size: 18))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.init(.displayP3, red: 36/255, green: 62/255, blue: 54/255, opacity: 1.0)))
    }
}
