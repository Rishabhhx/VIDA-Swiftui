//
//  ArticlesDetailView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 09/09/22.
//

import SwiftUI

struct ArticlesDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @StateObject private var model = WebViewModel()
    @State var forwardDisabled : Bool = true
    @State var url : String = "https://www.apple.com"
    var title : String = ""
    var body: some View {
        VStack {
            HStack {
                Image("kblackCross")
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                VStack {
                    Text("Asdas")
                        .font(.custom("Gill Sans", size: 18))
                    Text(model.urlString)
                        .font(.custom("Gill Sans", size: 15))
                        .foregroundColor(Color.secondary)
                }
                Spacer()
            }
            .frame(height: 65)
            .padding(.horizontal, 30)
            WebView(webView: model.webView)
                .onAppear {
                    model.urlString = url
                    model.loadUrl()
                }
            HStack {
                Button(action: {
                    forwardDisabled = false
                    model.back()
                }) {
                    Image("kwebview-back")
                }
                Spacer()
                Button(action: {
                    forwardDisabled = true
                    model.forward()
                }) {
                    if forwardDisabled {
                        Image("kwebview-forward")
                            .foregroundColor(Color.secondary)
                    }
                    else {
                        Image("kwebview-forward")
                    }
                }
                .disabled(forwardDisabled)
                Spacer()
                Button(action: {actionSheet()}) {
                    Image("kwebview-share")
                }
                Spacer()
                Link(destination: URL(string: model.urlString)!) {
                    Image("kwebview-safari")
                }
            }
            .frame(height: 65)
            .padding(.horizontal, 30)
        }
        
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    func actionSheet() {
        guard let urlShare = URL(string: model.urlString) else { return }
           let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
       }
}

struct ArticlesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesDetailView()
    }
}


