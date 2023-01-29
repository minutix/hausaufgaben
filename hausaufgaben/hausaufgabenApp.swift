//
//  hausaufgabenApp.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
//

import SwiftUI
import UserNotifications

@main
struct hausaufgabenApp: App {
    // Init CoreData
    let persistenceController = PersistenceController.shared
    // Define a Notification Center
    let center = UNUserNotificationCenter.current()
    
    
    init() {
        // Request authorization for provisional (i.e. demo) notifications
        center.requestAuthorization(options: [.sound, .alert, .badge, .provisional]) { granted, error in
            /*
            if let error = error {
                //TODO: Handle error
            }
            */
            //TODO: Handle success
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
