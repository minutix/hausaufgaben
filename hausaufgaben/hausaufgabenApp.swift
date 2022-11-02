//
//  hausaufgabenApp.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
//

import SwiftUI

@main
struct hausaufgabenApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
