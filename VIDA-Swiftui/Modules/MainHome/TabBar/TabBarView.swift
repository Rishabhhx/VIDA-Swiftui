//
//  TabBarView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 12/09/22.
//

import SwiftUI
enum Tabs {
    case home
    case search
    case create
    case list
    case profile
}

struct TabBarItemData {
    var tag: Int
    var content: AnyView
}

struct TabBarPreferenceData {
    var tabBarBounds: Anchor<CGRect>? = nil // 1
    var tabBarItemData: [TabBarItemData] = []
}

struct TabBarPreferenceKey: PreferenceKey {
    typealias Value = TabBarPreferenceData
    
    static var defaultValue: TabBarPreferenceData = TabBarPreferenceData()
    
    static func reduce(value: inout TabBarPreferenceData, nextValue: () -> TabBarPreferenceData) {
        if let tabBarBounds = nextValue().tabBarBounds {
            value.tabBarBounds = tabBarBounds
        }
        value.tabBarItemData.append(contentsOf: nextValue().tabBarItemData)
    }
}

struct TabBarView: View {
    @State private var mainSelection: Int = 0
    @State var isPresenting : Bool = false
    @State var selectedTab = 0
    @State private var oldSelectedItem = 0
    
    init() {
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .lastTextBaseline) {
                CustomTabBarItem( iconName: mainSelection == 0 ? "ktabBarFirstItemSelected" : "ktabBarFirstItemUnselected",
                                  label: "",
                                  selection: $mainSelection,
                                  tag: 0)
                {
                    HomeView()
                        .onAppear() {
                            self.oldSelectedItem = 0
                        }
                }
                CustomTabBarItem(iconName: mainSelection == 1 ? "ktabBarSecondItemSelected" : "ktabBarSecondItemUnselected",
                                 label: "",
                                 selection: $mainSelection,
                                 tag: 1)
                {
                    SearchView()
                        .onAppear() {
                            self.oldSelectedItem = 1
                        }
                }
                CustomTabBarItem(iconName: "ktabBarThirdItem",
                                 label: "",
                                 selection: $mainSelection,
                                 tag: 2)
                {
                    if oldSelectedItem == 0 {
                        HomeView()
                    } else if oldSelectedItem == 1 {
                        SearchView()
                    }
                }
                .onChange(of: mainSelection) {
                    if 2 == mainSelection {
                            self.isPresenting = true
                    } else {
                        self.oldSelectedItem = $0
                    }
                }
                .fullScreenCover(isPresented: $isPresenting, onDismiss: {
                    self.mainSelection = self.oldSelectedItem
                })
                {
                    CreateExperienceView()
                }
                
                CustomTabBarItem(iconName: mainSelection == 3 ? "ktabBarFourthItemSelected" : "ktabBarFourthItemUnselected",
                                 label: "",
                                 selection: $mainSelection,
                                 tag: 3)
                {
                    SavedListView()
                        .onAppear() {
                            self.oldSelectedItem = 3
                        }
                }
                CustomTabBarItem(iconName: mainSelection == 4 ? "ktabBarFifthItemSelected" : "ktabBarFifthItemUnselected",
                                 label: "",
                                 selection: $mainSelection,
                                 tag: 4)
                {
                    ProfileView()
                }
            }
            .background(
                GeometryReader { parentGeometry in
                    Rectangle()
                        .fill(Color(UIColor.white))
                        .frame(width: parentGeometry.size.width, height: 0.5)
                        .position(x: parentGeometry.size.width / 2, y: 0)
                }
            )
            .background(Color(UIColor.white))
            .transformAnchorPreference(key: TabBarPreferenceKey.self,
                                       value: .bounds,
                                       transform: { (value: inout TabBarPreferenceData, anchor: Anchor<CGRect>) in
                value.tabBarBounds = anchor
            }) // 2
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .overlayPreferenceValue(TabBarPreferenceKey.self) { (preferences: TabBarPreferenceData) in
            return GeometryReader { geometry in
                self.createTabBarContentOverlay(geometry, preferences)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .hideKeyboardWhenTappedAround()
    }
    private func createTabBarContentOverlay(_ geometry: GeometryProxy,
                                            _ preferences: TabBarPreferenceData) -> some View {
        let tabBarBounds = preferences.tabBarBounds != nil ? geometry[preferences.tabBarBounds!] : .zero // 3
        let contentToDisplay = preferences.tabBarItemData.first(where: { $0.tag == self.mainSelection })
        
        return ZStack {
            if contentToDisplay == nil {
                Text("Empty View")
            } else {
                contentToDisplay!.content
            }
        }
        .frame(width: geometry.size.width,
               height: geometry.size.height - tabBarBounds.size.height,
               alignment: .center)
        .position(x: geometry.size.width / 2,
                  y: (geometry.size.height - tabBarBounds.size.height) / 2) // 6
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
