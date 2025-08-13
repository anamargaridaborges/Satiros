//
//  SatirosApp.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 13/08/25.
//

import SwiftUI

@main
struct SatirosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
