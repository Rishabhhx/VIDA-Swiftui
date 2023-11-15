//
//  PrivacyView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 09/11/22.
//

import SwiftUI

enum PdfType {
    case privacy
    case terms
}

struct PrivacyTermsView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var model = WebViewModel()
    var urlType : PdfType = .privacy
    
    var body: some View {
        VStack {
            HStack {
                Image("kblackCross")
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
            }
            .frame(height: 65)
            .padding(.horizontal, 30)
            WebView(webView: model.webView)
                .onAppear {
                    model.urlString = urlType == .privacy ? "https://www.vidatravelapp.com/doc/privacy-policy.pdf" : "https://www.vidatravelapp.com/doc/terms-conditions.pdf"
                    model.loadUrl()
                }
                .ignoresSafeArea(edges: .bottom)
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

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyTermsView()
    }
}
