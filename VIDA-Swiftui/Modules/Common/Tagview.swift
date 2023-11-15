//
//  Tagview.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 01/09/22.
//

import SwiftUI

struct TagView: View {
    @State var tags: [TagViewItem]
    @State private var totalHeight = CGFloat.zero       // << variant for ScrollView/List //    = CGFloat.infinity   // << variant for VStack
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(tags.indices) { index in
                item(for: tags[index].title, isSelected: tags[index].isSelected)
                    .padding([.horizontal, .vertical], 6)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tags[index].title == self.tags.last!.title {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tags[index].title == self.tags.last!.title {
                            height = 0 // last item
                        }
                        return result
                    }).onTapGesture {
                        tags[index].isSelected.toggle()
                    }
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func item(for text: String, isSelected: Bool) -> some View {
        Text(text)
            .font(.custom("Gill Sans", size: 20))
            .foregroundColor(isSelected ? Color.black : Color.black)
            .padding(.all, 12)
            .lineLimit(1)
            .background(isSelected ? Color(.displayP3, red: 216/255, green: 235/255, blue: 227/255, opacity: 100) : Color.clear)
            .frame(height: .infinity)
            .cornerRadius(30)
            .overlay(Capsule().stroke(isSelected ? Color.clear : Color.secondary, lineWidth: 0.4))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct TagViewItem: Hashable {
    
    var title: String
    var isSelected: Bool
    
    static func == (lhs: TagViewItem, rhs: TagViewItem) -> Bool {
        return lhs.isSelected == rhs.isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(isSelected)
    }
}
