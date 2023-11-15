//
//  SettingsView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 07/11/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State var discardExperience : Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SettingsViewHeader()
            SettingsOptionView()
            DeleteAndLogout(discardExperience: $discardExperience)
            Spacer()
        }
        .overlay(alignment: .center) {
            if discardExperience {
                PopupYesNoView(text1: "Are you sure you want to delete", text2: "your account?", yesButtonPressed: {discardExperience.toggle()}, noButtonPressed: {discardExperience.toggle()})
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct SettingsViewHeader: View {
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
            Text("Settings")
                .font(.custom("Gill Sans", size: 20))
        }
    }
}

struct SettingsOption: View {
    var settingOptionText : String = "Change Password"
    var body: some View {
        HStack {
            Text(settingOptionText)
                .font(.custom("Gill Sans", size: 20))
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

struct DeleteAndLogout: View {
    @Binding var discardExperience : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Button(action: {
                discardExperience.toggle()
            }) {
                Text("Delete Account")
                    .font(.custom("Gill Sans", size: 20))
            }
            .buttonStyle(PlainButtonStyle())
            Button(action: {
                discardExperience.toggle()
            }) {
                Text("Logout")
                    .font(.custom("Gill Sans", size: 20))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal,20)
        .padding(.top, 30)
    }
}

struct SettingsOptionView: View {
    @State var pushView : Bool = false
    @State var getItem : String = ""
    @State var showPopup : Bool = false

    var column: [GridItem] = [
        GridItem(.flexible())]
    var settingsOption : [String] = ["Change Password", "Privacy Policy", "Support", "Terms & Conditions"]
    var body: some View {
        LazyVGrid(columns: column , spacing: 30) {
            ForEach(settingsOption, id: \.self) { item in
                NavigationLink(destination:
                                Group {
                    if getItem == "Change Password" {
                        ChangePasswordView()
                    }
                    if getItem == "Privacy Policy" {
                        PrivacyTermsView(urlType: .privacy)
                    }
                    if getItem == "Support" {
                        SettingsView()
                    }
                    if getItem == "Terms & Conditions" {
                        PrivacyTermsView(urlType: .terms)
                    }
                }, isActive: $pushView) {
                    Button(action: {
                        getItem = item
                        if getItem == "Support" {
                            self.showPopup.toggle()
                        }
                        else {
                            pushView.toggle()
                        }
                    }) {
                        SettingsOption(settingOptionText: item)
                            .sheet(isPresented: $showPopup) {
                                SupportView()                           .presentationDetents([.medium])
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 20)
    }
}
