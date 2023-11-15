//
//  ExperienceTypePopupView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 06/09/22.
//

import SwiftUI

struct ExperienceTypePopupView: View {
//    @State var translation : CGSize = .zero
    @Binding var showPopup : Bool
    @Binding var selectedExperienceType : ExperienceType

    var body: some View {
            VStack {
                PopupContent(showPopup: $showPopup, selectedExperienceType: $selectedExperienceType)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .ignoresSafeArea(edges: .bottom)
    }
}

struct SelectableText: View {
    var text : String = ""
    var body: some View {
        Text(text)
            .font(.custom("Gill Sans", size: 20))
            .foregroundColor(Color.black)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .lineLimit(1)
            .background(Color.clear)
            .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(Color.secondary, lineWidth: 0.4))
    }
}

struct PopupContent: View {
    @Binding var showPopup : Bool
    @Binding var selectedExperienceType : ExperienceType
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 40, height: 4)
                .foregroundColor(Color(.displayP3, red: 18/255, green: 19/255, blue: 29/255, opacity: 0.2))
                .padding()
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                Text("Options")
                    .font(.custom("Gill Sans", size: 24))
                    .fontWeight(.semibold)
                    .padding(.bottom, 15)
                Button(action: {
                    selectedExperienceType = .all
                    showPopup = false
                }) {
                    SelectableText(text: "All")
                }
                Button(action: {
                    selectedExperienceType = .travellers
                    showPopup = false
                }) {
                    SelectableText(text: "Travellers")
                }
                Button(action: {
                    selectedExperienceType = .featuredTravellers
                    showPopup = false
                }) {
                    SelectableText(text: "Featured Travellers")
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
        }
    }
}
