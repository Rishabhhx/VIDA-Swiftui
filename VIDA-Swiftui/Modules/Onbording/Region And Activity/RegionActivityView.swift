//
//  RegionActivityView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 01/09/22.
//

import SwiftUI

struct RegionActivityView: View {
    
    @State var continueToActivity : Bool = false
    

    var body: some View {
        ZStack {
            BackgroundImage()
            VStack(alignment: .leading) {
                RegionOrActivites()
                Spacer()
                NavigationLink(destination: ActivityView(), isActive: $continueToActivity) {
                    Button(action: {}) {
                        GreenNextButton(text: "Continue")
                            .onTapGesture {
                                self.continueToActivity.toggle()
                            }
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct RegionActivityView_Previews: PreviewProvider {
    static var previews: some View {
        RegionActivityView()
    }
}

struct RegionOrActivites: View {
    var headingText : String = "What region(s) interest you most to travel?"
    var regionsArray : [String] = ["North East","Delhi","Assam","Tamil Naddu"]
    var body: some View {
        VStack {
            BackButtonView()
            ViewHeading(text: headingText)
            TagView(tags: [TagViewItem(title: regionsArray[0], isSelected: false), TagViewItem(title: regionsArray[1], isSelected: false), TagViewItem(title: regionsArray[2], isSelected: false), TagViewItem(title: regionsArray[3], isSelected: false),])
                .padding()
        }
    }
}
