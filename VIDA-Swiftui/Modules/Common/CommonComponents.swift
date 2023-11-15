//
//  CommonComponents.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 31/08/22.
//

import SwiftUI

struct BackgroundImage: View {
    var image: String = "greenGradientBg"
    var body: some View {
        Image(image)
            .resizable()
            .ignoresSafeArea()
    }
}

struct GreyNextButton: View {
    var text : String = "Next"
    var bottom : CGFloat = 60
    var horizontal : CGFloat = 30
    var body: some View {
        Text(text)
            .font(.custom("Gill Sans", size: 20))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 58)
            .background(Color.init(.displayP3, red: 100/255, green: 100/255, blue: 100/255, opacity: 0.2))
            .cornerRadius(12)
            .padding(.horizontal, horizontal)
            .padding(.bottom, bottom)
    }
}

struct GreenNextButton: View {
    var text : String = "Next"
    var bottom : CGFloat = 60
    var horizontal : CGFloat = 30
    var body: some View {
        Text(text)
            .font(.custom("Gill Sans", size: 20))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 58)
            .background(Color.init(.displayP3, red: 36/255, green: 62/255, blue: 54/255, opacity: 1.0))
            .cornerRadius(12)
            .padding(.horizontal, horizontal)
            .padding(.bottom, bottom)
    }
}

struct ViewHeading: View {
    var text : String = "Next"
    var size : CGFloat = 32
    var topPadding : CGFloat = 30

    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .font(.custom("Gill Sans", size: size))
            .padding(.top, topPadding)
            .padding(.leading, 30)
    }
}

struct ToastMessage: View {
    @Binding var req : Bool
    var text : String = ""

    var body: some View {
        Text(text)
            .font(.custom("Gill Sans", size: 15))
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 30)
                .fill(Color(red: 0, green: 0, blue: 0, opacity: 0.5)))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.req = false
                    }
                }
            }
    }
}

struct ProgressBar: View {
    var text : String = ""
    var barValue : Float = 0.25

    var body: some View {
        VStack(alignment: .trailing) {
            Text(text)
                .padding(.horizontal, 30)
                .font(.custom("Gill Sans", size: 14))
            ProgressView(value: barValue)
                .tint(Color.init(.displayP3, red: 36/255, green: 62/255, blue: 54/255, opacity: 1.0))
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
        }
    }
}

struct ButtonCustom: View {
    var text : String = "Done"
    var corner : CGFloat = 32
    var color : Color = Color(.displayP3, red: 208/255, green: 231/255, blue: 220/255)
    var body: some View {
        Text(text)
            .fontWeight(.light)
            .font(.custom("Gill Sans", size: 20))
            .frame(height: 32)
            .padding(.horizontal,15)
            .background(color)
            .cornerRadius(corner)
    }
}

struct BackButtonView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack() {
            Image("chevron-back")
                .padding(.leading, 30)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Spacer()
        }
        .padding(.top, 40)
    }
}

struct SearchTags: View {
    var tagName : String = "Locations"
    var body: some View {
        Text(tagName)
            .padding(.horizontal, 15)
            .font(.custom("Gill Sans", size: 14))
            .padding(.vertical, 6)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black))
    }
}

struct SelectedSearchTags: View {
    var tagName : String = "Locations"
    var body: some View {
        Text(tagName)
            .padding(.horizontal, 15)
            .font(.custom("Gill Sans", size: 14))
            .padding(.vertical, 6)
            .background(Color(.displayP3, red: 218/255, green: 237/255, blue: 227/255))
            .cornerRadius(20)
        
    }
}

extension View {
    func hideKeyboardWhenTappedAround() -> some View  {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                  to: nil, from: nil, for: nil)
        }
    }
}
