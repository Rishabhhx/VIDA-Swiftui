//
//  ForgotPasswordView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 30/08/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State var emailText : String = ""
    @State var loginSubmitTapped : Bool = false
    @State var emailReq : Bool = false
    @State var userameorpassword = "Forgot Password?"
    
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
        NavigationLink(destination: NewPasswordView(), isActive: $loginSubmitTapped) {
            Button(action: {
            }) {
                SubmitEmailPassButtonView(emailText: $emailText)
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

struct SubmitEmailPassButtonView: View {
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

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
