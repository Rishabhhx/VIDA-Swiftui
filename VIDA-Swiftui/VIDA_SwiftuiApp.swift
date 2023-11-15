//
//  VIDA_SwiftuiApp.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 25/08/22.
//

import SwiftUI

@main
struct VIDA_SwiftuiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.object(forKey: "Status") as? String == "Logedin" {
                TabBarView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                OnboardingView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
//            TabBarView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
