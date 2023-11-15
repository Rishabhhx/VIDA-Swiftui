//
//  SignupView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 26/08/22.
//

import SwiftUI

struct SignupView: View {
    
    var body: some View {
        VStack {
            ZStack {
                BackgroundImage()
                EmailComponents()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
        .hideKeyboardWhenTappedAround()
        
    }
    
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

struct EmailTextfield: View {
    @Binding var emailText: String
    var body: some View {
        HStack {
            TextField("Email", text: $emailText)
                .frame(height: 20)
            if !emailText.isEmpty {
                Button(action: {
                    self.emailText = ""
                } ) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.init(.displayP3, red: 100/255, green: 100/255, blue: 100/255, opacity: 0.5))
                }
            }
        }
        .padding(.horizontal, 30)
    }
}

struct NextButtonView: View {
    @Binding var emailText: String
    
    var body: some View {
        if emailText.isEmpty {
            GreyNextButton(text: "Next")
        }
        else {
            GreenNextButton(text: "Next")
        }
    }
}

struct EmailComponents: View {
    
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                BackButtonView()
                ViewHeading(text: "What's your email?...")
                EmailTextfield(emailText: $viewModel.emailText)
                VStack(alignment: .center) {
                    if viewModel.emailReq {
                        ToastMessage(req: $viewModel.emailReq, text: "Enter valid email")
                    }
                }
                Spacer()
            }
            VStack {
                Spacer()
                ProgressBar(text: "2 of 4", barValue: 0.25)
                
                NavigationLink(destination: SignupView2(), isActive: $viewModel.nextTapped) {
                    Button(action: {
                    }) {
                        NextButtonView(emailText: $viewModel.emailText)
                            .onTapGesture {
                                viewModel.checkingMail()
                            }
                    }
                }
                .disabled(viewModel.emailText.isEmpty)
            }
        }
        .padding(.top, 40)
    }
}
