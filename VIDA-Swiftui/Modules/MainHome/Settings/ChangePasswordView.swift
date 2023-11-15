//
//  ChangePasswordView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 16/11/22.
//

import SwiftUI

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}

struct ChangePasswordView: View {
    @State var currentPassword: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var nextTapped : Bool = false
    @State var passwordReq: Bool = false
    @State var currentPasswordReq: Bool = false

    var body: some View {
        VStack {
            ZStack {
                BackgroundImage()
                    .ignoresSafeArea()

                VStack {
                    ChangePassword(currentPassword: $currentPassword, password: $password, confirmPassword: $confirmPassword, passwordReq: $passwordReq, currentPasswordReq: $currentPasswordReq)
                    ChangePasswordButtonView(nextTapped: $nextTapped, passwordReq: $passwordReq, password: $password, confirmPassword: $confirmPassword, currentPassword: $currentPassword, currentPasswordReq: $currentPasswordReq)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .hideKeyboardWhenTappedAround()
    }
}

struct SubmitButtonPasswordView: View {
    @Binding var currentPassword: String
    @Binding var password: String
    @Binding var confirmPassword: String

    var body: some View {

        if password.isEmpty || confirmPassword.isEmpty || currentPassword.isEmpty {
            GreyNextButton(text: "Submit")
        }
        else {
            GreenNextButton(text: "Submit")
        }
    }
}

struct ChangePasswordTextfield: View {
    @Binding var currentPassword: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @State var createOrConfirm: String = ""
    var body: some View {
        VStack(spacing: 20) {
            UpdateConfirmTextField(password: $currentPassword, createOrConfirm: "Current Password")
            UpdateConfirmTextField(password: $password, createOrConfirm: "New Password")
            UpdateConfirmTextField(password: $confirmPassword, createOrConfirm: "Confirm Password")
        }
        .padding(.top, 20)
        .padding(.horizontal, 30)
    }
}

struct UpdateConfirmTextField: View {
    @Binding var password: String
    @State var createOrConfirm: String = ""

    @State var isSecured : Bool = true
    var body: some View {
        HStack {
            if isSecured {
                SecureField(createOrConfirm, text: $password)
                    .frame(height: 30)
            }
            else {
                TextField(createOrConfirm, text: $password)
                    .frame(height: 30)
            }
            Button(action: {
                self.isSecured.toggle()
            } ) {
                if isSecured {
                    Image("kshowPassword")
                        .foregroundColor(Color.init(.displayP3, red: 100/255, green: 100/255, blue: 100/255, opacity: 0.5))
                }
                else {
                    Image("khidePassword")
                        .foregroundColor(Color.init(.displayP3, red: 100/255, green: 100/255, blue: 100/255, opacity: 0.5))
                }
            }
        }
        .padding(10)
        .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.secondary, lineWidth: 0.4)
                )
    }
}

struct ChangePassword: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var currentPassword: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var passwordReq: Bool
    @Binding var currentPasswordReq: Bool

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                HStack() {
                    Image("chevron-back")
                        .padding(.leading, 30)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                }
                Text("Change Password")
                    .font(.custom("Gill Sans", size: 20))
            }
            ChangePasswordTextfield(currentPassword: $currentPassword, password: $password, confirmPassword: $confirmPassword)
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    Image("ktooltip")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Password must be at least 8 characters with at least 1 upper case, 1 lower case, 1 numeric digit and 1 special character.")
                        .foregroundColor(.secondary)
                        .font(.custom("Gill Sans", size: 15))

                }
                .padding(.top, 10)
                .padding(.horizontal, 30)

                if passwordReq {
                    ToastMessage(req: $passwordReq, text: "Enter a valid password")
                }
                if currentPasswordReq {
                    ToastMessage(req: $currentPasswordReq, text: "Enter correct current password")
                }
            }
        }
        .padding(.top, 20)
    }
}

struct ChangePasswordButtonView: View {
    @Binding var nextTapped: Bool
    @Binding var passwordReq: Bool
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var currentPassword: String
    @Binding var currentPasswordReq: Bool
    @Environment(\.dismiss) private var dismiss

    var defaultPassword : String = UserDefaults.standard.object(forKey: "password") as? String ?? "r"

    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()
            Button(action: {

            }) {
                SubmitButtonPasswordView(currentPassword: $currentPassword, password: $password, confirmPassword: $confirmPassword)
                    .onTapGesture {
                        if currentPassword == defaultPassword {
                            if password == confirmPassword && isPasswordHasEightCharacter(password: password) && isPasswordHasNumberAndCharacter(password: password) && isPasswordHasNumberAndCharacterSign(password: password){
                                dismiss()
                                UserDefaults.standard.set(password, forKey: "password")
                            }
                            else {
                                self.passwordReq = true
                            }
                        } else {
                            self.currentPasswordReq = true
                        }
                    }
            }
            .disabled(password.isEmpty || confirmPassword.isEmpty || currentPassword.isEmpty)
        }
    }
    func isPasswordHasEightCharacter(password: String) -> Bool {
        let passWordRegEx = "^.{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordTest.evaluate(with: password)
    }
    func isPasswordHasNumberAndCharacter(password: String) -> Bool {
        let passRegEx = "(?=[^a-z]*[a-z])[^0-9]*[0-9].*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: password)
    }

    func isPasswordHasNumberAndCharacterSign(password: String) -> Bool {
        let passWordRegEx = "[a-zA-Z0-9!@#$%^&*]+"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordTest.evaluate(with: password)
    }
}
