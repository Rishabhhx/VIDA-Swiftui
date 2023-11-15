//
//  SupportView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 18/11/22.
//

import SwiftUI

struct SupportView: View {
    @Environment(\.dismiss) private var dismiss

    @State var supportIssue : String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("Support")
                .font(.custom("Gill Sans", size: 25))
                .fontWeight(.bold)
            IssueField(supportIssue: $supportIssue)
            Button(action: {}) {
                SubmitButtonView(text: $supportIssue)
                    .onTapGesture {
                        dismiss()
                    }
            }
            .disabled(supportIssue.count < 5)

            Button(action: {}) {
                CancelClearButton()
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
        .padding()
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
struct CancelClearButton: View {
    var text : String = "Cancel"
    var body: some View {
        Text(text)
            .font(.custom("Gill Sans", size: 20))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: 58)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 0.8))
    }
}

struct SubmitButtonView: View {
    @Binding var text: String
    
    var body: some View {
        if text.count < 5 {
            GreyNextButton(text: "Submit", bottom: 0, horizontal: 0)
        }
        else {
            GreenNextButton(text: "Submit", bottom: 0, horizontal: 0)
        }
    }
}

struct IssueField: View {
    @Binding var supportIssue : String
    var body: some View {
        TextField("Write an issue", text: $supportIssue, axis: .vertical)
            .onReceive(supportIssue.publisher.collect()) {
                self.supportIssue = String($0.prefix(400))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(.secondary, lineWidth: 0.4))
    }
}
