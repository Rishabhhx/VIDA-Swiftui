//
//  viewmodel.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 28/08/22.
//

import SwiftUI

extension VerifyOTP {
    class ViewModel: ObservableObject {
        
        @Published var otpField = "" {
            didSet {
                guard otpField.count <= 4,
                      otpField.last?.isNumber ?? true else {
                    otpField = oldValue
                    return
                }
            }
        }
        var otp1: String {
            guard otpField.count >= 1 else {
                return ""
            }
            return String(Array(otpField)[0])
        }
        var otp2: String {
            guard otpField.count >= 2 else {
                return ""
            }
            return String(Array(otpField)[1])
        }
        var otp3: String {
            guard otpField.count >= 3 else {
                return ""
            }
            return String(Array(otpField)[2])
        }
        var otp4: String {
            guard otpField.count == 4 else {
                return ""
            }
            return String(Array(otpField)[3])
        }
        
        @Published var borderColor: Color = .black
        @Published var isTextFieldDisabled = false
        var successCompletionHandler: (()->())?
        
        @Published var showResendText = false

    }

}
