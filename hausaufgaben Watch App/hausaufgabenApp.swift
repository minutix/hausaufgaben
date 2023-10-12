//
//  hausaufgabenApp.swift
//  hausaufgaben Watch App
//
//  Created by Linus Warnatz on 12.10.23.
//

import SwiftUI

@main
struct hausaufgaben_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Homework.self)
    }
}
