//
//  PopupYesNoView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 18/09/22.
//

import SwiftUI

struct PopupYesNoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var text1 : String = "Are you sure?"
    var text2 : String = "You will lose all your changes."

    let yesButtonPressed : () -> Void
    let noButtonPressed : () -> Void
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Image("kvida-logo")
                    .resizable()
                    .foregroundColor(Color(red: 36/255, green: 62/255, blue: 54/255))
                    .frame(width: 64, height: 71)
                VStack(alignment: .center) {
                    Text(text1)
                    Text(text2)
                }
                .font(.custom("Gill Sans", size: 16))
                HStack(spacing: 20) {
                    Button(action: {
                        noButtonPressed()
                    }) {
                        Text("No")
                            .frame(width: 110, height: 44)
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black))
                    }
                    Button(action: {
                        yesButtonPressed()
                    }) {
                        Text("Yes")
                            .frame(width: 110, height: 44)
                            .background(RoundedRectangle(cornerRadius: 12)
                                .fill(Color.init(.displayP3, red: 36/255, green: 62/255, blue: 54/255, opacity: 1.0)))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                    }
                   
                }
            }
            .padding(30)
            .background(.white)
            .cornerRadius(20)
            
        }
        .transition(.move(edge: .bottom))
        .animation(.easeInOut)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
    }
}

struct PopupYesNoView_Previews: PreviewProvider {
    static var previews: some View {
        PopupYesNoView(yesButtonPressed: {}, noButtonPressed: {})
    }
}
