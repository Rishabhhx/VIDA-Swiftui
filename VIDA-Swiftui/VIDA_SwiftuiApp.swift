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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
