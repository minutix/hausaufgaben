//
//  hausaufgaben_watchApp.swift
//  hausaufgaben-watch Watch App
//
//  Created by Linus Warnatz on 04.12.23.
//

import SwiftUI

@main
struct hausaufgaben_watch_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Homework.self)
    }
}
