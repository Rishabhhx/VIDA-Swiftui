//
//  ActivityView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 01/09/22.
//

import SwiftUI

struct ActivityView: View {
    @State var continueToDiscorver : Bool = false
    var headingText : String = "What activites do you enjoy is the most when travelling"
    var ActiviteiesArray : [String] = ["Golf","Carting","Hiking","Paint Ball"]
    var body: some View {
        
        ZStack {
            BackgroundImage()
            VStack {
                RegionOrActivites(headingText: headingText, regionsArray: ActiviteiesArray)
                Spacer()
                NavigationLink(destination: DiscoverTravelersView(), isActive: $continueToDiscorver) {
                    Button(action: {}) {
                        GreenNextButton(text: "Continue")
                            .onTapGesture {
                                self.continueToDiscorver.toggle()
                            }
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
