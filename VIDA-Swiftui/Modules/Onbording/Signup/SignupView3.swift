//
//  SignupView3.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 27/08/22.
//

import SwiftUI

struct SignupView3: View {
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var nextTapped : Bool = false
    @State var passwordReq: Bool = false
    var body: some View {
        VStack {
            ZStack {
                BackgroundImage()
                VStack {
                    PasswordView(password: $password, confirmPassword: $confirmPassword, passwordReq: $passwordReq)
                    PasswordButtonView(nextTapped: $nextTapped, passwordReq: $passwordReq, password: $password, confirmPassword: $confirmPassword)
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

struct SignupView3_Previews: PreviewProvider {
    static var previews: some View {
        SignupView3()
    }
}

struct NextButtonPasswordView: View {
    @Binding var password: String
    @Binding var confirmPassword: String
    
    var body: some View {
        
        if password.isEmpty || confirmPassword.isEmpty {
            GreyNextButton(text: "Next")
        }
        else {
            GreenNextButton(text: "Next")
        }
    }
}

struct PasswordTextfield: View {
    @Binding var password: String
    @Binding var confirmPassword: String
    @State var createOrConfirm: String = ""
    var body: some View {
        VStack(spacing: 20) {
            CreateConfirmTextField(password: $password, createOrConfirm: "Password")
            CreateConfirmTextField(password: $confirmPassword, createOrConfirm: "Confirm Password")
        }
        .padding(.horizontal, 30)
    }
}

struct CreateConfirmTextField: View {
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
    }
}

struct PasswordView: View {
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var passwordReq: Bool


    var body: some View {
        VStack(alignment: .leading) {
            BackButtonView()
            ViewHeading(text: "Create a password")
            PasswordTextfield(password: $password, confirmPassword: $confirmPassword)
            VStack {
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

struct PasswordButtonView: View {
    @Binding var nextTapped: Bool
    @Binding var passwordReq: Bool
    @Binding var password: String
    @Binding var confirmPassword: String

    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()
            ProgressBar(text: "3 of 4", barValue: 0.75)
            NavigationLink(destination: SignupView4(), isActive: $nextTapped) {
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
