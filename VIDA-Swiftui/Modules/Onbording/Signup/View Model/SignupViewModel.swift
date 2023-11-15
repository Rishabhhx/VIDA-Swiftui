//
//  SignupViewModel.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 21/11/22.
//

import SwiftUI

extension EmailComponents {
    class ViewModel : ObservableObject {
        @Published var emailText: String = ""
        @Published var nextTapped : Bool = false
        @Published var emailReq : Bool = false
        
        func checkingMail() {
            if isValidEmail(emailText) {
                self.nextTapped.toggle()
            }
            else {
                self.emailReq = true
            }
        }
        
        func isValidEmail(_ email: String) -> Bool {
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: email)
            }
    }
}
