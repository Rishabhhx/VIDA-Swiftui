//
//  SignupView4.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 27/08/22.
//

import SwiftUI

struct SignupView4: View {
    var body: some View {
        VStack {
            ZStack {
                BackgroundImage()
                UsernameComponents()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
        .hideKeyboardWhenTappedAround()
    }
}

struct SignupView4_Previews: PreviewProvider {
    static var previews: some View {
        SignupView4()
    }
}

struct UsernameTextfield: View {
    @Binding var usernameText: String
    var body: some View {
        HStack(alignment: .center) {
            Text("@")
                .fontWeight(.bold)
                .font(.custom("Gill Sans", size: 26))
            TextField("Username", text: $usernameText)
                .frame(height: 20)
            if !usernameText.isEmpty {
                Button(action: {
                    self.usernameText = ""
                } ) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.init(.displayP3, red: 100/255, green: 100/255, blue: 100/255, opacity: 0.5))
                }
            }
        }
        .padding(.horizontal, 30)
    }
}

struct NextUsernameButtonView: View {
    @Binding var usernameText: String
    @Binding var agreedTerms: Bool
    
    var body: some View {
        if usernameText.isEmpty || !agreedTerms {
            GreyNextButton(text: "Next")
        }
        else {
            GreenNextButton(text: "Next")
        }
    }
}

struct UsernameComponents: View {
    
    @State var usernameText: String = ""
    @State var nextTapped : Bool = false
    @State var userNameReq : Bool = false
    @State var agreedTerms : Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                BackButtonView()
                ViewHeading(text: "Pick a user name..")
                UsernameTextfield(usernameText: $usernameText)
                VStack() {
                    HStack(alignment: .top, spacing: 10) {
                        Image("ktooltip")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Username must be at least 3 characters , no more than 15 characters and can contain letters (a-z) , numbers (0-9) ,periods (.) and underscore ( _ ).")
                            .foregroundColor(.secondary)
                            .font(.custom("Gill Sans", size: 15))
                        
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.top, 20)
                VStack(alignment: .center) {
                    if userNameReq {
                        ToastMessage(req: $userNameReq, text: "Enter valid username")
                    }
                }
                Spacer()
            }
            VStack(alignment: .leading) {
                Spacer()
                VStack {
                    ProgressBar(text: "4 of 4", barValue: 1.0)
                }
                HStack {
                    Button(action: {
                        self.agreedTerms.toggle()
                    }){
                        if agreedTerms {
                            Image("kcheckedBox")
                                .renderingMode(.original)
                        }
                        else {
                            Image("kuncheckedBox")
                                .renderingMode(.original)
                        }
                    }
                    Text("I agree to the")
                        .font(.custom("Gill Sans", size: 15))
                        .foregroundColor(.secondary)
                    Text("Terms And Conditions")
                        .font(.custom("Gill Sans", size: 15))
                        .underline()
                        .foregroundColor(Color.init(.displayP3, red: 36/255, green: 62/255, blue: 54/255, opacity: 1.0))
                }
                .padding(.horizontal, 30)
                .padding(.vertical)
                NavigationLink(destination: VerifyOTPView(), isActive: $nextTapped) {
                    Button(action: {
                    }) {
                        NextUsernameButtonView(usernameText: $usernameText, agreedTerms: $agreedTerms)
                            .onTapGesture {
                                if isValidUsername(usernameText)  {
//                                    UserDefaults.standard.set(usernameText, forKey: "userName")

                                    self.nextTapped.toggle()
                                }
                                else {
                                    self.userNameReq = true
                                }
                            }
                    }
                }
                .disabled(usernameText.isEmpty || !agreedTerms)
            }
        }
        .padding(.top, 40)
    }
    private func isValidUsername(_ username: String) -> Bool {
        let usernameRegEx = "^[[A-Z]|[a-z]][[A-Z]|[a-z]|\\d|[_]]{7,29}$"
        let usernamePred = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
        return usernamePred.evaluate(with: username)
    }
}
