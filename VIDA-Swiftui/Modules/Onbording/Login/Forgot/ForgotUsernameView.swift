//
//  ForgotUsernameView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 29/08/22.
//

import SwiftUI

struct ForgotUsernameView: View {
    
    @State var emailText : String = ""
    @State var loginSubmitTapped : Bool = false
    @State var emailReq : Bool = false
    @State var userameorpassword = "Forgot Username?"
    
    var body: some View {
        ZStack {
            BackgroundImage()
            VStack(alignment: .leading) {
                BackButtonView()
                ViewHeading(text: "\(userameorpassword)")
                EmailTextfield(emailText: $emailText)
                    .frame(height: 56)
                    .border(.secondary, width: 0.4)
                    .padding(.horizontal, 30)
                if emailReq {
                    ToastMessage(req: $emailReq, text: "Enter a valid email.")
                }
                Spacer()
                checkingEmail
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .hideKeyboardWhenTappedAround()
    }
    
    var checkingEmail : some View {
        NavigationLink(destination: SignupView2(), isActive: $loginSubmitTapped) {
            Button(action: {
            }) {
                SubmitEmailButtonView(emailText: $emailText)
                    .onTapGesture {
                        if isValidEmail(emailText) {
                            self.loginSubmitTapped.toggle()
                        }
                        else {
                            self.emailReq = true
                        }
                    }
            }
        }
        .disabled(emailText.isEmpty)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }

}

struct ForgotUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotUsernameView()
    }
}

struct SubmitEmailButtonView: View {
    @Binding var emailText: String
    
    var body: some View {
        if emailText.isEmpty{
            GreyNextButton(text: "Submit")
        }
        else {
            GreenNextButton(text: "Submit")
        }
    }
}
