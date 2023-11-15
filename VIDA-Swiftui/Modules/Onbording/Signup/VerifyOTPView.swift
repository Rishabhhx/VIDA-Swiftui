//
//  VerifyOTPView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 27/08/22.
//

import SwiftUI

struct VerifyOTPView: View {
    
    var body: some View {
        VStack {
            ZStack {
                BackgroundImage()
                VerifyOTP()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
        .hideKeyboardWhenTappedAround()
    }
}

struct VerifyOTPView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyOTPView()
    }
}

struct NextButtonVerifyOTPView: View {
    
    var body: some View {
        
        Text("Submit")
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 58)
            .background(Color.init(.displayP3, red: 36/255, green: 62/255, blue: 54/255, opacity: 1.0))
            .cornerRadius(12)
            .padding(.horizontal, 30)
            .padding(.bottom, 60)
    }
}

struct VerifyOTP: View {
    @State var userNameReq : Bool = false
    @State var otp = "1111"
    @State var nextTapped : Bool = false
    @StateObject private var viewModel = ViewModel()
    @State var isFocused = false
    @State var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let textBoxWidth = 40
    let textBoxHeight = 40
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                BackButtonView()
                ViewHeading(text: "Email Verification")
                VStack(alignment: .leading) {
                    ZStack {
                        HStack (spacing: spaceBetweenBoxes){
                            otpText(text: viewModel.otp1)
                            otpText(text: viewModel.otp2)
                            otpText(text: viewModel.otp3)
                            otpText(text: viewModel.otp4)
                        }
                        TextField("", text: $viewModel.otpField)
                            .disabled(viewModel.isTextFieldDisabled)
                            .textContentType(.oneTimeCode)
                            .foregroundColor(.clear)
                            .accentColor(.clear)
                            .background(Color.clear)
                            .keyboardType(.numberPad)
                            .frame(width: 200, height: 40, alignment: .leading)
                    }
                    .padding(.leading,30)
                    if timeRemaining != 0 {
                        HStack(alignment: .center) {
                            Image(systemName: "clock")
                            Text("0:\(timeRemaining)")
                                .onReceive(timer) { _ in
                                    if timeRemaining > 0 {
                                        timeRemaining -= 1
                                    }
                            }
                        }
                        .foregroundColor(Color.init(.displayP3, red: 76/255, green: 177/255, blue: 54/255, opacity: 1.0))
                        .padding(.all, 30)
                    }
                    else {
                        Button(action: {
                            timeRemaining = 60
                        }) {
                            Text("RESEND EMAIL")
                                .font(.custom("Gill Sans", size: 20))
                                .padding(.all, 30)
                        }
                        .foregroundColor(.gray)
                    }
                    VStack(alignment: .center) {
                        if userNameReq {
                            Text("Enter correct OTP")
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 30)
                                .foregroundColor(.red)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            self.userNameReq = false
                                        }
                                    }
                                }
                        }
                    }
                }
                Spacer()
            }
            VStack(alignment: .trailing) {
                Spacer()
                NavigationLink(destination: RegionActivityView(), isActive: $nextTapped) {
                    Button(action: {
                    }) {
                        SubmitOtpButtonView(otp: $viewModel.otpField)
                            .onTapGesture {
                                if otp == viewModel.otpField {
                                    self.nextTapped.toggle()
                                }
                                else {
                                    self.userNameReq = true
                                }
                            }
                    }
                }
                .disabled(viewModel.otpField.count < 4)
            }
        }
        .padding(.top, 40)
    }
    private func otpText(text: String) -> some View {
        
        return Text(text)
            .font(.title)
            .frame(width: 40, height: 40)
            .background(VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 1)
                    .frame(height: 0.5)
            })
            .padding(paddingOfBox)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
struct SubmitOtpButtonView: View {
    @Binding var otp: String
    
    var body: some View {
        if otp.count < 4 {
            GreyNextButton(text: "Submit")
        }
        else {
            GreenNextButton(text: "Submit")
        }
    }
}
