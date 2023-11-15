//
//  LoginView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 28/08/22.
//

import SwiftUI

struct LoginView: View {
    
    @State var username : String = ""
    @State var password : String = ""
    @State var userNamePassReq: Bool = false
    @State var nextTappedToForgotUser : Bool = false
    @State var nextTappedToLogin : Bool = false
    @State var nextTappedToForgotPass : Bool = false
    

    let defaultUsername: String = "rishabh"
    let defaultPassword: String = "Dev@1234"

    var body: some View {
        ZStack {
            BackgroundImage()
            VStack {
                BackButtonView()
                VidaLogo()
                UsernamePassword(username: $username, password: $password)
                Forgot(nextTappedToForgotUser: $nextTappedToForgotUser, nextTappedToForgotPass: $nextTappedToForgotPass)
                LoginNextButton(username: $username, password: $password, nextTappedToLogin: $nextTappedToLogin, userNamePassReq: $userNamePassReq)
                NewUser()
                if userNamePassReq {
                    ValidUsernamePass(userNamePassReq: $userNamePassReq)
                }
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .hideKeyboardWhenTappedAround()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct UsernameTextField: View {
    
    @Binding var username : String
    var body: some View {
        HStack {
            TextField("Username", text: $username)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(height: 20)
            if !username.isEmpty {
                Button(action: {
                    self.username = ""
                } ) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.init(.displayP3, red: 100/255, green: 100/255, blue: 100/255, opacity: 0.5))
                }
            }
        }
    }
}

struct UsernamePassword: View {
    @Binding var username: String
    @Binding var password: String

    var body: some View {
        VStack(spacing: 20) {
            UsernameTextField(username: $username)
                .padding()
                .frame(height: 56)
                .border(.secondary, width: 0.4)
            
            CreateConfirmTextField(password: $password, createOrConfirm: "Password")
                .padding()
                .frame(height: 56)
                .border(.secondary, width: 0.4)
        }
        .padding(.horizontal, 30)
    }
}

struct VidaLogo: View {
    var body: some View {
        Image("kvida-logo")
            .resizable()
            .frame(width: 92, height: 103)
            .padding(.top, 20)
            .padding(.bottom, 26)
    }
}

struct Forgot: View {
    @Binding var nextTappedToForgotUser: Bool
    @Binding var nextTappedToForgotPass: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            NavigationLink(destination: ForgotUsernameView(), isActive: $nextTappedToForgotUser) {
                Button(action: {
                }) {
                    Text("Forgot Username?")
                        .onTapGesture {
                            self.nextTappedToForgotUser.toggle()
                        }
                }
            }
            NavigationLink(destination: ForgotPasswordView(), isActive: $nextTappedToForgotPass) {
                Button(action: {
                }) {
                    Text("Forgot Password?")
                        .onTapGesture {
                            self.nextTappedToForgotPass.toggle()
                        }
                }
            }
        }
        .font(.custom("Gill Sans", size: 18))
        .foregroundColor(.black)
        .padding()
    }
}

struct Login: View {
    @Binding var username : String
    @Binding var password : String
    var body: some View {
        if username.isEmpty || password.isEmpty {
            GreyNextButton(text: "Login")
        }
        else {
            GreenNextButton(text: "Login")
        }
    }
}

struct LoginNextButton: View {
    @Binding var username : String
    @Binding var password : String
    @Binding var nextTappedToLogin: Bool
    @Binding var userNamePassReq: Bool


    var body: some View {
        NavigationLink(destination: RegionActivityView(), isActive: $nextTappedToLogin) {
            Button(action: {
                
            }) {
                Login(username: $username, password: $password)
                    .onTapGesture {
                        if username == LoginView().defaultUsername && password == LoginView().defaultPassword {
                            self.nextTappedToLogin.toggle()
                            UserDefaults.standard.set("Logedin", forKey: "Status")
                            UserDefaults.standard.object(forKey: "Status")
                            UserDefaults.standard.set(LoginView().defaultPassword, forKey: "password")

                        }
                        else {
                            self.userNamePassReq = true
                        }
                    }
            }
        }
        .disabled(username.isEmpty || password.isEmpty)
    }
}

struct NewUser: View {
    @State var signupTapped: Bool = false
    var body: some View {
        HStack {
            Text("New User?")
                .foregroundColor(.secondary)
            NavigationLink(destination: SignupView(), isActive: $signupTapped) {
                Button(action: { }) {
                    Text("Sign up")
                        .underline()
                        .foregroundColor(Color.init(.displayP3, red: 36/255, green: 62/255, blue: 54/255, opacity: 1.0))
                        .onTapGesture {
                            self.signupTapped.toggle()
                        }
                }
            }
            
        }
        .font(.custom("Gill Sans", size: 18))
        .padding(.top, 20)
    }
}

struct ValidUsernamePass: View {
    @Binding var userNamePassReq: Bool

    var body: some View {
        Text("Enter correct username/password")
            .disableAutocorrection(true)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 30)
            .foregroundColor(.red)
            .padding(.top, 10)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.userNamePassReq = false
                    }
                }
            }
    }
}
