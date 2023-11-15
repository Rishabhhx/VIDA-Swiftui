//
//  NewPasswordView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 30/08/22.
//

import SwiftUI

struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView()
    }
}

struct NewPasswordView: View {
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var nextTapped : Bool = false
    @State var passwordReq: Bool = false
    var body: some View {
        VStack {
            ZStack {
                BackgroundImage()
                VStack {
                    SetNewPasswordView(password: $password, confirmPassword: $confirmPassword, passwordReq: $passwordReq)
                    SetNewPasswordButtonView(nextTapped: $nextTapped, passwordReq: $passwordReq, password: $password, confirmPassword: $confirmPassword)
                }
                .padding(.top, 40)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
        .hideKeyboardWhenTappedAround()
    }
}


struct SetNewPasswordView: View {
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var passwordReq: Bool


    var body: some View {
        VStack(alignment: .leading) {
            BackButtonView()
            ViewHeading(text: "Set New Password")
            PasswordTextfield(password: $password, confirmPassword: $confirmPassword)
            VStack() {
                HStack(alignment: .top, spacing: 10) {
                    Image("ktooltip")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Password must be at least 8 characters with at least 1 upper case, 1 lower case, 1 numeric digit and 1 special character.")
                        .foregroundColor(.secondary)
                        .font(.custom("Gill Sans", size: 15))
                    
                }
                .padding(.horizontal, 30)
                
                if passwordReq {
                    ToastMessage(req: $passwordReq, text: "Enter a valid password")
                }
            }
        }
    }
}

struct SetNewPasswordButtonView: View {
    @Binding var nextTapped: Bool
    @Binding var passwordReq: Bool
    @Binding var password: String
    @Binding var confirmPassword: String

    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()
            
            NavigationLink(destination: OnboardingView(), isActive: $nextTapped) {
                Button(action: {
                    
                }) {
                    NextButtonPasswordView(password: $password, confirmPassword: $confirmPassword)
                        .onTapGesture {
                            if password == confirmPassword && isPasswordHasEightCharacter(password: password) && isPasswordHasNumberAndCharacter(password: password) && isPasswordHasNumberAndCharacterSign(password: password){
                                self.nextTapped.toggle()
                            }
                            else {
                                self.passwordReq = true
                            }
                        }
                }
            }
            .disabled(password.isEmpty || confirmPassword.isEmpty)
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
