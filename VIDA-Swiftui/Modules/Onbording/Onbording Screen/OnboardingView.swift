//
//  ContentView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 25/08/22.
//

import SwiftUI
import CoreData

struct OnboardingView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    BackgroundView()
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        Logo()
                        Spacer()
                        Discription()
                        Buttons()
                    }
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct SignUpButton: View {
    var body: some View {
        Text("Sign up")
            .frame(width: UIScreen.main.bounds.width - 70, height: 58)
            .background(.white)
            .foregroundColor(.black)
            .cornerRadius(12)
            
    }
}

struct LoginButton: View {
    var body: some View {
        Text("Login")
            .frame(width: UIScreen.main.bounds.width - 70, height: 58)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

struct Logo: View {
    var body: some View {
        Image("kvida-logo")
            .foregroundColor(.white)
            .padding(.top, 30)
    }
}

struct Discription: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Spacer()
            Spacer()
            VStack {
                Text("Discover, save, and share travel experiences")
                    .font(.custom("Gill Sans", size: 32.0))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(width: UIScreen.main.bounds.width - 90, alignment: .leading)
            HStack {
                Image("kpage_control_selected")
                Image("kpage_control_unselected")
                Image("kpage_control_unselected")
            }
            .foregroundColor(.white)
            .padding(.top, 30)
            Spacer()
        }
        .padding(.trailing, 50)
    }
}

struct Buttons: View {
    @State var pushView = false
    @State var pushView2 = false

    var body: some View {
        VStack(spacing: 10) {
            NavigationLink(destination: SignupView(), isActive: $pushView) {
                Button(action: {
                }) {
                    SignUpButton()
                        .onTapGesture {
                            self.pushView.toggle()
                        }
                        .navigationTitle("")
                        .navigationBarHidden(true)
            }
            }
            NavigationLink(destination: LoginView(), isActive: $pushView2) {
                Button(action: {
                }) {
                    LoginButton()
                        .onTapGesture {
                            self.pushView2.toggle()
                        }
                        .navigationTitle("")
                        .navigationBarHidden(true)
            }
            }
        }
        .padding(.bottom, 60)
    }
}

struct BackgroundView: View {
    @State var pageIndex = 0
    public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    var backgroundImages : [String] = ["konboard-slide-show-img-1","konboard-slide-show-img-2","konboard-slide-show-img-3"]
    var body: some View {
        Text("current page = \(pageIndex) ")
        TabView(selection: $pageIndex) {
            ForEach(backgroundImages.indices, id: \.self) { image in
                Image(backgroundImages[image])
                    .resizable()
                    .ignoresSafeArea()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onReceive(timer, perform: { _ in
            withAnimation {
                pageIndex = pageIndex < backgroundImages.count ? pageIndex + 1 : 0
            }
        })
    }
}
