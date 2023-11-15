//
//  SignupView2.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 27/08/22.
//

import SwiftUI

struct SignupView2: View {
    @State var nameText: String = ""
    @State var nextTapped : Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                BackgroundImage()
                VStack {
                    VStack(alignment: .leading) {
                        BackButtonView()
                        ViewHeading(text: "What's your name?")
                        NameTextField(nameText: $nameText)

                        Spacer()
                    }
                    VStack(alignment: .trailing) {
                        Spacer()
                        ProgressBar(text: "2 of 4", barValue: 0.50)
                        NavigationLink(destination: SignupView3(), isActive: $nextTapped) {
                            Button(action: {
                            }) {
                                NextButtonNameView(nameText: $nameText)
                                    .onTapGesture {
                                        if nameText.count > 3 {
//                                            UserDefaults.standard.set(nameText, forKey: "name")

                                            self.nextTapped.toggle()
                                        }
                                    }
                            }
                        }
                        .disabled(nameText.isEmpty)
                    }
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

struct SignupView2_Previews: PreviewProvider {
    static var previews: some View {
        SignupView2()
    }
}


struct NameTextField: View {
    @Binding var nameText: String
    var body: some View {
        HStack {
            TextField("Name", text: $nameText)
                .frame(height: 20)
            if !nameText.isEmpty {
                Button(action: {
                    self.nameText = ""
                } ) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.init(.displayP3, red: 100/255, green: 100/255, blue: 100/255, opacity: 0.5))
                }
            }
        }
        .padding(.horizontal, 30)
    }
}

struct NextButtonNameView: View {
    @Binding var nameText: String

    var body: some View {
        if nameText.isEmpty || nameText.count < 4 {
            GreyNextButton(text: "Next")
        }
        else {
           GreenNextButton(text: "Next")
        }
    }
}
